From: dianders@chromium.org (Doug Anderson)
Date: Fri, 4 Sep 2015 11:21:45 -0700
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
Message-ID: <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Aug 8, 2015 at 9:10 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Adjust the pixel clock values in the N calculation to match the more
> accurate clock values we're given by the DRM subsystem, which are the
> kHz pixel rate, with any fractional kHz rounded down in the case of
> the non-240, non-480 line modes, or rounded up for the others.  So,
>
>          25.20 / 1.001 =>  25175
>          27.00 * 1.001 =>  27027
>          74.25 / 1.001 =>  74176
>         148.50 / 1.001 => 148352
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/bridge/dw_hdmi.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

For what it's worth, I backported this change into my local 3.14-based
tree and it doesn't cause any problems, though it looks like the code
isn't being run in my case...

I can confirm that the rates you list match the rates I actually see
requested by DRM, but in my current tree I've actually got something
that allows a little bit of "slop" in HDMI rates because my system
can't actually always make exactly the modes requested, but it appears
that getting "close enough" works, especially if your clock jitter is
low enough (because the sink needs to have a little bit of wiggle room
for jitter anyway).  For instance, when 25.175 is requested we
actually end up making 25.170732.

In my tree this adjustment happens in mode_fixup by changing the
adj_mode.  In one particular case, some debug prints show:
  640x480, mode=25200000, adj=25171000, actual=25170732
  freq=48000, pixel_clk=25171000, n=6144

I'm not enough of an HDMI expert to say whether it's better to be
using n=6144 or n=6864 in this case, but audio does play with either
on the TV I tested.

In any case, I'd say that your change at least makes things better
than they were, so I'd be in favor of taking it.  If someone later
decides that we should add a little margin to these numbers, then a
patch to add that could go atop yours.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
