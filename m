From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jun 2013 09:13:57 +0100
Subject: SCU registers mapping for CA9/CA5 cores
In-Reply-To: <CADApbei3QOCQRmo_oYZ_XiUVupq+4uUs7WNe6f7k_OG0LHB3=w@mail.gmail.com>
References: <CADApbei3QOCQRmo_oYZ_XiUVupq+4uUs7WNe6f7k_OG0LHB3=w@mail.gmail.com>
Message-ID: <20130621081356.GU2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 02:11:31PM +0800, Chao Xie wrote:
> hi, Russell
> When i sbumited the patch for pxa988 which is CA9, Arnd gave me some
> suggestions of SCU mapping.
> I used static mapping in the platform file for SCU registers mapping,
> but Arnd think there should be a more general way to do it, and others
> can benefit from it. I agree with him.
> 
> The following is his question for you when reply to my patch.
> "Russell, do you think using a fixmap page for the SCU makes sense?
> I'm looking for a method to consolidate the various methods of
> doing early mappings of the SCU for device tree based platforms.
> Where do you think that should be implemented?"
> 
> So can you give your idea and suggestion? Thanks.

With our current fixmap region, we have 224 pages available, currently
all dedicated to kmap.  kmap uses 16 pages per CPU at the moment, which
we hope is enough (it's only checked when CONFIG_DEBUG_HIGHMEM is set.)

Assuming four CPUs, that makes it 64 pages, but then we have big.LITTLE
with potentially 8 (I guess they map as separate smp_processor_id()'s)
which makes that 128.  128 is over half of the available fixmap.

If we ever saw 16 CPUs, we'd need to find a new home for fixmap.  If we
needed to increase KM_TYPE_NR beyond 28, we'd be in the same situation.

We do have the 0xffff1000 - 0xffff4000 range which is currently unused.
We could put the SCU at 0xffff1000 for a single page.  IOW, not a fixmap
page.
