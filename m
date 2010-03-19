From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Mar 2010 16:52:18 +0000
Subject: Highmem issues with MMC filesystem
In-Reply-To: <1269017214.31227.117.camel@e102109-lin.cambridge.arm.com>
References: <20100319145417.GH21280@n2100.arm.linux.org.uk>
	<1269017214.31227.117.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100319165218.GA27710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 04:46:54PM +0000, Catalin Marinas wrote:
> On Fri, 2010-03-19 at 14:54 +0000, Russell King - ARM Linux wrote:
> > On Fri, Mar 19, 2010 at 02:52:00PM +0000, Catalin Marinas wrote:
> > > > On Fri, Mar 19, 2010 at 02:41:17PM +0000, Catalin Marinas wrote:
> > > > > On Thu, 2010-03-18 at 13:20 +0000, Nicolas Pitre wrote:
> > > > > > The only way a highmem page can be unmapped is through kunmap_atomic()
> > > > > > where an explicit __cpuc_flush_dcache_area() is performed, or through
> > > > > > flush_all_zero_pkmaps() where flush_cache_kmaps() translates into
> > > > > > flush_cache_all().
> > > > >
> > > > > The thing that I couldn't fully understand with the kunmap_atomic()
> > > > > function is that there is a path (when kvaddr < FIXADDR_START) where no
> > > > > cache flushing occurs. Can this not happen?
> > > >
> > > > kunmap interfaces are not for cache flushing; the cache flushing is
> > > > only there to ensure consistency when unmapping a mapping on VIVT CPUs.
> > >
> > > I agree, but then why don't we conditionally call
> > > __cpuc_flush_dcache_area() in kunmap_atomic() so that we avoid this
> > > flush on non-aliasing VIPT?
> > 
> > Probably because highmem was written at the time for VIVT CPUs.  I'm sure
> > Nicolas will accept patches to improve performance of highmem for VIPT.
> 
> See below for the VIPT case. But my initial question still remains for
> VIVT caches - are all the cases covered?

On non-highmem, no cache flushing is expected on kunmap_atomic; it
becomes (almost) a no-op.

As I've already said, the _only_ reason for flushing the caches in
kunmap_atomic() is to ensure consistency when removing the mapping.
