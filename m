From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Oct 2018 13:00:06 +0100
Subject: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
In-Reply-To: <20181025012745.20884-1-rafael.tinoco@linaro.org>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
Message-ID: <20181025120006.GY30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 10:27:44PM -0300, Rafael David Tinoco wrote:
> On 32-bit systems, zsmalloc uses HIGHMEM and, when PAE is enabled, the
> physical frame number might be so big that zsmalloc obj encoding (to
> location) will break IF architecture does not re-define
> MAX_PHYSMEM_BITS, causing:

I think there's a deeper problem here - a misunderstanding of what
MAX_PHYSMEM_BITS is.

MAX_PHYSMEM_BITS is a definition for sparsemem, and is only visible
when sparsemem is enabled.  When sparsemem is disabled, asm/sparsemem.h
is not included (and should not be included) which means there is no
MAX_PHYSMEM_BITS definition.

I don't think zsmalloc.c should be (ab)using MAX_PHYSMEM_BITS, and
your description above makes it sound like you expect it to always be
defined.

If we want to have a definition for this, we shouldn't be playing
fragile games like:

#ifndef MAX_POSSIBLE_PHYSMEM_BITS
#ifdef MAX_PHYSMEM_BITS
#define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
#else
/*
 * If this definition of MAX_PHYSMEM_BITS is used, OBJ_INDEX_BITS will just
 * be PAGE_SHIFT
 */
#define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
#endif
#endif

but instead insist that MAX_PHYSMEM_BITS is defined _everywhere_.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
