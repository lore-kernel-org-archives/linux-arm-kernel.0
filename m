From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 24 Nov 2016 20:26:59 +0100
Subject: [PATCH] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <20161124150918.GF2213@rric.localdomain>
References: <CAKv+Gu-2uGJGovqQL-gbB54u=fQ9L9YUbDdRo6u3oWqF6znn6Q@mail.gmail.com>
 <20161123211538.GH10776@rric.localdomain>
 <CAKv+Gu8aWpz5vXSWdKHwL5Xk2aWyQBOoR1WHOnVPaWZOwqojBQ@mail.gmail.com>
 <20161124134238.GI10776@rric.localdomain>
 <CAKv+Gu_Ug3XOD6jy5xziy1pS7WV=TC0RLD4j3DT6nytujQDzRQ@mail.gmail.com>
 <20161124135151.GJ10776@rric.localdomain>
 <CAKv+Gu9qB7P2epMGdwFJ3vJR3vt-bBxU0nKwmKdpaOpTKdqzzA@mail.gmail.com>
 <20161124141149.GE2213@rric.localdomain>
 <CAKv+Gu-SXX_Vv1Wi1Nm=5vdaXSS0MBp20QBpQVacSKPLfdH0-A@mail.gmail.com>
 <20161124150918.GF2213@rric.localdomain>
Message-ID: <20161124192659.GH2213@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard,

> > >> On 24 November 2016 at 13:51, Robert Richter <robert.richter@cavium.com> wrote:
> > >> > On 24.11.16 13:44:31, Ard Biesheuvel wrote:

> > >> Regions containing firmware tables are owned by the firmware, and it
> > >> is the firmware that tells us which memory attributes we are allowed
> > >> to use. If those attributes include WB, it is perfectly legal to use a
> > >> cacheable mapping. That does *not* mean they should be covered by the
> > >> linear mapping. The linear mapping is read-write-non-exec, for
> > >> instance, and we may prefer to use a read-only mapping and/or
> > >> executable mapping.
> > >
> > > Ok, I am going to fix try_ram_remap().

I revisited the code and it is working well already since:

 e7cd190385d1 arm64: mark reserved memblock regions explicitly in iomem

Now, try_ram_remap() is only called if the region to be mapped is
entirely in IORESOURCE_SYSTEM_RAM. This is only true for normal mem
ranges and not NOMAP mem. region_intersects() then returns
REGION_INTERSECTS and calls try_ram_remap(). For the NOMAP memory case
REGION_DISJOINT would be returned and thus arch_memremap_wb() being
called directly. Before the e7cd190385d1 change try_ram_remap() was
called also for nomap regions.

So we can leave memremap() as it is and just apply this patch
unmodified. What do you think? Please ack.

I am going to prepare the pfn_is_ram() change in addition to this
patch, but that should not be required for this fix to work correcly.

Thanks,

-Robert
