From: hunold@linuxtv.org (Michael Hunold)
Date: Tue, 08 Mar 2011 13:30:29 +0100
Subject: Amba CLCD register definitions
In-Reply-To: <20110308093657.GA25874@n2100.arm.linux.org.uk>
References: <4D75EF86.8020103@linuxtv.org>
	<20110308093657.GA25874@n2100.arm.linux.org.uk>
Message-ID: <4D762165.8070705@linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

on 03/08/2011 10:36 AM Russell King - ARM Linux said the following:
> On Tue, Mar 08, 2011 at 09:57:42AM +0100, Michael Hunold wrote:

>> While working on that, I came across the following oddity. The Amba CLCD
>> driver supports both PL110 and PL111 primecells.
>>
>> The PL110 register summary can be found here:
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0161e/I904416.html
> 
> PL110 is rather screwed up because there's various revisions and
> implementations within ARM which have different register layouts and
> register namings.  Eg, you'll find Versatile has a PL110 fitted but has
> the PL111 register layout with IENB and CNTL swapped.

I understand.

> I don't remember the ancestry of the names, but DDI0161D only gives the
> registers long names.  They probably came from an implementation provided
> by ARM in years gone by, which would've been created by those doing
> platform support back in the early days.
> 
> It's only with DDI0161E that they've been given short names.

Ok. These defines are not used in the kernel up to now. Why not change
to the names ARM suggests in their latest technical reference manual?

> I don't think we should change the names just because someone decided to
> add such things to the latest revision of documentation.

I could agree with regard to IENB/IMSC.

But what about STAT==RIS, INTR==MIS and ICR? These are the same for both
PL110 and PL111.

As I said, I'm working on adding VSYNC support and this involves
fiddling with these registers. At the moment, there are no users and
renaming would be easily possible. Then I could use this for both
platforms.

	/* clear pending irq */
	writel(INTR_VCOMP, fb->regs + CLCD_ICR);

If we keep the naming for STAT==RIS, INTR==MIS and ICR, which define
should I use?

And there is no define for ICR for the PL110, which has to be added
anyway. My target hardware is PL110-based and definately has the ICR
register at offset 0x28, which shows that

#define CLCD_PL110_UCUR		0x00000028

is wrong, at least for my hardware. For other hardware that does not
matter, we don't have to enable VSYNC support for any PL11x platform by
default.

Best regards
Michael.
