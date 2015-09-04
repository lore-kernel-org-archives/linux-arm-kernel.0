From: dianders@chromium.org (Doug Anderson)
Date: Fri, 4 Sep 2015 16:50:03 -0700
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <20150904212401.GI21084@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, Sep 4, 2015 at 2:24 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> Basically the spec is saying that you want both N and CTS to be
>> integral.  ...as you say you really want:
>>   CTS = (TMDS * N) / (128 * audio_freq)
>
> In the case of software-programmed CTS and N values, they have to be
> integral because there's no such thing as fractional division here.
> The CTS and N values get sent across the HDMI link to the sink, and
> they use those in a PLL like arrangement to derive the audio clock.
>
> More "inteligent" hardware automatically measures the CTS number and
> continually updates the sink, which allows the sink to remain in
> sync with the audio at non-coherent rates.
>
>> ...CTS has no other restrictions (other than being integral) and
>> you're allowed a bit of slop for N (you aim for 128 * audio_freq but
>> can go up or down a bit).
>
> No.  Both CTS and N have to be accurate to generate the correct
> sample rate from the TDMS clock.

I guess by "other" I meant no restrictions other than that, which is
listed above that "CTS = (TMDS * N) / (128 * audio_freq)".  Anyway,
sounds like we're on the same page here...


>> Apparently it's more important to optimize for the CTS formula working
>> out then it is for getting close to "128 * audio freq".  ...and that's
>> the reason for these special case N values...
>
> The "128 * audio freq" is just a recommendation.  Going through the HDMI
> spec's recommended values for various clock rates and sample rates
> reveals that quite a number of them are far from this "recommendation".
>
> So I wouldn't read too much into the "128 * audio freq" thing.

Again, same page.


>> So to put some numbers:
>>
>> We're perfect when we have exactly 25.2:
>>   25200 * 4096 / (128 * 32)
>>   => 25200, so CTS for 25.2 MHz is 25200.  Perfect
>>
>> ...but when we have 25.2 / 1.001 we get a non-integral CTS:
>>   (25200 / 1.001) * 4096 / (128 * 32)
>>   => 25174.82517482518
>>
>> ...we can get an integral CTS and still remain in range if:
>>   (25200 / 1.001) * 4576 / (128 * 32)
>>   => 28125
>
> Correct.  These are the values given in the HDMI specification for each
> of your clock rates you mention above.
>
> You can even use 4096 for N _provided_ the source measures and sends
> the CTS value (that's basically what happens in the case of
> "non-coherent" clocks.)
>
>> In the case of Linux, I'm afraid we just don't have this type of
>> accuracy in our APIs.
>
> We don't have that kind of precision in the DRM API, but we do have the
> precision in the clock API.

Yup.  On the same page.  See my suggestions of using the common clock framework.


>> The spec is talking about making 25.17482517482518 MHz.
>
> +/- 0.5%, according to CEA-861-B.
>
>> As I said, in my case I'm actually making 25170732.
>
> ... which is within 0.02%, so is within spec.

Yup, that's why we're doing it.  Note that total jitter has to be
under +/- 0.5% right?  ...so if you've got error here you've got to
make sure your clock is extra clean I think.


>> In your case you're probably making the value that Linux
>> asked you to make, AKA 25.175000 MHz.
>
> ... which is the spec value.

This is where we're not on the same page.  Where in the spec does it
say 25.17500 MHz?  I see in the spec:
 25.2 / 1.001

...and this is a crucial difference here.  Please double-check my math, but:

(25175000 * 4576) / (128 * 32000.)
=> 28125.1953125

(25174825 * 4576) / (128 * 32000.)
=> 28125.0

This calculation is what led to my belief that the goal here is to
make an integral CTS.  If you have 25.175 MHZ clock and N of 4576 you
_will not_ have an integral CTS.  If you instead have 25.174825 MHz
clock and N of 4576 you _will_ have an integral CTS.

Said another way:

1. The reason 25174825 Hz has a different N is to make an integral CTS.

2. If you are indeed making 25175000 then there is no need for a
different N to make an integral CTS

3. If you use 4576 for N but you're making 25175000 Hz, you end up in
a _worse_ position than if you use the standard 4096 for N.


>> Unsurprisingly, if you do the
>> calculations with 25.175 MHz (or any integral kHz value) you don't
>> have to do any special optimization to stay integral:
>>
>>   25175 * 4096 / (128 * 32)
>>   => 25175
>>
>>
>> So unless you have some way to know that the underlying clock is
>> actually (25.2 / 1.001) MHz and not just 25.175 MHz then your patch
>> looks wrong.
>
> I don't believe you can make that statement.  If you wish to take the
> lack of precision up with the authors of the CEA-861 and HDMI
> specifications, since they "approximate" to the values I have in this
> patch, and are what userspace passes in the mode structures to kernel
> space.

I will repeat my mantra: I'm a visitor here and decidedly not an
expert.  However, from my reading of the HDMI spec shows that the spec
itself is fine.  They are just assuming that you're providing a
25.174825 MHz clock and giving you optimized values for said clock.

If the current driver says that it's providing 25.175000 MHz then you
shouldn't assume that it's actually making 25.174825 MHz


>> As a first step I'd suggest just removing all the special cases and
>> add a comment.  From real world testing it doesn't seem terribly
>> critical to be slightly off on CTS.  ...and in any case for any clock
>> rates except the small handful in the HDMI spec we'll be slightly off
>> on CTS anyway...
>
> They're not "special cases" made up to fit something - they're from the
> tables in the HDMI specification.

They are definitely "special cases".  There is a general rule in the
code you posted (aim for 128 * freq) and these are cases for certain
clocks that are an exception to the general rule.  AKA they are
special cases.

I'm not arguing that there's not a valid reason for these special
cases.  I'm simply arguing that the special cases are likely for a
different situation than the one we're in.

The HDMI spec itself (loosely interpreted) pretty much says: if
there's any doubt, just use the equations--don't use the tables.


> That assumes that the audio and video clocks are coherent.  On iMX6
> hardware using this, the audio is clocked at the rate defined by the
> TDMS clock and the CTS/N values.

I'll admit I haven't looked at the audio section of dw_hdmi much, but
I'd imagine that for all users of this controller / PHY the audio and
video clocks are coherent.

I think in the perfect world we'd be able to generate exactly
25174825.174825177 Hz and we'd use all the rates from the HDMI spec.
and we'd get spot on 32 kHz audio.  ...but I'm simply saying that
we're not in that perfect world yet.

Also note that there are many many rates not in the HDMI spec that
could benefit from similar optimization of trying to adjust N to make
an integral CTS.

---

As a side note: I realized one part of the HDMI spec that isn't trying
to make an integral value but still uses a different value for N: 297
MHz.  From the DesignWare spec I have it appears that 594 MHz is
similar.  For those cases it looks like we have:

if (pixel_clk == 297000000) {
  switch (freq) {
  case 32000:
    return (128 * freq) / 1333;
  case 44100:
  case 48000:
  case 88200:
  case 96000:
  case 176400:
    return (128 * freq) / 1200;
  }
} else if (pixel_clk == 594000000) {
  switch (freq) {
  case 32000:
    return (128 * freq) / 1333;
  case 44100:
  case 88200:
  case 176400:
    return (128 * freq) / 600;
  }
}
