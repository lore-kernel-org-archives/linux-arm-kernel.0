From: hunold@linuxtv.org (Michael Hunold)
Date: Tue, 08 Mar 2011 09:57:42 +0100
Subject: Amba CLCD register definitions
Message-ID: <4D75EF86.8020103@linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm working on adding support for panning and FBIO_WAITFORVSYNC ioctl to
the Amba CLCD driver.

While working on that, I came across the following oddity. The Amba CLCD
driver supports both PL110 and PL111 primecells.

The PL110 register summary can be found here:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0161e/I904416.html

The PL111 register summary can be found here:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0293c/Chdehhhf.html

In include/linux/amba/clcd.h the following register definitions are made:

#define CLCD_PL110_IENB		0x00000018
#define CLCD_PL110_CNTL		0x0000001c
#define CLCD_PL110_STAT		0x00000020
#define CLCD_PL110_INTR 	0x00000024
#define CLCD_PL110_UCUR		0x00000028
#define CLCD_PL110_LCUR		0x0000002C

#define CLCD_PL111_CNTL		0x00000018
#define CLCD_PL111_IENB		0x0000001c
#define CLCD_PL111_RIS		0x00000020
#define CLCD_PL111_MIS		0x00000024
#define CLCD_PL111_ICR		0x00000028
#define CLCD_PL111_UCUR		0x0000002c
#define CLCD_PL111_LCUR		0x00000030

According to the PL110 register summary, STAT is called RIS as well and
INTR is called MIS as well, similar to the PL111 naming.

UCUR and LCUR definitions are wrong, according to the PL110 register
summary. UCUR should be at 0x2c and LCUR should be at 0x30, the same as
for PL111.

It seems PL110 has an ICR register as well, at 0x28, the same as the PL111.

As a sidenote, IENB is called IMSC in both register summaries, and
indeed CNTL and IENB/IMSC registers are swapped for PL110 and PL111.

So I would propose to rename and reorder the register definitions like this:

#define CLCD_TIM0		0x00000000
#define CLCD_TIM1 		0x00000004
#define CLCD_TIM2 		0x00000008
#define CLCD_TIM3 		0x0000000c
#define CLCD_UBAS 		0x00000010
#define CLCD_LBAS 		0x00000014
#define CLCD_PL110_IMSC		0x00000018
#define CLCD_PL110_CNTL		0x0000001c
#define CLCD_PL111_CNTL		0x00000018
#define CLCD_PL111_IMSC		0x0000001c
#define CLCD_RIS		0x00000020
#define CLCD_MIS		0x00000024
#define CLCD_ICR		0x00000028
#define CLCD_UCUR		0x0000002c
#define CLCD_LCUR		0x00000030

Please note that these registers are currently *not* used in the driver,
so renaming them has not impact on existing code, except for IENB.
Probably this is the reason, why nobody has noticed the naming problems
so far and cared about it.

Comments?

Should I sent a patch that accomplishes this change?

CU
Michael.
