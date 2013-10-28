From: marex@denx.de (Marek Vasut)
Date: Mon, 28 Oct 2013 11:47:53 +0100
Subject: [PATCH v3 2/5] usb: chipidea: add freescale imx28 special write
 register method
In-Reply-To: <526E3E2C.3030706@digi.com>
References: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
 <1382680943-9258-2-git-send-email-peter.chen@freescale.com>
 <526E3E2C.3030706@digi.com>
Message-ID: <201310281147.53982.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Hector Palacios,

> Dear Peter,
> 
> On 10/25/2013 08:02 AM, Peter Chen wrote:
> > According to Freescale imx28 Errata, "ENGR119653 USB: ARM to USB
> > register error issue", All USB register write operations must
> > use the ARM SWP instruction. So, we implement special hw_write
> > and hw_test_and_clear for imx28.
> > 
> > Discussion for it at below:
> > http://marc.info/?l=linux-usb&m=137996395529294&w=2
> > 
> > Signed-off-by: Peter Chen
> > <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org> ---
> > Changes for v2:
> > - Rebase to latest usb-next tree
> > 
> >   drivers/usb/chipidea/ci.h    |   23 +++++++++++++++++++++++
> >   drivers/usb/chipidea/core.c  |    2 ++
> >   drivers/usb/chipidea/host.c  |    1 +
> >   include/linux/usb/chipidea.h |    1 +
> >   4 files changed, 27 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> > index 1c94fc5..4eb61d0 100644
> > --- a/drivers/usb/chipidea/ci.h
> > +++ b/drivers/usb/chipidea/ci.h
> > @@ -173,6 +173,8 @@ struct ci_hdrc {
> > 
> >   	struct dentry			*debugfs;
> >   	bool				id_event;
> >   	bool				b_sess_valid_event;
> > 
> > +	/* imx28 needs swp instruction for writing */
> > +	bool				imx28_write_fix;
> > 
> >   };
> >   
> >   static inline struct ci_role_driver *ci_role(struct ci_hdrc *ci)
> > 
> > @@ -253,6 +255,13 @@ static inline u32 hw_read(struct ci_hdrc *ci, enum
> > ci_hw_regs reg, u32 mask)
> > 
> >   	return ioread32(ci->hw_bank.regmap[reg]) & mask;
> >   
> >   }
> > 
> > +#ifdef CONFIG_SOC_IMX28
> > +static inline void imx28_ci_writel(u32 val32, volatile u32 *addr)
> > +{
> > +	__asm__ ("swp %0, %0, [%1]" : : "r"(val32), "r"(addr));
> > +}
> > +#endif
> > +
> > 
> >   /**
> >   
> >    * hw_write: writes to a hw register
> >    * @reg:  register index
> > 
> > @@ -266,7 +275,14 @@ static inline void hw_write(struct ci_hdrc *ci, enum
> > ci_hw_regs reg,
> > 
> >   		data = (ioread32(ci->hw_bank.regmap[reg]) & ~mask)
> >   		
> >   			| (data & mask);
> > 
> > +#ifdef CONFIG_SOC_IMX28
> > +	if (ci->imx28_write_fix)
> > +		imx28_ci_writel(data, ci->hw_bank.regmap[reg]);
> > +	else
> > +		iowrite32(data, ci->hw_bank.regmap[reg]);
> > +#else
> > 
> >   	iowrite32(data, ci->hw_bank.regmap[reg]);
> > 
> > +#endif
> > 
> >   }
> >   
> >   /**
> > 
> > @@ -281,7 +297,14 @@ static inline u32 hw_test_and_clear(struct ci_hdrc
> > *ci, enum ci_hw_regs reg,
> > 
> >   {
> >   
> >   	u32 val = ioread32(ci->hw_bank.regmap[reg]) & mask;
> > 
> > +#ifdef CONFIG_SOC_IMX28
> > +	if (ci->imx28_write_fix)
> > +		imx28_ci_writel(val, ci->hw_bank.regmap[reg]);
> > +	else
> > +		iowrite32(val, ci->hw_bank.regmap[reg]);
> > +#else
> > 
> >   	iowrite32(val, ci->hw_bank.regmap[reg]);
> > 
> > +#endif
> > 
> >   	return val;
> >   
> >   }
> 
> Can't we remove the #ifdefs CONFIG_SOC_IMX28 all around?
> The check is done on the new flag ci->imx28_write_fix which exists for all
> platforms, isn't it?.

The SWP instruction is specific to ARM, so you'd need to stub-out the 
imx28_ci_writel() with ifdef then.
