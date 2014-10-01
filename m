From: vgoyal@redhat.com (Vivek Goyal)
Date: Wed, 1 Oct 2014 15:22:45 -0400
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <20141001180304.GC5788@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
 <20141001174714.GD14991@redhat.com>
 <20141001180304.GC5788@leverpostej>
Message-ID: <20141001192245.GG14991@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 07:03:04PM +0100, Mark Rutland wrote:

[..]
> I assume we'd have the first kernel perform the required cache maintenance.
> 

Hi Mark,

I am wondering, what kind of cache management is required here? What kind of
dcaches are present on arm64. I see that Geoff's patches flush dcaches for 
certain kexec stored pages using __flush_dcache_area()
(in kexec_list_flush_cb()).

arch/arm64/include/asm/cacheflush.h says following.

 *      __flush_dcache_area(kaddr, size)
 *
 *              Ensure that the data held in page is written back.
 *              - kaddr  - page address
 *              - size   - region size

So looks like we are trying to write back anything which we will access
after switching off MMU. If that's the case, I have two questions.

- Why do we need to writeback that cacheline. After switching off MMU,
  will we not access same cacheline. I thought caches are VIPT and tag
  will still remain the same (but I might easily be wrong here).

- Even if we have to flush that cacheline, for kexec pages, I guess it
  should be done at kernel load time and not at the time of transition
  into new kernel. That seems too late. Once the kernel has been loaded,
  we don't overwrite these pages anymore. So a dcache flush at that
  time should be good.

Thanks
Vivek
