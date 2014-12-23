From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 23 Dec 2014 10:22:28 +0800
Subject: [PATCH v2 3/4] clk: mediatek: Add basic clocks for Mediatek
 MT8135.
In-Reply-To: <CABuKBeJNs+BFwS88L_u6sXBJW4bKPuorD-9+q+LZ1N=2dM3t+Q@mail.gmail.com>
References: <1417675942-10502-1-git-send-email-jamesjj.liao@mediatek.com>
 <1417675942-10502-4-git-send-email-jamesjj.liao@mediatek.com>
 <CABuKBeJNs+BFwS88L_u6sXBJW4bKPuorD-9+q+LZ1N=2dM3t+Q@mail.gmail.com>
Message-ID: <1419301348.22063.28.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Mon, 2014-12-22 at 19:07 +0100, Matthias Brugger wrote:
> 2014-12-04 7:52 GMT+01:00 James Liao <jamesjj.liao@mediatek.com>:
> > +               if (clk_data)
> > +                       clk_data->clks[gate->id] = clk;
> > +
> > +               pr_debug("gate %3d: %s\n", i, gate->name);
> 
> Please review the use of pr_debug in this file, there are quite a few
> (if not all) which are not needed.
> 

OK, I'll remove some debug log.

> > +       /* PERI1 */
> > +       GATE(PERI_USBSLV_CK, usbslv_ck, axi_sel, peri1_cg_regs, 8, 0),
> > +       GATE(PERI_USB1_MCU_CK, usb1_mcu_ck, axi_sel, peri1_cg_regs, 7, 0),
> > +       GATE(PERI_USB0_MCU_CK, usb0_mcu_ck, axi_sel, peri1_cg_regs, 6, 0),
> > +       GATE(PERI_GCPU_CK, gcpu_ck, gcpu_sel, peri1_cg_regs, 5, 0),
> > +       GATE(PERI_FHCTL_CK, fhctl_ck, clk26m, peri1_cg_regs, 4, 0),
> > +       GATE(PERI_SPI1_CK, spi1_ck, spi_sel, peri1_cg_regs, 3, 0),
> > +       GATE(PERI_AUXADC_CK, auxadc_ck, clk26m, peri1_cg_regs, 2, 0),
> > +       GATE(PERI_PERI_PWRAP_CK, peri_pwrap_ck, axi_sel, peri1_cg_regs, 1, 0),
> > +       GATE(PERI_I2C6_CK, i2c6_ck, axi_sel, peri1_cg_regs, 0, 0),
> > +};
> 
> This clocks look pretty much the same as in mt6589. Can you please
> check the other SoCs (especially mt6589 and mt6592) and put the parts
> of the clock tree which are identical together?
> 

Subsystem clocks (include INFRA and PERI) are similar among Mediatek
SoCs, but not the same. Some clocks may be added or removed, and some
clock bits may be shifted, i.e. a register bit may represent different
clock in different SoCs. So I think it's not a good way to share the
same clock tree implementation.

> > +/*
> > + * device tree support
> > + */
> 
> Please delte this comment, it's not necessary
> 

OK.

> > +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +       if (r)
> > +               pr_err("could not register clock provide\n");
> 
> Please make all these error messages more explanatory. Apart from that
> it should be "provider" instead of "provide", right?
> 

You are right. I'll change the error message to show which provider
registration fail.

> > +       clk_data = alloc_clk_data(INFRA_NR_CLK);
> > +
> > +       init_clk_infrasys(base, clk_data);
> 
> Why do you put init_clk_gates in a extra function which does nothing else?
> 

In the beginning clock initialization was not invoked from device tree.
But now all of them are init from device tree, so it may be a better way
to remove init_clk_*() and merge the code into this init function. I'll
refine it in next patch.


Best regards,

James
