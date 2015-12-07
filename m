From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Dec 2015 13:48:31 +0000
Subject: [PATCH 2/5] iommu/io-pgtable: Indicate granule for TLB maintenance
In-Reply-To: <56657714.50504@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
 <67223d4b1ff57f3f46e8c3102e663a063a50a7f7.1449246988.git.robin.murphy@arm.com>
 <20151207110804.GA23430@arm.com> <56657714.50504@arm.com>
Message-ID: <20151207134831.GF23430@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 12:09:56PM +0000, Robin Murphy wrote:
> On 07/12/15 11:08, Will Deacon wrote:
> [...]
> >>+#define ARM_LPAE_GRANULE(d)		(1UL << (d)->pg_shift)
> >>+
> >>  #define ARM_LPAE_PAGES_PER_PGD(d)					\
> >>-	DIV_ROUND_UP((d)->pgd_size, 1UL << (d)->pg_shift)
> >>+	DIV_ROUND_UP((d)->pgd_size, ARM_LPAE_GRANULE(d))
> >>
> >>  /*
> >>   * Calculate the index at level l used to map virtual address a using the
> >>@@ -169,7 +171,7 @@
> >>  /* IOPTE accessors */
> >>  #define iopte_deref(pte,d)					\
> >>  	(__va((pte) & ((1ULL << ARM_LPAE_MAX_ADDR_BITS) - 1)	\
> >>-	& ~((1ULL << (d)->pg_shift) - 1)))
> >>+	& ~(ARM_LPAE_GRANULE(d) - 1)))
> >
> >Do we run the risk of truncating the VA on 32-bit ARM here?
> 
> Indeed, in all honesty I'd missed that, but since __va is going to truncate
> it to a 32-bit void * anyway, doing it earlier in the expression actually
> seems to result in better code - with iopte_deref wrapped like so to make it
> easier to pick out:

Gah, I meant PA not VA, sorry. The PA is 40-bit, but with ARM_LPAE_GRANULE
using unsigned long, we drop the top 8 bits of the output address field
in the pte.

Will
