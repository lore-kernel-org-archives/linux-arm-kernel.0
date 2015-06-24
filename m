From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 24 Jun 2015 15:11:24 -0500
Subject: [PATCH] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <20150622131228.GE1583@arm.com>
References: <1434751734-2178-1-git-send-email-timur@codeaurora.org>
 <20150622131228.GE1583@arm.com>
Message-ID: <558B0EEC.9040504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2015 08:12 AM, Will Deacon wrote:
> I still think we should be disabling userspace access to the DCC if the
> kernel is using it as its console.

I still need help with this.  I know you said a year ago that 
MDSCR_EL1.TDCC needs to be set to disable userspace access.  Where and 
how should I do this?  I can do this:

static int __init hvc_dcc_console_init(void)
{
#ifdef CONFIG_ARM64
	u32 val;

	asm("msr mdscr_el1, %0	"
	"orr %0, %0, #4096	" /* TDCC */
	"msr %0, mdscr_el1	"
	: "=r" (val));
#endif

But this seems clunky.

I am concerned about KVM, though.  There appears to be code in KVM in 
hyp.s and sys_regs.c that touches and/or emulates MDSCR_EL1.

On a side note, it does not appear that ARM32 blocks userspace DCC.  I 
don't see where DBGDSCR.UDCCdis is set.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
