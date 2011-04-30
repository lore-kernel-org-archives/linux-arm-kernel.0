From: swetland@google.com (Brian Swetland)
Date: Sat, 30 Apr 2011 01:44:15 -0700
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <alpine.LFD.2.00.1104291514390.24613@xanadu.home>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104281925500.24613@xanadu.home>
	<20110429075346.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104290814380.24613@xanadu.home>
	<20110429133340.GN5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291514390.24613@xanadu.home>
Message-ID: <BANLkTikd_u0+yyFYG_0FR--430z=LQ61Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 12:43 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:
>>
>> Even the OMAP4 clock data which is supposedly generated from TIs
>> internal hardware database changes on a fairly regular basis. ?You'll
>> find that the per-clk flags get changed, the operations get changed,
>> etc.
>>
>> It doesn't _matter_ how it is represented, it will continue to be patched
>> whether it's structures in a .c file (as it currently is) or whether it's
>> a device tree description for each clock.
>
> If that is the case, the associated drivers have to change as well to be
> in sync with the new flags, etc. ?And to me it is way better to have
> both the data and the drivers maintained in a single place compared to
> the unavoidable bugs that will crop up due to version skews.

This is a one reason why I'm skeptical of the "device tree" approach
and somewhat concerned about a potential future where board files
would vanish, to be replaced by device trees which may well come from
some place disconnected from the kernel that will depend on them being
correct to work.

I live in a world where the bootloader is often a black box and rarely
updated. Mobile device OEMs usually have their own bootloader
(nothing standard nor open source) which is closely tied to their
factory process and testing, etc.  Having to trust the bootloader to
get anything right beyond passing me a machine type, system revision,
and a commandline is pretty scary.  Add to that the fact that
bootloaders often aren't updated in the field (it's the riskiest piece
of the system to update).

The other reason is that I've rarely seen a board spin that didn't
involve some quirky change that would be hard to represent in a static
configuration format.  Oh, you need to power up this level shifter
before you can talk to the back half of that i2c bus, by way of this
gpio over here?  Eventually you end up with something like a byte-code
or forth runtime to handle these cases and then things really get fun
from the "where's the code that does what?!" standpoint.

Brian
