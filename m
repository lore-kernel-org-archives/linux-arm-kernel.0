From: jerin.jacob@caviumnetworks.com (Jerin Jacob)
Date: Mon, 18 Apr 2016 19:31:20 +0530
Subject: [PATCH v2] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <4265693.nXcsYZd1B2@wuerfel>
References: <1460581856-12380-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <20160415130953.GI22906@arm.com> <4265693.nXcsYZd1B2@wuerfel>
Message-ID: <20160418140119.GB5639@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 08:45:20PM +0200, Arnd Bergmann wrote:
> On Friday 15 April 2016 14:09:53 Will Deacon wrote:
> > On Thu, Apr 14, 2016 at 02:40:56AM +0530, Jerin Jacob wrote:
> > > Certain X11 servers and user space network drivers frameworks
> > > need PCI mmaped /sys/bus/pci/devices/B:D:F/resourceX file to
> > > access PCI bar address space from user space.
> > > 
> > > Signed-off-by: Jerin Jacob <jerin.jacob@caviumnetworks.com>
> > > ---
> > > Changes in v2:
> > >   - Rebased to 4.6.0-rc3.
> > >   - Tested and verified the change on Thunderx and xgene1 arm64 platforms
> > > 
> > >  arch/arm64/include/asm/pci.h |  6 ++++++
> > >  arch/arm64/kernel/pci.c      | 20 ++++++++++++++++++++
> > >  2 files changed, 26 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> > > index b9a7ba9..9d7e460 100644
> > > --- a/arch/arm64/include/asm/pci.h
> > > +++ b/arch/arm64/include/asm/pci.h
> > > @@ -37,5 +37,11 @@ static inline int pci_proc_domain(struct pci_bus *bus)
> > >  }
> > >  #endif  /* CONFIG_PCI */
> > >  
> > > +#define HAVE_PCI_MMAP
> > 
> > By defining this symbol, we also get lumbered with the legacy /proc
> > interface, which I'd be keen to avoid exposing until we have people
> > explicitly asking for it.
> > 
> > Any chance you could expose only the /sysfs interface on arm64?
> > 
> 
> Do we have an idea how much user space code is affected by this?
> Maybe it can instead be changed to use VFIO, which is basically
> the current way to do this.

Yes, after the introduction of vfio-noiommu mode almost all
uses case can be addressed with vfio. But still their are userspace
applications uses /sysfs scheme.

Regarding existing user space applications,
AFAIK, DPDK has the feature to support both /sysfs and vifo scheme.
X11 uses only /sysfs scheme.

IMO, Nothing wrong in providing this feature in arm64 kernel.
Except arm64, almost all the major architecture has this support.

Jerin

> 
> 	Arnd
