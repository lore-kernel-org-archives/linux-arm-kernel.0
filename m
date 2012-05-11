From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 11 May 2012 08:16:55 +0200
Subject: [PATCH 3/4] ARM: tegra30: Add Tegra Memory Controller(MC) driver
In-Reply-To: <20120510214604.GA3525@kroah.com>
References: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com><1336635764-30597-3-git-send-email-hdoyu@nvidia.com><20120510214604.GA3525@kroah.com>
Message-ID: <20120511.091655.1764445721704382888.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] ARM: tegra30: Add Tegra Memory Controller(MC) driver
Date: Thu, 10 May 2012 23:46:04 +0200
Message-ID: <20120510214604.GA3525@kroah.com>

> On Thu, May 10, 2012 at 10:42:32AM +0300, Hiroshi DOYU wrote:
> > Tegra Memory Controller(MC) driver for Tegra30
> > Added to support MC General interrupts, mainly for IOMMU(SMMU).
> 
> I'll apply this, but:

Thanks.

> > +static inline u32 mc_readl(struct tegra30_mc *mc, u32 offs)
> > +{
> > +	if (offs < 0x10)
> > +		return readl(mc->regs[0] + offs);
> > +	BUG_ON(offs < 0x3c);
> > +	if (offs < 0x1f0)
> > +		return readl(mc->regs[1] + offs - 0x3c);
> > +	BUG_ON(offs < 0x200);
> > +	if (offs < 0x228)
> > +		return readl(mc->regs[2] + offs - 0x200);
> > +	BUG_ON(offs < 0x284);
> > +	if (offs < 0x400)
> > +		return readl(mc->regs[3] + offs - 0x284);
> > +	BUG();
> > +}
> 
> That's a lot of BUG* calls.  Same thing with the 1/4 patch in this
> series.
> 
> We really should not have a BUG call in any driver, as you just stopped
> the whole system.  I can understand this being there for debugging when
> you create the code originally, but as these are things no one should
> ever be able to hit now, you should remove them, right?
> 
> Care to write a follow-on patch removing all of these BUG_ON and BUG
> calls in this and the drivers/memory/tegra20-mc.c driver?

Ok, they are replying to this email.
