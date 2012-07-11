From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 11 Jul 2012 19:35:36 +0800
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: add support for set bits for
 general purpose registers
In-Reply-To: <20120711093331.GA3025@b20223-02.ap.freescale.net>
References: <1341565763-10074-1-git-send-email-b29396@freescale.com>
 <4FF709D1.40903@wwwdotorg.org>
 <20120709071019.GA28527@shlinux2.ap.freescale.net>
 <20120711093331.GA3025@b20223-02.ap.freescale.net>
Message-ID: <20120711113536.GB22640@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 05:33:32PM +0800, Zhao Richard-B20223 wrote:
> On Mon, Jul 09, 2012 at 03:10:21PM +0800, Dong Aisheng wrote:
> > On Fri, Jul 06, 2012 at 11:52:49PM +0800, Stephen Warren wrote:
> > > On 07/06/2012 03:09 AM, Dong Aisheng wrote:
> > > > From: Dong Aisheng <dong.aisheng@linaro.org>
> > > > 
> > > > The General Purpose Registers (GPR) is used to select operating modes for
> > > > general features in the SoC, usually not related to the IOMUX itself,
> > > > but it does belong to IOMUX controller.
> > > > We simply provide an convient API for driver to call to set the general purpose
> > > > register bits if needed.
> > > 
> > > > +static struct imx_pinctrl *imx_pinctrl;
> > > > +/*
> > > > + * Set bits for general purpose registers
> > > > + */
> > > > +void imx_pinctrl_set_gpr_register(u8 gpr, u8 start_bit, u8 num_bits, u32 value)
> > > > +{
> > > > +	u32 reg;
> > > > +
> > > > +	/* general purpose register is 32 bits size */
> > > > +	WARN_ON(!imx_pinctrl || start_bit > 31 || num_bits > 32);
> > > 
> > > Hmmm. It's going to be very hard to control the probe() order to ensure
> > > that this WARN doesn't fire all the time.
> > > 
> > Correct, if this api is used by client driver before the pinctrl driver is
> > registered, the warning will show.
> > To avoid it, the current pinctrl driver register priority is arch_initcall.
> +postcore_initcall is not enough. Could you use postcore_initcall? So people
> can hack right after populate devices.
> 
Yes, i will change to postcore_initcall to satisfy the client devices at best.

> > But maybe you're right, this may not be so sufficient since i'm afraid there
> > are still possible some devices may register earlier than pinctrl since it's not
> > controlled by pinctrl driver.
> > Then it's true that we need to resolve it.
> imx_pinctrl_set_gpr_register is SoC specific. People who use it must
> have sense of related registers and driver loading sequence.
> > 
> > > I think it would be better to pass in a struct imx_pinctrl* or DT node
> > > to this function.
> Maybe we can do it, but why? It's kind of over-engineering.
> 
> > The DT node for the device that's using this function
> > > should contain a phandle to the pinctrl device node, which it uses to
> > > get that handle. Or in a non-DT case, the client driver needs to be
> > > given the provider driver handle using some other mechanism.
> > > 
> > > For example, look at how the Tegra30 SMMU uses services from the Tegra30
> > > AHB; see arch/arm/boot/dts/tegra30.dtsi node "smmu" (client) and node
> > > "ahb" (provider), drivers/iommu/tegra-smmu.c functions probe() (saves
> > > smmu->ahb) and smmu_setup_regs() (calls tegra_ahb_enable_smmu() with
> > > this handle) and drivers/amba/tegra-ahb.c function
> > > tegra_ahb_enable_smmu() (implements the deferred probe checking to
> > > correctly order the client/provider driver probing)
> > > 
> > Yes, i learned the code but i'm not sure it also fits for imx.
> > I have a few concerns:
> > 1) i'm not sure if we really need the client to provide pinctrl device
> > node as parameter to set gpr registers since there is only one pinctrl device
> > for each imx soc. Client devices may also not want to care that parameter.
> > 2) if passing device node to the api, that means every client driver
> > needs to define a phandle of pinctrl device in dts file and parsing it
> > in each driver respectively.
> > There're several client devices for imx6q, i'm not sure if it's worth to do that
> > considering this overhead.
> > 
> > I think either passing device node or not passing, the goal is the same,
> > guarantee this api to be used properly without being affected by driver
> > loading sequence.
> > 
> > If that, how about change to:
> > int imx_pinctrl_set_gpr_register(u8 gpr, u8 start_bit, u8 num_bits, u32 value)
> > {
> >         u32 reg;
> > 
> > 	if (!imx_pinctrl)
> > 		return -EDEFER_PROBE;
> > 
> >         /* general purpose register is 32 bits size */
> >         WARN_ON(start_bit > 31 || num_bits > 32);
> Isn't it BUG ?
Hmm, it seems it's not so seriously to hang kernel.

> Normally, people like write_register(addr, mask, value),
> and read_register(addr, mask);
> 
Correct, will try it.

Regards
Dong Aisheng
