From: dianders@chromium.org (Doug Anderson)
Date: Fri, 4 Sep 2015 12:48:02 -0700
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
Message-ID: <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 4, 2015 at 11:21 AM, Doug Anderson <dianders@chromium.org> wrote:
> Russell,
>
> On Sat, Aug 8, 2015 at 9:10 AM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
>> Adjust the pixel clock values in the N calculation to match the more
>> accurate clock values we're given by the DRM subsystem, which are the
>> kHz pixel rate, with any fractional kHz rounded down in the case of
>> the non-240, non-480 line modes, or rounded up for the others.  So,
>>
>>          25.20 / 1.001 =>  25175
>>          27.00 * 1.001 =>  27027
>>          74.25 / 1.001 =>  74176
>>         148.50 / 1.001 => 148352
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>>  drivers/gpu/drm/bridge/dw_hdmi.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> For what it's worth, I backported this change into my local 3.14-based
> tree and it doesn't cause any problems, though it looks like the code
> isn't being run in my case...
>
> I can confirm that the rates you list match the rates I actually see
> requested by DRM, but in my current tree I've actually got something
> that allows a little bit of "slop" in HDMI rates because my system
> can't actually always make exactly the modes requested, but it appears
> that getting "close enough" works, especially if your clock jitter is
> low enough (because the sink needs to have a little bit of wiggle room
> for jitter anyway).  For instance, when 25.175 is requested we
> actually end up making 25.170732.
>
> In my tree this adjustment happens in mode_fixup by changing the
> adj_mode.  In one particular case, some debug prints show:
>   640x480, mode=25200000, adj=25171000, actual=25170732
>   freq=48000, pixel_clk=25171000, n=6144
>
> I'm not enough of an HDMI expert to say whether it's better to be
> using n=6144 or n=6864 in this case, but audio does play with either
> on the TV I tested.
>
> In any case, I'd say that your change at least makes things better
> than they were, so I'd be in favor of taking it.  If someone later
> decides that we should add a little margin to these numbers, then a
> patch to add that could go atop yours.

Oh!  I just figured this out!  :)

Basically the spec is saying that you want both N and CTS to be
integral.  ...as you say you really want:
  CTS = (TMDS * N) / (128 * audio_freq)

...CTS has no other restrictions (other than being integral) and
you're allowed a bit of slop for N (you aim for 128 * audio_freq but
can go up or down a bit).
...and the TMDS frequency has no such restrictions for being integral
in their calculations.

Apparently it's more important to optimize for the CTS formula working
out then it is for getting close to "128 * audio freq".  ...and that's
the reason for these special case N values...


So to put some numbers:

We're perfect when we have exactly 25.2:
  25200 * 4096 / (128 * 32)
  => 25200, so CTS for 25.2 MHz is 25200.  Perfect

...but when we have 25.2 / 1.001 we get a non-integral CTS:
  (25200 / 1.001) * 4096 / (128 * 32)
  => 25174.82517482518

...we can get an integral CTS and still remain in range if:
  (25200 / 1.001) * 4576 / (128 * 32)
  => 28125

In the case of Linux, I'm afraid we just don't have this type of
accuracy in our APIs.  The spec is talking about making
25.17482517482518 MHz.  As I said, in my case I'm actually making
25170732.  In your case you're probably making the value that Linux
asked you to make, AKA 25.175000 MHz.  Unsurprisingly, if you do the
calculations with 25.175 MHz (or any integral kHz value) you don't
have to do any special optimization to stay integral:

  25175 * 4096 / (128 * 32)
  => 25175


So unless you have some way to know that the underlying clock is
actually (25.2 / 1.001) MHz and not just 25.175 MHz then your patch
looks wrong.


As a first step I'd suggest just removing all the special cases and
add a comment.  From real world testing it doesn't seem terribly
critical to be slightly off on CTS.  ...and in any case for any clock
rates except the small handful in the HDMI spec we'll be slightly off
on CTS anyway...

As a second step you could actually use the rate from "clk_get_rate()"
to see what clock rate was actually made.  You'll at least get Hz
here.  If you've somehow structured your machine to give you 25174825
Hz when DRM asked for 25175000 Hz (or if you redo the calculations and
ignore what DRM told you), then that would give you this slightly more
optimal rate.

As a third step you could somehow add the more detailed Hz information
to DRM (sounds like a big task, but I'm nowhere near a DRM expert).

As a fourth step you could try to write the code in a generic way to
figure out the best N / CTS to minimize error in the formula while
still staying within the required ranges.  If you did that, it
probably would belong in some generic helper and not in dw_hdmi...


...anyway, I'm not suggestion that you do everything above since I
think just removing the special cases is probably good enough.  ...but
if you wanted everything to be perfect it seems like the way to go.



So I guess remove my Reviewed-by for this patch?


-Doug
