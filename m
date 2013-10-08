From: kim.phillips@linaro.org (Kim Phillips)
Date: Mon, 7 Oct 2013 19:55:25 -0500
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for BE
 correct operation
In-Reply-To: <52533A70.5040705@ti.com>
References: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
 <5252DA06.8000303@codethink.co.uk>
 <CAA3XUr2wYFL9WAQd9uAJSKK5KhWF3bPzYbh-3x=B3oLVXk79og@mail.gmail.com>
 <52533A70.5040705@ti.com>
Message-ID: <20131007195525.f56083f0d91df6a6396cc494@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013 18:49:20 -0400
Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> On Monday 07 October 2013 12:37 PM, Victor Kamensky wrote:
> > On 7 October 2013 08:57, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >> On 07/10/13 17:48, Victor Kamensky wrote:
> >> If you are booting on the Arndale board, is there a patch to mark
> >> the relevant Exynos devices as BE capable?
> > 
> > Arndale need massive fixes in their BSP layer to be endian agnostic
> > ARM V7 platform. Unfortunate it is not as simple as with few others
> > that already marked as BE capable.
> > 
> > Please see
> > https://git.linaro.org/gitweb?p=people/victor.kamensky/linux-linaro-tracking-be.git;a=shortlog;h=refs/heads/llct-be-topic
> > Mostly it is __raw_xxx conversion to xxx_relaxed, but there are

apologies if this was explained earlier in the thread, but what has
__raw_xxx -> xxx_relaxed have to do with endianness?  the relaxed
accessor variants allow the compiler to reorder the instruction: it's
got nothing to do with byte swapping the data, no?

> > I think above position is consistent with similar discussion on
> > some of BE related threads - changing BSP to support BE mode
> > is BSP owners call.
> > 
> Am just wondering a better method than the patch [1] which touches
> many drivers for readl/writel() replacement. Drivers are using
> that as standard based on device driver guide and was thinking
> we should not change that rule to support BE. We definitely need

I think readl/writel were originally devised for accessing PCI devices
(else why would readl's definition include an __le32_to_cpu byteswap)?
In any case, this makes read/writel incompatible with big endian
devices.

> to get the byte swap achieved but probably through some other
> means. 

back when I looked into this, I found in/out_be32() accessors were Power
arch centric, read/writel ARM arch centric, whereas ioread/writebe32
were available in other arches.  See e.g., upstream commit
0c69fb037a6bb1faf06ea776872da54a6705c154 "mtd: fsl_ifc_nand: use more
portable i/o accessors".

Kim

> [1] https://git.linaro.org/gitweb?p=people/victor.kamensky/linux-linaro-tracking-be.git;a=commit;h=9074a67ab082c62545683e5ec909368a23c33655

if anything, a patch with 'endian fix' in the subject would be
*removing* sparse endianness warnings, not leaving them the same.

To run sparse endian checks, use:

make C=2 CF="-D__CHECK_ENDIAN__"

see Documentation/sparse.txt for details.

Thanks,

Kim
