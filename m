From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sun, 30 Sep 2012 22:43:37 -0600
Subject: [PATCH] [ARM] Build failure CONFIG_ARCH_KIRKWOOD_DT relies on
 CACHE_FEROCEON_L2
In-Reply-To: <CAOesGMgpDs60jGsV4Wu-A7M+ThXh7YVkgb_mPgMJfPwNa_QbSw@mail.gmail.com>
References: <20120930232253.GD30637@obsidianresearch.com>
 <CAOesGMgpDs60jGsV4Wu-A7M+ThXh7YVkgb_mPgMJfPwNa_QbSw@mail.gmail.com>
Message-ID: <20121001044337.GA8446@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 07:44:10PM -0700, Olof Johansson wrote:

> >  void __init kirkwood_l2_init(void)
> >  {
> > +#ifdef CONFIG_CACHE_FEROCEON_L2
> >  #ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
> 
> Aren't these added ifdefs completely redundant? L2_WRITETHROUGH is
> dependent on the outer options anyway.

No, the complete new function is:

void __init kirkwood_l2_init(void)
{
#ifdef CONFIG_CACHE_FEROCEON_L2
#ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
        writel(readl(L2_CONFIG_REG) | L2_WRITETHROUGH, L2_CONFIG_REG);
        feroceon_l2_init(1);
#else
        writel(readl(L2_CONFIG_REG) & ~L2_WRITETHROUGH, L2_CONFIG_REG);
        feroceon_l2_init(0);
#endif
#endif
}

So you hit the #else clause and link fails on feroceon_l2_init because
of:

obj-$(CONFIG_CACHE_FEROCEON_L2) += cache-feroceon-l2.o

Jason
