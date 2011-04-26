From: rabin@rab.in (Rabin Vincent)
Date: Tue, 26 Apr 2011 20:30:51 +0530
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <201102021700.20683.arnd@arndb.de>
References: <201102021700.20683.arnd@arndb.de>
Message-ID: <BANLkTi=-DFfdiBKZzRBxF-yMJFtWnzuk1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 2, 2011 at 21:30, Arnd Bergmann <arnd@arndb.de> wrote:
> As noticed by Peter Maydell, the EHCI device driver in Linux gets
> miscompiled by some versions of arm-gcc (still need to find out which)
> due to a combination of problems:
>
> 1. In include/linux/usb/ehci_def.h, struct ehci_caps is defined
> with __attribute__((packed)), for no good reason. This is clearly
> a bug and needs to get fixed, but other drivers have the same bug

Was a patch submitted for this?  I couldn't find it in the archives.
U-Boot seems to be fixing this by adding an "aligned(4)" instead
of removing the packed:

http://www.mail-archive.com/u-boot at lists.denx.de/msg51418.html

> and it used to work. The attribute forces byte access on all members
> accessed through pointer dereference, which is not allowed on
> MMIO accesses in general. The specific code triggering the problem
> in Peter's case is in ehci-omap.c:
> ? ? ? ?omap->ehci->regs = hcd->regs
> ? ? ? ? ? ? ? ?+ HC_LENGTH(readl(&omap->ehci->caps->hc_capbase));

In my case it's this writel() in ehci-hub.c that gets chopped into
strbs:

	/* force reset to complete */
	ehci_writel(ehci, temp & ~(PORT_RWC_BITS | PORT_RESET),
				status_reg);
