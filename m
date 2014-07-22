From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 16:45:03 +0100
Subject: [PATCH v2 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
In-Reply-To: <20140722145711.GC20588@saruman.home>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
 <1404541530-27856-2-git-send-email-peter.griffin@linaro.org>
 <20140707124627.GG6407@lee--X1>
 <20140722091800.GB8233@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140722145711.GC20588@saruman.home>
Message-ID: <20140722154503.GC23210@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +static void st_dwc3_init(struct st_dwc3 *dwc3_data)
> > > > +{
> > > > +	u32 reg = st_dwc3_readl(dwc3_data->glue_base, USB2_CLKRST_CTRL);
> > > > +
> > > > +	reg |= aux_clk_en(1) | ext_cfg_reset_n(1) | xhci_revision(1);
> > > > +	reg &= ~sw_pipew_reset_n(1);
> > > 
> > > 1?  Better to add defines for these magic numbers.  What is 1 anyway?
> > 
> > They are just bit setting macros, I've converted them over to use BIT macro now,
> > so it no longer takes a parameter.
> 
> the macros are better, but make them upper case as everybody else.

When you say that the macros are better, what do you mean?

Defines do the job in a manner which is a great deal cleaner:

#define AUX_CLK_EN        BIT(0)
#define SW_PIPEW_RESET_N  BIT(4)
#define EXT_CFG_RESET_N   BIT(8)
#define XHCI_REVISION     BIT(12)

reg = AUX_CLK_EN | SW_PIPEW_RESET_N | XHCI_REVISION;
reg &= ~SW_PIPEW_RESET_N

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
