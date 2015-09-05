From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Sep 2015 01:27:33 +0100
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
Message-ID: <20150905002733.GJ21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 04:50:03PM -0700, Doug Anderson wrote:
> Russell,
> 
> On Fri, Sep 4, 2015 at 2:24 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> In your case you're probably making the value that Linux
> >> asked you to make, AKA 25.175000 MHz.
> >
> > ... which is the spec value.
> 
> This is where we're not on the same page.  Where in the spec does it
> say 25.17500 MHz?  I see in the spec:
>  25.2 / 1.001

Section 4 of CEA-861-B, which defines the video clock rates and their
accuracy of 0.5%.

> ...and this is a crucial difference here.  Please double-check my math, but:
> 
> (25175000 * 4576) / (128 * 32000.)
> => 28125.1953125
> 
> (25174825 * 4576) / (128 * 32000.)
> => 28125.0
> 
> This calculation is what led to my belief that the goal here is to
> make an integral CTS.  If you have 25.175 MHZ clock and N of 4576 you
> _will not_ have an integral CTS.  If you instead have 25.174825 MHz
> clock and N of 4576 you _will_ have an integral CTS.

Right, but 25.175 is close enough to 25.174825.  Do this calculation:

25175000 * 4576 / 28125 / 128

That'll give you the resulting audio sample rate, which is 32000.222Hz.
That's an error of... 0.00069%, which is probably around the typical
error of your average crystal oscillator.  Really not worth bothering
with.

> Said another way:
> 
> 1. The reason 25174825 Hz has a different N is to make an integral CTS.
> 
> 2. If you are indeed making 25175000 then there is no need for a
> different N to make an integral CTS
> 
> 3. If you use 4576 for N but you're making 25175000 Hz, you end up in
> a _worse_ position than if you use the standard 4096 for N.

Total rubbish.  Sorry, but it is.

Follow the code.  Pixel clock is 25175000.  For 32kHz, N will be 4576.
25175000 * 4576 = 1.152008e11.  Divide that by the audio clock rate
(128 * 32000) gives 28125.19531.  Since we're using integer division,
that gets rounded down to 28125.

DRM uses a clock rate of "25175" to represent 25.2/1.001 modes.  So,
if your hardware sets a video clock rate of 25.2MHz/1.001, then you
end up with a sample rate of exactly 32kHz.  If you set exactly
25.175MHz, you end up with an approximate 32kHz sample rate - one
which is 0.00069% in error, which is (excluse the language) fuck all
different from exactly 32kHz.

Are you _really_ going to continue arguing over a 0.00069% error?
If you are, I'm not going to listen anymore - it's soo damned small
that it's not worth bothering with.  At all.

The only time that you'd need to worry about it is if you wanted a
super-accurate system, and for that you'd need an atomic clock to
source your system clocks to reduce aging effects, temperature
induced drift, etc, maybe locking the atomic clock to a national
frequency standard like the Anthorn MSF 60kHz transmitter signal
broadcast by the UK National Physics Laboratory.

> >> As a first step I'd suggest just removing all the special cases and
> >> add a comment.  From real world testing it doesn't seem terribly
> >> critical to be slightly off on CTS.  ...and in any case for any clock
> >> rates except the small handful in the HDMI spec we'll be slightly off
> >> on CTS anyway...
> >
> > They're not "special cases" made up to fit something - they're from the
> > tables in the HDMI specification.
> 
> They are definitely "special cases".  There is a general rule in the
> code you posted (aim for 128 * freq) and these are cases for certain
> clocks that are an exception to the general rule.  AKA they are
> special cases.

Sorry, I disagree with you.

> > That assumes that the audio and video clocks are coherent.  On iMX6
> > hardware using this, the audio is clocked at the rate defined by the
> > TDMS clock and the CTS/N values.
> 
> I'll admit I haven't looked at the audio section of dw_hdmi much, but
> I'd imagine that for all users of this controller / PHY the audio and
> video clocks are coherent.

Not if the audio clock comes from an I2S master rather than being
sourced from the HDMI block.

> I think in the perfect world we'd be able to generate exactly
> 25174825.174825177 Hz and we'd use all the rates from the HDMI spec.

To generate something of that accuracy, you'd need something like a
caesium fountain atomic clock.

> and we'd get spot on 32 kHz audio.  ...but I'm simply saying that
> we're not in that perfect world yet.
> 
> Also note that there are many many rates not in the HDMI spec that
> could benefit from similar optimization of trying to adjust N to make
> an integral CTS.

Now go and look at the HDMI spec, where it gives the CTS value for
74.25/1.001 for 32kHz.  That can't be represented by an integer CTS
value, so using this hardware, we can't generate that sample rate
without an error.  We'd use a fixed CTS value of 210937 instead, which
works out at a 0.00024% error.  Again, not worth worrying about.


> 
> ---
> 
> As a side note: I realized one part of the HDMI spec that isn't trying
> to make an integral value but still uses a different value for N: 297
> MHz.  From the DesignWare spec I have it appears that 594 MHz is
> similar.  For those cases it looks like we have:

297MHz _does_ work.

297000000 * 3072 / 222750 = 128 * 32000 exactly.

> 
> if (pixel_clk == 297000000) {
>   switch (freq) {
>   case 32000:
>     return (128 * freq) / 1333;

Plug the numbers in.  128 * 32000 / 1333 = 3072.96 but because we're using
integer math, that's 3072.  Which just happens to be the value in the HDMI
spec.

>   case 44100:
>   case 48000:
>   case 88200:
>   case 96000:
>   case 176400:
>     return (128 * freq) / 1200;

Do the math again.  You get the spec figures for N.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
