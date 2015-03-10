From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Mar 2015 10:41:42 +0100
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <7h61a94zy0.fsf@deeprootsystems.com>
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
 <1425888603-25800-3-git-send-email-s.hauer@pengutronix.de>
 <7h61a94zy0.fsf@deeprootsystems.com>
Message-ID: <20150310094142.GD24885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


+Cc James Liao <jamesjj.liao@mediatek.com>

On Mon, Mar 09, 2015 at 02:35:03PM -0700, Kevin Hilman wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> A bit of a changelog here would be useful describing this driver, that
> it's only covering part of the device (e.g. power controller) with more
> to come, dependency on the syscon driver, etc.
> 
> > +/*
> > + * The Infracfg unit has bus protection bits. We enable the bus protection
> > + * for disabled power domains so that the system does not hang when some unit
> > + * accesses the bus while in power down.
> > + */
> 
> Hmm, why don't you want to know if some device is accessing another
> device which is in a domain that is powered down?   Seems like this is a
> good way to hide real bugs.

How I understand it the system just hangs on erroneous accesses without
these protection bits enabled, so enabling them at least makes sure we
can output something.
I must admit though that my understanding of these bits is quite limited
and the only user of this driver I have available here (audio) doesn't
make use of these protection bits, so I can't test here.

James, could you shed some light on this issue?

> > +	val = readl(ctl_addr);
> > +	val |= PWR_ON_BIT;
> > +	writel(val, ctl_addr);
> > +	val |= PWR_ON_2ND_BIT;
> > +	writel(val, ctl_addr);
> > +
> > +	/* wait until PWR_ACK = 1 */
> > +	expired = jiffies + HZ;
> > +	while (!(readl(scp->base + SPM_PWR_STATUS) & data->sta_mask) ||
> > +			!(readl(scp->base + SPM_PWR_STATUS_2ND) & data->sta_mask)) {
> > +		cpu_relax();
> > +		if (time_after(jiffies, expired))
> > +			return -EIO;
> 
> hmm, seems like you'd want a dev_warn() or simliar here if this times
> out and fails.  There's a bunch of these below too.

Ok, will add.

> > +	/* Clear bus protection bits */
> > +	if (data->bus_prot_mask) {
> > +		u32 mask = data->bus_prot_mask;
> > +		struct regmap *infracfg = scp->infracfg;
> > +
> > +		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> > +
> > +		expired = jiffies + HZ;
> > +
> > +		while (1) {
> > +			u32 val;
> > +
> > +			ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> > +			if (ret)
> > +				return ret;
> > +
> > +			if (!(val & mask))
> > +				break;
> > +
> > +			cpu_relax();
> > +			if (time_after(jiffies, expired))
> > +				return -EIO;
> > +		}
> > +	}
> 
> This whole "Clear bus protection bits" part seems like it should be an
> API in the infracfg driver.

Ok, can do.

> 
> > +	return 0;
> > +}
> > +
> > +static int scpsys_power_off(struct generic_pm_domain *genpd)
> > +{
> > +	struct scp_domain *scpd = container_of(genpd, struct scp_domain, pmd);
> > +	struct scp *scp = scpd->scp;
> > +	struct scp_domain_data *data = scpd->data;
> > +	unsigned long expired;
> > +	void __iomem *ctl_addr = scpd->scp->base + data->ctl_offs;
> > +	u32 sram_pdn_ack = data->sram_pdn_ack_bits;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/* set bus protection bits */
> > +	if (data->bus_prot_mask) {
> > +		struct regmap *infracfg = scp->infracfg;
> > +		u32 mask = data->bus_prot_mask;
> > +
> > +		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, mask);
> > +
> > +		expired = jiffies + HZ;
> > +
> > +		while (1) {
> > +			ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> > +			if (ret)
> > +				return ret;
> > +
> > +			if ((val & mask) == mask)
> > +				break;
> > +
> > +			cpu_relax();
> > +			if (time_after(jiffies, expired))
> > +				return -EIO;
> > +		}
> > +	}
> 
> As with the 'clear bus protection bits', seems like this should be a
> call into the infracfg driver.
> 
> > +	val = readl(ctl_addr);
> > +	val |= data->sram_pdn_bits;
> > +	writel(val, ctl_addr);
> > +
> > +	/* wait until SRAM_PDN_ACK all 1 */
> > +	expired = jiffies + HZ;
> > +	while ((readl(ctl_addr) & sram_pdn_ack) != sram_pdn_ack) {
> > +		cpu_relax();
> > +		if (time_after(jiffies, expired))
> > +			return -EIO;
> > +	}
> > +
> > +	val |= PWR_ISO_BIT;
> > +	writel(val, ctl_addr);
> > +
> > +	val &= ~PWR_RST_B_BIT;
> > +	writel(val, ctl_addr);
> > +
> > +	val |= PWR_CLK_DIS_BIT;
> > +	writel(val, ctl_addr);
> > +
> > +	val &= ~PWR_ON_BIT;
> > +	writel(val, ctl_addr);
> > +
> > +	val &= ~PWR_ON_2ND_BIT;
> > +	writel(val, ctl_addr);
> > +
> > +	/* wait until PWR_ACK = 0 */
> > +	expired = jiffies + HZ;
> > +	while ((readl(scp->base + SPM_PWR_STATUS) & data->sta_mask) ||
> > +			(readl(scp->base + SPM_PWR_STATUS_2ND) & data->sta_mask)) {
> > +		cpu_relax();
> > +		if (time_after(jiffies, expired))
> > +			return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int scpsys_probe(struct platform_device *pdev)
> > +{
> > +	struct genpd_onecell_data *pd_data;
> > +	struct resource *res;
> > +	int i;
> > +	struct scp *scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
> 
> This might return NULL...

Actually I recently learned that this never fails [1], but the check is
missing accidently here. Will add it of course.

[1] http://lwn.net/Articles/627419/

> 
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	scp->base = devm_ioremap_resource(&pdev->dev, res);
> 
> ... and, boom.
> 
> > +	if (IS_ERR(scp->base))
> > +		return PTR_ERR(scp->base);
> > +
> > +	pd_data = &scp->pd_data;
> > +
> > +	scp->infracfg = syscon_regmap_lookup_by_compatible("mediatek,mt8173-infracfg");
> > +	if (IS_ERR(scp->infracfg))
> > +		return PTR_ERR(scp->infracfg);
> > +
> > +	pd_data->domains = scp->pmd;
> > +	pd_data->num_domains = NUM_DOMAINS;
> > +
> > +	for (i = 0; i < NUM_DOMAINS; i++) {
> > +		struct scp_domain *scpd = &scp->domains[i];
> > +		struct generic_pm_domain *pmd = &scpd->pmd;
> > +
> > +		scp->pmd[i] = pmd;
> > +		scpd->data = &scp_domain_data[i];
> > +		scpd->scp = scp;
> > +
> > +		pmd->name = scp_domain_data[i].name;
> > +		pmd->power_off = scpsys_power_off;
> > +		pmd->power_on = scpsys_power_on;
> > +		pmd->power_off_latency_ns = 20000;
> > +		pmd->power_on_latency_ns = 20000;
> 
> Are the latencies for all domains really the same?   Seems like the
> latencies should be part of the per-domain data.
> 
> Where did these numbers come from?  HW specs, measurement, etc?

They are from measurement. actually they are around 11us.

> 
> Also, eventually, these latencies can (and should) come from DT
> after the support from Geert[1] is merged, so putting them in the data
> struct for now

I agree for domains created from regulators somewhere on the board, but
in this case the domains are completely SoC internal. The
"mediatek,mt8173-scpsys" compatible gives me enough information so I see
no point adding this to the device tree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
