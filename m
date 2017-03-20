From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Mar 2017 13:18:37 +0000
Subject: [PATCH v2] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <1489611696.4195.186.camel@infradead.org>
References: <1460581856-12380-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <29393988.imklgXkpJX@wuerfel>
 <20160418152126.GA3154@localhost.localdomain>
 <4342694.H5cy8vaG9k@wuerfel>
 <1489611696.4195.186.camel@infradead.org>
Message-ID: <20170320131836.GM17263@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 09:01:36PM +0000, David Woodhouse wrote:
> On Mon, 2016-04-18 at 17:31 +0200, Arnd Bergmann wrote:
> > On Monday 18 April 2016 20:51:27 Jerin Jacob wrote:
> > > 
> > > 
> > > Why only to disable mmap() serivce in proc/bus/pci/*/*. Why not
> > > other??services offered though proc/bus/pci/ like config space
> > > read,
> > > /proc/bus/pci/devices etc
> > > 
> > > if a given platform not interested in proc fs??then disable through
> > > CONFIG_PROC_FS in defconfig. I don't understand the logic behind
> > > disabling partial services that proc fs exposes.
> > Disabling CONFIG_PROC_FS is not really an option for anybody.
> > 
> > The config space access may be something we should have disabled,
> > or it may not be, but I think it's too late to kill that off now,
> > as that would likely break something.
> > 
> > The mmap() support on those files is way uglier than the config
> > access, so as long as nobody absolutely requires it, we should
> > not add it to the list of things we can't get rid of again.
> 
> I don't think we should be doing this. You may have guessed that from
> my... less than sympathetic... implementation of it in the patch I just
> sent.
> 
> The thing is, this *isn't* an architecture-specific interface where you
> get a clean slate. It's a cross-platform interface. Legacy and horrid,
> sure. But it does you no harm.

I don't agree with that: it provides (privileged) userspace with a way to
map non-prefetchable BARs using write-combining memory attributes, which
could lead to mismatched memory attributes against a kernel mapping of the
same BAR and is something that you can't achieve using the sysfs API.

> What *else* don't you like having in /proc? Shall we have a clean slate
> and eliminate *everything* other than actual processes from /proc for
> the next architecture we add to the tree? If not, why not?

It's not about what we like and don't like in /proc, it's about not
promoting legacy that we don't need. If somebody actually needs the /proc
interface, fine, we can support it. But all the people asking for this have
been concerned solely about the sysfs interface, so I'd just like the two
divorced from each other so that we can provide what people are asking for
without pulling in a deprecated interface at the same time.

This should be straightforward.

Will
