From: neko@bakuhatsu.net (Matt Sealey)
Date: Wed, 30 Oct 2013 13:01:15 -0500
Subject: imx-drm: Add HDMI support
In-Reply-To: <1382039535.976669051@f130.i.mail.ru>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
Message-ID: <CAHCPf3viBN5RwxPYGN_gMhbgbJbwJAQDJKHHYFyLUFBqvsFztg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 2:52 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
>> > Little bit late to the party, but here is the patch for the latest
>> > version of the HDMI driver I was working on. Having had a quick flick
>> > through the mailing list I see Russell has noticed a few of the problems
>> > I had earlier on, which are resolved in my later work. Thought this
>> > might be useful to help you tidy things up.
> ...
>> Now, I notice that the FSL 4.1.0 stuff appears to try and decide
>> which of the two clock inputs to use for the DI module, something
>> which isn't done in the driver in staging.  Also there's the commented
>> out stuff:
>>
>> #ifdef WTF_IS_THIS
>>         /*
>>          * Freescale has this in their Kernel. It is neither clear what
>>          * it does nor why it does it
>>          */
>>         if (div & 0x10)
>>                 div &= ~0x7;
>>         else {
>>                 /* Round up divider if it gets us closer to desired pix clk */
>>                 if ((div & 0xC) == 0xC) {
>>                         div += 0x10;
>>                         div &= ~0xF;
>>                 }
>>         }
>> #endif

There's another twiddle it does in another function:

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/mxc/ipu3/ipu_disp.c?h=imx_3.0.35_4.1.0#n76

>> Quite simply, the "div" value is as follows:
>>
>> bits 11:4 - integer divider
>> bits  3:0 - fractional part
>>
>> So, what this is saying is that for any _odd_ integer divider, we want
>> to either divide by the odd divider, or odd.5 - but no other fractional
>> values.  Otherwise, if the divider is an even integer divider, and the
>> fractional part is greater than .75, we want to round that up.  (It may
>> also be that the final div & ~0xf should be outside that second if
>> statement.)
>>
>> It could be that the fractional divider is broken and doesn't work
>> correctly with the values that this is trying to avoid.

It's flakey but it works.

I had the same conversations with Sascha about a year ago, and then
again about 9 months ago.. "works for me" was the result.

Russell hit the nail on the head; this is the code Freescale's driver
does that the staging driver doesn't.

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/mxc/ipu3/ipu_disp.c?h=imx_3.0.35_4.1.0#n1258

Essentially the fractional divider works, but not on the IPU HSC
clock, because it's not fast enough to generate the correct rate
without using the fractions. 1/16th variance in frequency than
requested is WAY out of VESA specification for monitors. Some older
monitors are even a tiny bit more strict on certain modes where you're
hitting the very limits of their capability (at or past 1080p). You
should be tending to provide the exact clock, except for extremely low
resolutions (PAL, NTSC, QVGA panels kind of low) where the rate is so
low usually the hardware is able to sort out the mess. I seem to
remember it needs to be within 2% - 1 bit extra on the fraction and
you're 3 times that over the range of accectable clocks monitors MUST
accept by specification.

The solution on i.MX51 is use PLL3 as a dedicated video PLL, but you
can't use this as the DI external clock for both DIs unless they share
a mode (or have a common denominator for the frequency so you can set
the dividers right and PLL3 can stay at an acceptable rate). There are
some clever hacks we could do around it but so few i.MX devices have
more than one active video output at once. Unfortunately that moves
everything that defaults as parenting from PLL3 as the clock rate will
change on hotplugging HDMI, which could make USB stop working so well,
and a bunch of other stuff.

On i.MX51, too, the IPU HSC can't go above 133MHz without making the
system unstable, so any mode that needs 148MHz (most high HDMI modes)
won't work.

The fix was on i.MX50 and i.MX53 - they have a dedicated PLL4, put
there almost purely for video ;) and the IPU clock goes up to 150MHz.
And that continued with the i.MX6 (which can do 200MHz and has more
PLLs to parent from).

There's no good reason to use the DI internal clock from IPU HSC,
unless you can guarantee an EXACT rate coming out (i.e. if you need
64MHz, then you can get that with 128MHz/2.0 - which is fine.) *or*
you need to output to TVE or LDB which require that you use their
clocks as DI parent for synchronization (which is usually fine as it's
able to get the accuracy you need, or it just doesn't matter in these
cases). For any other case you *MUST* use the external clock or you
violate VESA specs.

--
Matt Sealey <neko@bakuhatsu.net>
