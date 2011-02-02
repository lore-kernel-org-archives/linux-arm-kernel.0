From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 02 Feb 2011 17:10:37 -0500 (EST)
Subject: [PATCH v2] ARM: kexec: selective MMU identity mapping
In-Reply-To: <20110202210925.GD31043@n2100.arm.linux.org.uk>
References: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
	<20110202210925.GD31043@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102021704580.8212@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Feb 2011, Russell King - ARM Linux wrote:

> On Wed, Feb 02, 2011 at 03:43:29PM +0100, Per Fransson wrote:
> > When restarting using the kernel kexec functionality the MMU
> > needs to be turned off. Any code which does this needs to use
> > identity mapped addresses to get reliable results. In the ARM
> > kexec case this identity mapping is done:
> > 
> > - using the page table of the current task
> > 
> > - for all addresses normally used by user space,
> >   i.e. 0x00000000-PAGE_OFFSET
> > 
> > If kexec is used at a kernel crash to collect a core dump this
> > means that we lose important information.
> > 
> > This is what this patches does:
> > 
> > * Actually turns off the MMU, which has been omitted by mistake
> > 
> > * Sets up a more selective identity mapping
> > 
> > * Restores the old mapping once the MMU is off
> > 
> > Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> > ---
> > v2 changes:
> > 
> > * now uses (modified versions of) the identity mapping functions in idmap.c
> >   as they look in 2.6.38-rc1. Some pud-level code has been added there in
> >   linux-next.
> 
> Thanks.  As this been tested with ARMv4/v5 CPUs as well?

I have doubts about the effectiveness of setup_mm_for_reboot() on any 
machine where physical RAM starts at 0xc0000000 or above, such as on 
SA1100.


Nicolas
