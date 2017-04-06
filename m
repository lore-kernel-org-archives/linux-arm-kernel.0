From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Apr 2017 11:47:37 +0100
Subject: [PATCH v2 02/22] asm-generic/io.h: add ioremap_nopost remap
 interface
In-Reply-To: <20170406102636.GA9623@red-moon>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
 <20170405105841.GG7909@n2100.armlinux.org.uk>
 <20170405113238.GA2465@red-moon> <20170406102636.GA9623@red-moon>
Message-ID: <20170406104737.GC17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 11:26:36AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Apr 05, 2017 at 01:38:12PM +0100, Lorenzo Pieralisi wrote:
> > eg: openrisc
> > 
> > >> include/asm-generic/io.h:922:9: error: implicit declaration of
> > >> function 'ioremap_nocache' [-Werror=implicit-function-declaration]
> >      return ioremap_nocache(offset, size);
> 
> Indeed, the static inline ioremap_nocache() fallback does not work
> on all arches (whether I add the fallback in linux/io.h or
> asm-generic/io.h is irrelevant), I bump into issues such as the one
> reported above.

>From what I can see:

(a) openrisc does define ioremap_nocache() in its asm/io.h
(b) these do not:

$ grep -L 'ioremap_nocache' arch/*/include/asm/io.h
arch/blackfin/include/asm/io.h
arch/h8300/include/asm/io.h
arch/m68k/include/asm/io.h
arch/score/include/asm/io.h
arch/sparc/include/asm/io.h

Out of those, blackfin, h8300 and score do not define it, whereas m68k
and sparc do in other headers included by asm/io.h.  So it looks like
we have three problem architectures that don't define an ioremap_nocache().

PCI on blackfin depends on BROKEN, so it's not selectable.  From what I
can tell, h8300 and score do not allow PCI to be enabled (but maybe its
buried elsewhere in their Kconfig files, I didn't check.)

So, I think a way around this is to make ioremap_nopost() conditional
on PCI in linux/io.h for the time being - if its scope wants to be
enlarged, then these three architectures would need to have either an
ioremap_nopost() implementation added, or an ioremap_nocache()
implementation.

> I could make it:
> 
> #ifndef ioremap_nopost
> static inline void __iomem *ioremap_nopost(resource_size_t offset,
> 					   unsigned long size)
> {
> 	return NULL;
> }
> #endif
> 
> which would force arches to define ioremap_nopost() (if they need it).
> 
> This is what I *assume* was done for ioremap_uc() in asm-generic/io.h,
> but honestly history is hard to follow here.

If we are going to consider doing that, the correct question we need to be
asking is whether anything will break as a result of this - is there any
existing arch using the code as it stands that will end up being broken
when we switch PCI to use ioremap_nopost(), and we end up using this NULL-
returning default?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
