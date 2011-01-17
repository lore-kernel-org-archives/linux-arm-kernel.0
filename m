From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 12:27:22 +0000
Subject: [PATCH] Remove CPU_32v6K dependencies in asm/spinlock.h
In-Reply-To: <AANLkTikrgOLJ0bj_V23i-RM_wYa_4dDTXb_RaPY8Cr8v@mail.gmail.com>
References: <20110115161132.GH15996@n2100.arm.linux.org.uk>
	<AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
	<20110117103739.GA18626@n2100.arm.linux.org.uk>
	<20110117105332.GC18626@n2100.arm.linux.org.uk>
	<AANLkTikrgOLJ0bj_V23i-RM_wYa_4dDTXb_RaPY8Cr8v@mail.gmail.com>
Message-ID: <20110117122722.GA21542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 12:12:55PM +0000, Catalin Marinas wrote:
> On 17 January 2011 10:53, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jan 17, 2011 at 10:37:39AM +0000, Russell King - ARM Linux wrote:
> >> 3. Do we always need a dsb prior to a sev? ?Maybe the SPEAR patches need
> >> another review to determine how they're using sev()?
> >
> > FYI, this is how the SPEAR patches use sev():
> >
> > | +static void __init wakeup_secondary(void)
> > | +{
> > | + ? ? /* nobody is to be released from the pen yet */
> > | + ? ? pen_release = -1;
> > | +
> > | + ? ? /*
> > | + ? ? ?* Write the address of secondary startup into the system-wide
> > | + ? ? ?* location (presently it is in SRAM). The BootMonitor waits
> > | + ? ? ?* for this register to become non-zero.
> > | + ? ? ?* We must also send an sev to wake it up
> > | + ? ? ?*/
> > | + ? ? __raw_writel(BSYM(virt_to_phys(spear13xx_secondary_startup)),
> > | + ? ? ? ? ? ? ? ? ? ? __io_address(SPEAR13XX_SYS_LOCATION));
> > | +
> > | + ? ? mb();
> > | +
> > | + ? ? /*
> > | + ? ? ?* Send a 'sev' to wake the secondary core from WFE.
> > | + ? ? ?*/
> > | + ? ? sev();
> > | +}
> >
> > so the dsb() is inside mb(), before the outer sync call.
> 
> BTW, don't we need some cache flushing for the pen_release?

Which is why I referred to "updated patch" - that's something which
all implementations suffered from until recently.
