From: dianders@chromium.org (Doug Anderson)
Date: Fri, 4 Sep 2015 19:03:11 -0700
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <20150905002733.GJ21084@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
 <20150905002733.GJ21084@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, Sep 4, 2015 at 5:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 04, 2015 at 04:50:03PM -0700, Doug Anderson wrote:
>> Russell,
>>
>> On Fri, Sep 4, 2015 at 2:24 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> >> In your case you're probably making the value that Linux
>> >> asked you to make, AKA 25.175000 MHz.
>> >
>> > ... which is the spec value.
>>
>> This is where we're not on the same page.  Where in the spec does it
>> say 25.17500 MHz?  I see in the spec:
>>  25.2 / 1.001
>
> Section 4 of CEA-861-B, which defines the video clock rates and their
> accuracy of 0.5%.

Then perhaps you shouldn't be using a switch statement.  You won't
catch all values that are within .05% of (25.2 / 1.001).


>> ...and this is a crucial difference here.  Please double-check my math, but:
>>
>> (25175000 * 4576) / (128 * 32000.)
>> => 28125.1953125
>>
>> (25174825 * 4576) / (128 * 32000.)
>> => 28125.0
>>
>> This calculation is what led to my belief that the goal here is to
>> make an integral CTS.  If you have 25.175 MHZ clock and N of 4576 you
>> _will not_ have an integral CTS.  If you instead have 25.174825 MHz
>> clock and N of 4576 you _will_ have an integral CTS.
>
> Right, but 25.175 is close enough to 25.174825.  Do this calculation:
>
> 25175000 * 4576 / 28125 / 128
>
> That'll give you the resulting audio sample rate, which is 32000.222Hz.
> That's an error of... 0.00069%, which is probably around the typical
> error of your average crystal oscillator.  Really not worth bothering
> with.

OK, so do this calculation:

25175000 * 4096 / 25175 / 128

You get 32000.000000000000000000

I'm not saying there's anything terribly wrong with 32000.222 Hz and
I'm sure it will work just dandy for you.  I'm saying that you're
adding complexity _and_ ending up with a slightly worse rate.

AKA: just replace your entire "compute_n" function with:

return (128 * freq) / 1000;

...and it's 100% simpler _and_ gets you a (marginally) better rate
(assuming you really have 22.175000).  If it was just about a
32000.222 vs 32000 I'd not be saying anything right now.  It's about
adding complexity.


>> Said another way:
>>
>> 1. The reason 25174825 Hz has a different N is to make an integral CTS.
>>
>> 2. If you are indeed making 25175000 then there is no need for a
>> different N to make an integral CTS
>>
>> 3. If you use 4576 for N but you're making 25175000 Hz, you end up in
>> a _worse_ position than if you use the standard 4096 for N.
>
> Total rubbish.  Sorry, but it is.
>
> Follow the code.  Pixel clock is 25175000.  For 32kHz, N will be 4576.
> 25175000 * 4576 = 1.152008e11.  Divide that by the audio clock rate
> (128 * 32000) gives 28125.19531.  Since we're using integer division,
> that gets rounded down to 28125.
>
> DRM uses a clock rate of "25175" to represent 25.2/1.001 modes.  So,
> if your hardware sets a video clock rate of 25.2MHz/1.001, then you
> end up with a sample rate of exactly 32kHz.  If you set exactly
> 25.175MHz, you end up with an approximate 32kHz sample rate - one
> which is 0.00069% in error, which is (excluse the language) fuck all
> different from exactly 32kHz.

Agree that the difference is negligible.

I will say that IMHO the kind folks who wrote the HDMI spec were still
trying their best to make that error 0.00%.  That's entirely the
reason that they have that table and they don't just use "(128 * freq)
/ 1000" for everything.

AKA, I can imagine something like:

Person 1: Is there any reason to pick a N value that's exactly (128 *
freq) / 1000?

Person 2: Not really

Person 1: Hrm, but I notice that I can get a tiny bit more accurate
audio clock when I have a pixel clock of (25.2 / 1.001) if I use a N
that's not (128 * freq) / 1000.  Is that OK?

Person 2: Yeah, go ahead.  Add it to the spec.

Person 1: OK.  I've got some nifty tables I can add.  Cool!  Now we
get exactly the right audio clock.

Person 2: Nice job!

...but I have no idea if that's really true.


> Are you _really_ going to continue arguing over a 0.00069% error?
> If you are, I'm not going to listen anymore - it's soo damned small
> that it's not worth bothering with.  At all.

Well, I think I've adequately expressed my opinion.  If you want to
land your patch, I certainly won't yell.  I think it adds extra
complexity and produces a (marginally) inferior audio rate, but that's
up to the folks who maintain the code to deal with.


>> As a side note: I realized one part of the HDMI spec that isn't trying
>> to make an integral value but still uses a different value for N: 297
>> MHz.  From the DesignWare spec I have it appears that 594 MHz is
>> similar.  For those cases it looks like we have:
>
> 297MHz _does_ work.
>
> 297000000 * 3072 / 222750 = 128 * 32000 exactly.

I guess I didn't express myself clearly enough.  I'm saying that:

* The only reason I can discern for using non "(128 * freq) / 1000" N
values for rates < 297 Mhz is to try to make an integral CTS.

* For rates >= 297 MHz you could make CTS integral and still keep
"(128 * freq) / 1000", but the spec still says to use something
different.  I don't know why.  My formula accurately makes values in
the spec for 297 MHz.


Anyway, I'm about done commenting on this thread.  Feel free to land
this if folks are happy with it, but I'd prefer not to have my
Reviewed-by on it given all that I've discovered.

-Doug
