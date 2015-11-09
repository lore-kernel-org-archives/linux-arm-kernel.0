From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Nov 2015 18:36:09 +0000
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <CAAmzW4POKyGCFETiR1gRtT0iK+iWH254PGivZDnpjU1CHizgUw@mail.gmail.com>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151105044014.GB20374@js1304-P5Q-DELUXE>
 <20151105103214.GP7637@e104818-lin.cambridge.arm.com>
 <CAAmzW4MR_+0K5JbMMiRu_wVq736zVbz82ugvDYP=x6p=9JuELg@mail.gmail.com>
 <20151105121706.GQ7637@e104818-lin.cambridge.arm.com>
 <CAAmzW4POKyGCFETiR1gRtT0iK+iWH254PGivZDnpjU1CHizgUw@mail.gmail.com>
Message-ID: <20151109183608.GG21606@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 04:41:58PM +0900, Joonsoo Kim wrote:
> 2015-11-05 21:17 GMT+09:00 Catalin Marinas <catalin.marinas@arm.com>:
> > On Thu, Nov 05, 2015 at 08:45:08PM +0900, Joonsoo Kim wrote:
> >> If it isn't possible, is there another way to reduce memory waste due to
> >> increase of dma alignment requirement in arm64?
> >
> > I first need to see how significant the impact is (especially for
> > embedded/mobiles platforms).
> 
> I don't have any ARM64 device. What I have just one report
> about slab usage from our developer.
> 
> The report shows slab usage just after android boot is done
> in ARM64.
> 
> Total slab usage: 90 MB
> kmalloc usage: 25 MB
> kmalloc (<=64) usage: 7 MB
> 
> This would be measured without slab_nomerge so there is
> a possibility that some usages on kmem_cache is merged
> into usage of kmalloc (<=64).
> 
> Anyway, if ARM64 increase L1_CACHE_BYTES to 128, roughly
> 7 MB would be wasted. I don't know how this picture is varied
> in runtime, but, even boot time overhead, 7 MB looks large to me.

7MB is considerable but I guess it wouldn't be all wasted with
L1_CACHE_BYTES == 128, maybe half or slightly over. It would be good to
know the other kmalloc caches, maybe up to 256.

I don't have an Android filesystem but I just tried to boot Arch
(aarch64). Immediately after boot and slab_nomerge, with 128 L1 I get:

kmalloc-128:	6624
kmalloc-256:	1488

With L1 64, I get:

kmalloc-64:	5760
kmalloc-128:	1152
kmalloc-192:	1155
kmalloc-256:	 320

So that's about 1.2MB vs 0.8MB. The ratio is 3:2, though I'm not sure it
will stay the same as the slab usage increases.

It would be good to get more numbers, we could add a Kconfig option just
for specific builds while keeping the default to 128.

-- 
Catalin
