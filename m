From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 28 Jun 2014 03:12:09 +0200
Subject: [RFC 3/4] soc/tegra: Initialize interrupt controller from DT
In-Reply-To: <53ADDC0C.4060401@wwwdotorg.org>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <1403888329-24755-3-git-send-email-thierry.reding@gmail.com>
 <53ADDC0C.4060401@wwwdotorg.org>
Message-ID: <20140628011208.GA13290@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 03:03:08PM -0600, Stephen Warren wrote:
> On 06/27/2014 10:58 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Obtains the register ranges for the legacy interrupt controller from DT
> > and provide hard-coded values as fallback.
> 
> > diff --git a/drivers/soc/tegra/irq.c b/drivers/soc/tegra/irq.c
> 
> >  void __init tegra_init_irq(void)
> 
> > -	distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
> > +	np = of_find_matching_node(NULL, ictlr_matches);
> > +	if (np) {
> > +		for (i = 0; i < ARRAY_SIZE(ictlr_regs); i++)
> > +			if (of_address_to_resource(np, i, &res) == 0)
> > +				ictlr_regs[i] = res;
> 
> It'd be nice to check that loop ran exactly the number of times expected
> based on the compatible value (i.e. SoC) if the legacy interrupt
> controller node.
> 
> What about erroring out if entries are missing or can't be parsed.

I've added some strict checking of the expected number of entries. I
decided against erroring out on missing entries or when they can't be
parsed because we can still continue using the fallback entries in the
ictlr_regs table. However if a mismatch between the number of detected
entries and the expected entries is detected, the code will now WARN.

> >  	if (num_ictlrs > ARRAY_SIZE(ictlr_reg_base)) {
> > -		WARN(1, "Too many (%d) interrupt controllers found. Maximum is %d.",
> > +		WARN(1, "Too many (%d) interrupt controllers found. Maximum is %zu.",
> >  			num_ictlrs, ARRAY_SIZE(ictlr_reg_base));
> 
> While we're changing this, maybe we should change that test to
> "num_ictlrs != the expected value", so too few is found as well.

Done. This is slightly complicated by the fact that the non-DT code has
no notion of how many are expected. The maximum number is only used to
prevent overflows when accessing the ictlr_reg_base array.

I've solved this by selecting the maximum depending on tegra_chip_id. I
have sent a v2 to the list with the patch removed that moves all the
drivers to drivers/soc since more work will be required for that. In the
meantime this change is separate and can be merged independent of that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140628/a0ff50f7/attachment.sig>
