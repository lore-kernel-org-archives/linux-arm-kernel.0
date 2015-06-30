From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jun 2015 14:51:54 +0100
Subject: [PATCH] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <558B0EEC.9040504@codeaurora.org>
References: <1434751734-2178-1-git-send-email-timur@codeaurora.org>
 <20150622131228.GE1583@arm.com> <558B0EEC.9040504@codeaurora.org>
Message-ID: <20150630135153.GJ27725@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 09:11:24PM +0100, Timur Tabi wrote:
> On 06/22/2015 08:12 AM, Will Deacon wrote:
> > I still think we should be disabling userspace access to the DCC if the
> > kernel is using it as its console.
> 
> I still need help with this.  I know you said a year ago that 
> MDSCR_EL1.TDCC needs to be set to disable userspace access.  Where and 
> how should I do this?  I can do this:

Well, it's up to you to figure out the details, but I'd start by adding
some static inlines to the arch-specific header files for enabling/disabling
userspace access.

>From there, I think I'd get the architecture init code to reset the thing
to "disabled" (so it's disabled regardless of whether we build the hvc_dcc
driver) and then if you wanted to go all-out, we could have a sysfs entry
provided by the driver to toggle it on and off.

> static int __init hvc_dcc_console_init(void)
> {
> #ifdef CONFIG_ARM64
> 	u32 val;
> 
> 	asm("msr mdscr_el1, %0	"
> 	"orr %0, %0, #4096	" /* TDCC */
> 	"msr %0, mdscr_el1	"
> 	: "=r" (val));
> #endif
> 
> But this seems clunky.

Yeah, that's super ugly.

> I am concerned about KVM, though.  There appears to be code in KVM in 
> hyp.s and sys_regs.c that touches and/or emulates MDSCR_EL1.
> 
> On a side note, it does not appear that ARM32 blocks userspace DCC.  I 
> don't see where DBGDSCR.UDCCdis is set.

That's a bug imo.

Will
