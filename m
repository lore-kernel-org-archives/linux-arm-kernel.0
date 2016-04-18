From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 17:00:49 +0200
Subject: [PATCH v2] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <20160418145348.GA2342@localhost.localdomain>
References: <1460581856-12380-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <10832709.SG7ma9Lsjb@wuerfel> <20160418145348.GA2342@localhost.localdomain>
Message-ID: <29393988.imklgXkpJX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 20:23:49 Jerin Jacob wrote:
> On Mon, Apr 18, 2016 at 04:15:28PM +0200, Arnd Bergmann wrote:
> > On Monday 18 April 2016 19:31:20 Jerin Jacob wrote:
> > > Regarding existing user space applications,
> > > AFAIK, DPDK has the feature to support both /sysfs and vifo scheme.
> > > X11 uses only /sysfs scheme.
> > > 
> > > IMO, Nothing wrong in providing this feature in arm64 kernel.
> > > Except arm64, almost all the major architecture has this support.
> > 
> > My understanding was that it's considered deprecated and only
> > supported for backwards compatibility, but now I can't find any
> > indication of that in the source code and I don't know if that
> > is actually the case.
> > 
> > I agree with Will that we should not expose the procfs interface,
> > it's just far too ugly.
> 
> Me too agree with Will and I don't like it either.
> My point was, Irrespective of this change, the /proc/bus/pci/*/* entries
> will be created. i.e disabling /proc/bus/pci should be a seprate patch
> and it does not depend on this patch.

The problem is that once we allow mmap() on proc/bus/pci/*/*,
it becomes much harder to prove that we are able to remove it
again without breaking stuff that worked.

We have to decouple the sysfs interface from the procfs interface
before we allow the former.

	Arnd
