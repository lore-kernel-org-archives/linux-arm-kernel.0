From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2012 19:33:55 +0000
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <CAOh2x==ZbB5L=susFvsjmDRVKtfDiXd4Bq+MPnPVegnPAPmGsg@mail.gmail.com>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
 <CAOh2x=mk3PeozELWNGrJzjTjF6_T4f0uWgwP9rALD9xOHd=9zQ@mail.gmail.com>
 <CAOh2x==ZbB5L=susFvsjmDRVKtfDiXd4Bq+MPnPVegnPAPmGsg@mail.gmail.com>
Message-ID: <201204031933.56131.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2012, viresh kumar wrote:
> I tried doing this, but it didn't looked convincing to me. Lot of code
> that is currently present in pinctrl-spear.c is getting duplicated per
> SoC registered: 5 (3 - spear3xx, 2 - spear13xx). Almost all SoC's will
> need exactly the same probe routine. So, i would like to retain the original
> code posted.

Maybe I wasn't clear enough. I did not mean that code should be duplicated
here. Instead, you should keep the probe function and export it, with some
modifications, and do the same for the other common functions. This works
well for a lot of other drivers in a similar situation. It would result
in a function like

/* in the header file */
extern int __devinit spear3xx_pinctrl_probe(struct platform_device *pdev,
			const struct spear_pinctrl_mach_data *data);
extern void __devexit spear_pinctrl_remove(struct platform_device *pdev);

/* in pinctrl_spear320.c */
static const spear_pinctrl_mach_data spear320_machdata = {
	.groups = spear320_pingroups,
	.ngroups = ARRAY_SIZE(spear320_pingroups),
	.functions = spear320_functions,
	.nfunctions = _SIZE(spear320_functions),
	.modes_supported = true,
	.pmx_modes = spear320_pmx_modes,
	.npmx_modes = ARRAY_SIZE(spear320_pmx_modes),
};

static int __devinit spear320_pinctrl_probe(struct platform_device *pdev)
{
	return spear3xx_pinctrl_init(pdev, &spear320_machdata);
}

static struct of_device_id spear_pinctrl_of_match[] __devinitdata = {
       { .compatible = "st,spear320-pinmux" },
       {},
};

static struct platform_driver spear_pinctrl_driver = {
       .driver = {
               .name = DRIVER_NAME,
               .owner = THIS_MODULE,
               .of_match_table = spear_pinctrl_of_match,
       },
       .probe = spear320_pinctrl_probe,
       .remove = __devexit_p(spear_pinctrl_remove),
};

While you have to write a copy of this for each soc, there is not actually much
here that is not soc specific.

> >>> +static struct spear_pmx_mode pmx_mode_nand = {
> >>> +   .name = "nand",
> >>> +   .mode = NAND_MODE,
> >>> +   .reg = MODE_CONFIG_REG,
> >>> +   .mask = 0x0000000F,
> >>> +   .val = 0x00,
> >>> +};
> >>> +
> >>
> >> These all look like they can easily get transformed into
> >> device nodes in the device tree.
> >
> > Any example driver doing this would be helpful. Can you
> > give me a link. :)
> 
> With Stephen's mail, i believe i don't really have to do it, for now
> atleast.

No, you don't have to do it, but when you make the decision, you should
be sure that it's a good one, because changing this later would be a pain.

	Arnd
