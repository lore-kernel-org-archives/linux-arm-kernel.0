From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Aug 2014 10:32:55 +0100
Subject: CMA region and highmem
In-Reply-To: <CAD8Lp47W9UcA7CHSK9xia_b9opLv-5wi_9Omj2DThRo4wYkcNw@mail.gmail.com>
References: <20140813191811.GP30401@n2100.arm.linux.org.uk>
 <53F44858.2070906@samsung.com>
 <CAD8Lp47W9UcA7CHSK9xia_b9opLv-5wi_9Omj2DThRo4wYkcNw@mail.gmail.com>
Message-ID: <20140821093255.GJ30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 10:22:35AM +0100, Daniel Drake wrote:
> On Wed, Aug 20, 2014 at 8:03 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > There is no direct dependecy on low-mem. It was rather a heritage of initial
> > CMA implementation, which by design worked only with lowmem (there was no
> > code to allocate kernel virtual mappings from vmalloc range). The only
> > requirement about CMA regions is to put them entirely either in lowmem or
> > in highmem. I will prepare a patch swtiching default CMA region to highmem
> > if such is available and defined region fits into it.
> 
> Just curious, to complete my understanding here...
> 
> If the CMA region is now moved into highmem, when memory is allocated
> with the DMA API, such memory will now use up vmalloc space. Is that
> right?
> 
> In the default 3G/1G split configuration, of the 1G, 240mb is vmalloc
> space by default (and 760mb is lowmem).
> 
> So, lets say your patch moves CMA into highmem, and I build a kernel
> with a 512mb CMA allocation.
> 
> Now whenever anyone uses the DMA API to allocate from CMA, it will
> only be able to allocate a maximum of 240mb, later allocations will
> then fail due to lack of vmalloc space. Right?
> 
> Of course, vmalloc space can be increased, but only at the expenses of
> reducing lowmem.

Correct.  So, if you need more space than is available, the options are:

- use an API which does not map into virtual space when it is not required.
  (Unfortunately, the DMA API assumes that if you want DMA memory, you
  also want it mapped as well.)  This avoids unnecessary wastage of kernel
  memory space.

- reduce PAGE_OFFSET to give yourself more kernel memory space at the
  expense of reduced userspace.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
