From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 20:59:06 -0800
Subject: [PATCH v2 2/7] ARM: imx5: adopt generic_chip irq_domain support
 for tzic
In-Reply-To: <4F3C7B45.1080907@gmail.com>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
 <1329331668-30325-3-git-send-email-shawn.guo@linaro.org>
 <4F3C7B45.1080907@gmail.com>
Message-ID: <20120216045905.GI30946@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 09:43:01PM -0600, Rob Herring wrote:
...
> > +static inline void __iomem *get_gpt_base_dt(struct device_node *np);
> > +static inline int get_gpt_irq_dt(struct device_node *np);
> > +
> >  int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
> >  			unsigned long ckih1, unsigned long ckih2)
> >  {
> >  	int i;
> > +	int gpt_irq = MX51_INT_GPT;
> > +	void __iomem *gpt_base = MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR);
> > +	struct device_node *np = of_find_compatible_node(NULL, NULL, "fsl,gpt");
> >  
> >  	external_low_reference = ckil;
> >  	external_high_reference = ckih1;
> > @@ -1592,8 +1600,12 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
> >  	clk_set_rate(&esdhc2_clk, 166250000);
> >  
> >  	/* System timer */
> > -	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
> > -		MX51_INT_GPT);
> > +	if (np) {
> > +		gpt_base = get_gpt_base_dt(np);
> > +		gpt_irq = get_gpt_irq_dt(np);
> > +	}
> > +	WARN_ON(!gpt_base);
> > +	mxc_timer_init(&gpt_clk, gpt_base, gpt_irq);
> >  	return 0;
> >  }
> >  
> > @@ -1601,6 +1613,9 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
> >  			unsigned long ckih1, unsigned long ckih2)
> >  {
> >  	int i;
> > +	int gpt_irq = MX53_INT_GPT;
> > +	void __iomem *gpt_base = MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR);
> > +	struct device_node *np = of_find_compatible_node(NULL, NULL, "fsl,gpt");
> >  
> >  	external_low_reference = ckil;
> >  	external_high_reference = ckih1;
> > @@ -1629,8 +1644,12 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
> >  	clk_set_rate(&esdhc3_mx53_clk, 200000000);
> >  
> >  	/* System timer */
> > -	mxc_timer_init(&gpt_clk, MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
> > -		MX53_INT_GPT);
> > +	if (np) {
> > +		gpt_base = get_gpt_base_dt(np);
> > +		gpt_irq = get_gpt_irq_dt(np);
> > +	}
> > +	WARN_ON(!gpt_base);
> > +	mxc_timer_init(&gpt_clk, gpt_base, gpt_irq);
> >  	return 0;
> >  }
> >  
> > @@ -1672,4 +1691,24 @@ int __init mx53_clocks_init_dt(void)
> >  	clk_get_freq_dt(&ckil, &osc, &ckih1, &ckih2);
> >  	return mx53_clocks_init(ckil, osc, ckih1, ckih2);
> >  }
> > +
> > +static inline void __iomem *get_gpt_base_dt(struct device_node *np)
> > +{
> > +	return of_iomap(np, 0);
> > +}
> > +
> > +static inline int get_gpt_irq_dt(struct device_node *np)
> > +{
> > +	return irq_of_parse_and_map(np, 0);
> > +}
> > +#else
> > +static inline void __iomem *get_gpt_base_dt(struct device_node *np)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline int get_gpt_irq_dt(struct device_node *np)
> > +{
> > +	return -ENODEV;
> > +}
> 
> Reorder so you don't need forward declarations.
> 
I'm trying to save one more occurrence of "#ifdef CONFIG_OF", or I
to move around the whole block wrapped by #ifdef, which will make
unnecessary diffstat churn.

I hope we can stop this nasty #ifdef at some point by select CONFIG_OF
for the imx architecture.

> Once again, I think this is too intermixed with DT and non-DT, but you
> are getting the data from DT so I guess it's fine for now.
> 
I guess that's the situation we have to live with until the non-DT
support gets completely removed.

-- 
Regards,
Shawn
