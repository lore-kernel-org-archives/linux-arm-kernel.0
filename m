From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 17:21:34 +0200
Subject: [PATCH 4/7] io-64-nonatomic: Add relaxed accessor variants
In-Reply-To: <20160425133242.GC30830@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
 <571A5A9E.7040305@arm.com> <20160425133242.GC30830@arm.com>
Message-ID: <5485134.l18Z1dlVmn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 April 2016 14:32:42 Will Deacon wrote:
> > >>
> > >>+static inline __u64 hi_lo_readq_relaxed(const volatile void __iomem *addr)
> > >>+{
> > >>+   const volatile u32 __iomem *p = addr;
> > >>+   u32 low, high;
> > >>+
> > >>+   high = readl_relaxed(p + 1);
> > >>+   low = readl_relaxed(p);
> > >>+
> > >>+   return low + ((u64)high << 32);
> > >>+}
> > >>+
> > >>+static inline void hi_lo_writeq_relaxed(__u64 val, volatile void __iomem *addr)
> > >>+{
> > >>+   writel_relaxed(val >> 32, addr + 4);
> > >>+   writel_relaxed(val, addr);
> > >>+}
> > >
> > >Could we not generate the _relaxed variants with some macro magic?
> > 
> > We _could_ - indeed I started doing that, but then decided that the
> > obfuscation of horrible macro-templated functions wasn't worth saving a
> > couple of hundred bytes in some code that isn't exactly difficult to
> > maintain and has needed touching once in 4 years.
> > 
> > If you did want to go down the macro route, I may as well also generate both
> > lo-hi and hi-lo headers all from a single template, it'd be really clever...
> > <alarm bells> 
> 
> I certainly wasn't suggesting any more than the obvious macroisation,
> but I'll leave it up to Arnd, as I think this falls on his lap.

I'd prefer the open-coded variant as well.

	Arnd
