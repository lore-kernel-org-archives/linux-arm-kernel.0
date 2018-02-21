From: toshi.kani@hpe.com (Kani, Toshi)
Date: Wed, 21 Feb 2018 00:34:40 +0000
Subject: [RFC patch] ioremap: don't set up huge I/O mappings when
 p4d/pud/pmd is zero
In-Reply-To: <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
 <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
Message-ID: <1519175992.16384.121.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-02-20 at 14:54 +0530, Chintan Pandya wrote:
> 
> On 12/28/2017 4:54 PM, Hanjun Guo wrote:
> > From: Hanjun Guo <hanjun.guo@linaro.org>
> > 
> > When we using iounmap() to free the 4K mapping, it just clear the PTEs
> > but leave P4D/PUD/PMD unchanged, also will not free the memory of page
> > tables.
> > 
> > This will cause issues on ARM64 platform (not sure if other archs have
> > the same issue) for this case:
> > 
> > 1. ioremap a 4K size, valid page table will build,
> > 2. iounmap it, pte0 will set to 0;
> > 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
> >     then set the a new value for pmd;
> > 4. pte0 is leaked;
> > 5. CPU may meet exception because the old pmd is still in TLB,
> >     which will lead to kernel panic.
> > 
> > Fix it by skip setting up the huge I/O mappings when p4d/pud/pmd is
> > zero.
> > 
> 
> One obvious problem I see here is, once any 2nd level entry has 3rd 
> level mapping, this entry can't map 2M section ever in future. This way, 
> we will fragment entire virtual space over time.
> 
> The code you are changing is common between 32-bit systems as well (I 
> think). And running out of section mapping would be a reality in 
> practical terms.
> 
> So, if we can do the following as a fix up, we would be saved.
> 1) Invalidate 2nd level entry from TLB, and
> 2) Free the page which holds last level page table
> 
> BTW, is there any further discussion going on this topic which I am 
> missing ?

Yes, I suggested to free up a pte table in my last reply.
https://patchwork.kernel.org/patch/10134581/

Thanks,
-Toshi
