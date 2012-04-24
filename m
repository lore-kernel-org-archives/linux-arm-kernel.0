From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Apr 2012 15:41:18 +0300
Subject: [PATCH v2 2/3] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <20120424.153930.1438573079107186567.hdoyu@nvidia.com>
References: <1335269116-9578-1-git-send-email-hdoyu@nvidia.com>
 <1335269116-9578-2-git-send-email-hdoyu@nvidia.com>
 <20120424123248.GG8444@arwen.pp.htv.fi>
 <20120424.153930.1438573079107186567.hdoyu@nvidia.com>
Message-ID: <20120424124115.GL8444@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 02:39:30PM +0200, Hiroshi Doyu wrote:
> From: Felipe Balbi <balbi@ti.com>
> Subject: Re: [PATCH v2 2/3] ARM: tegra: Add SMMU enabler in AHB
> Date: Tue, 24 Apr 2012 14:32:52 +0200
> Message-ID: <20120424123248.GG8444@arwen.pp.htv.fi>
> 
> > * PGP Signed by an unknown key
> > 
> > Hi,
> > 
> > On Tue, Apr 24, 2012 at 03:05:15PM +0300, Hiroshi DOYU wrote:
> > > @@ -95,6 +98,21 @@ static inline void gizmo_writel(unsigned long value, unsigned long offset)
> > >  	writel(value, tegra_ahb->regs + offset);
> > >  }
> > >  
> > > +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> > > +
> > > +void tegra_ahb_enable_smmu(void)
> > > +{
> > > +	unsigned long val;
> > > +
> > > +	val = gizmo_readl(AHB_ARBITRATION_XBAR_CTRL);
> > > +	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE_DONE <<
> > > +		AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE_SHIFT;
> > > +	gizmo_writel(val, AHB_ARBITRATION_XBAR_CTRL);
> > > +}
> > > +EXPORT_SYMBOL(tegra_ahb_enable_smmu);
> > 
> > ok, so this is the only place where you need that global pointer. Who
> > would call this ? Can you do runtime detection of the SoC and enable
> > SMMU based on that ?
> > 
> > I mean, will this function always be called for TEGRA 3 SoCs or is there
> > another condition to that ?
> 
> Only Tegra3 has SMMU.

but all of them ? In that case, you could call this from probe itself,
right ? But an ifdef won't work in all cases, so you need to do runtime
detection based on some revision register or cpu detection...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120424/ad751114/attachment.sig>
