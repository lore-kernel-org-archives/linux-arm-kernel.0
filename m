From: shuahkhan@gmail.com (Shuah Khan)
Date: Wed, 29 Mar 2017 10:51:05 -0600
Subject: [PATCH] ARM: dma-mapping: Fix dma_get_sgtable() for regions
 without struct page
In-Reply-To: <20170329163335.GA7909@n2100.armlinux.org.uk>
References: <CGME20170221131655eucas1p2f2ca6e3c819aeae227c5e5c5f2bc7d3f@eucas1p2.samsung.com>
 <1487682998-2564-1-git-send-email-m.szyprowski@samsung.com>
 <20170322111020.GD21222@n2100.armlinux.org.uk>
 <CAKocOONSt=UjPPVEN0ESLBMAsbk_HeWGQdkzyuUW+X7ddaLwzQ@mail.gmail.com>
 <20170322163237.GF21222@n2100.armlinux.org.uk>
 <CAKocOOMqWByyAotnjKM3Zqq9xUBNcBFMens5Rj08aiM99wxEzg@mail.gmail.com>
 <20170322224200.GH21222@n2100.armlinux.org.uk>
 <20170329163335.GA7909@n2100.armlinux.org.uk>
Message-ID: <CAKocOOPjqdyLbtbeRLr9NZaNoqefjobYhev+0hr3OGwNLwNjmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Mar 29, 2017 at 10:33 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> Okay, I'm about to merge the following patch for -rc, since refusing
> to create a scattertable for non-page backed memory is the only valid
> solution for that case.  I'm intending to queue this for -rc this
> evening.

I was bit sidetracked and getting back to this today. I am just about
to test this change on my system. I will test your patch and send you
results.

This might not help my use-case - I suspect it will trip this check.
That said I will send you results very soon.

>
> 8<====
> ARM: dma-mapping: disallow dma_get_sgtable() for non-kernel managed memory
>
> dma_get_sgtable() tries to create a scatterlist table containing valid
> struct page pointers for the coherent memory allocation passed in to it.
>
> However, memory can be declared via dma_declare_coherent_memory(), or
> via other reservation schemes which means that coherent memory is not
> guaranteed to be backed by struct pages.  This means it is not possible
> to create a valid scatterlist via this mechanism.

I have been thinking about this some. I would like to see if we can
provide a way forward to address the cases where coherent memory is
not guaranteed to be backed by struct pages. We know the memory isn't
backed at alloc time in dma_alloc_coherent(). Can we key off of that
maybe add a new attr flag to avoid page lookups. I am willing to work
on the fixing it.

Let me first send you the results after testing your patch. Maybe we
can explore ways to fix the problem.

thanks,
-- Shuah

>
> This patch adds detection of such memory, and refuses to create a
> scatterlist table for such memory.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/mm/dma-mapping.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 63eabb06f9f1..475811f5383a 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -935,13 +935,31 @@ static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_add
>         __arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
>  }
>
> +/*
> + * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
> + * that the intention is to allow exporting memory allocated via the
> + * coherent DMA APIs through the dma_buf API, which only accepts a
> + * scattertable.  This presents a couple of problems:
> + * 1. Not all memory allocated via the coherent DMA APIs is backed by
> + *    a struct page
> + * 2. Passing coherent DMA memory into the streaming APIs is not allowed
> + *    as we will try to flush the memory through a different alias to that
> + *    actually being used (and the flushes are redundant.)
> + */
>  int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>                  void *cpu_addr, dma_addr_t handle, size_t size,
>                  unsigned long attrs)
>  {
> -       struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
> +       unsigned long pfn = dma_to_pfn(dev, handle);
> +       struct page *page;
>         int ret;
>
> +       /* If the PFN is not valid, we do not have a struct page */
> +       if (!pfn_valid(pfn))
> +               return -ENXIO;
> +
> +       page = pfn_to_page(pfn);
> +
>         ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>         if (unlikely(ret))
>                 return ret;
> --
> 2.7.4
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
