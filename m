From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 13 May 2011 03:25:20 +0200
Subject: [PATCH] [media] at91: add Atmel Image Sensor Interface (ISI)
	support
In-Reply-To: <4DCC5040.6050300@bluewatersys.com>
References: <1305186138-5656-1-git-send-email-josh.wu@atmel.com>
	<4DCC5040.6050300@bluewatersys.com>
Message-ID: <20110513012520.GL18952@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +/* Constants for RGB_CFG(ISI_V2) */
> > +#define ISI_V2_RGB_CFG_DEFAULT			0
> > +#define ISI_V2_RGB_CFG_MODE_1			1
> > +#define ISI_V2_RGB_CFG_MODE_2			2
> > +#define ISI_V2_RGB_CFG_MODE_3			3
> > +
> > +/* Bit manipulation macros */
> > +#define ISI_BIT(name)					\
> > +	(1 << ISI_##name##_OFFSET)
> > +#define ISI_BF(name, value)				\
> > +	(((value) & ((1 << ISI_##name##_SIZE) - 1))	\
> > +	 << ISI_##name##_OFFSET)
> > +#define ISI_BFEXT(name, value)				\
> > +	(((value) >> ISI_##name##_OFFSET)		\
> > +	 & ((1 << ISI_##name##_SIZE) - 1))
> > +#define ISI_BFINS(name, value, old)			\
> > +	(((old) & ~(((1 << ISI_##name##_SIZE) - 1)	\
> > +		    << ISI_##name##_OFFSET))\
> > +	 | ISI_BF(name, value))
> 
> I really dislike this kind of register access magic. Not sure how others
> feel about it. These macros are really ugly.
> 
> > +/* Register access macros */
> > +#define isi_readl(port, reg)				\
> > +	__raw_readl((port)->regs + ISI_##reg)
> > +#define isi_writel(port, reg, value)			\
> > +	__raw_writel((value), (port)->regs + ISI_##reg)
> 
> If the token pasting stuff gets dropped then these can be static inline
> functions which is preferred.
Sorry this make the C code much readable
and this can not be done as a inline

so please keep it as is
> 
> > +
> > +#define ATMEL_V4L2_VID_FLAGS (V4L2_CAP_VIDEO_OUTPUT)
> > +
> > +struct atmel_isi;
> > +
> > +enum atmel_isi_pixfmt {
> > +	ATMEL_ISI_PIXFMT_GREY,		/* Greyscale */

> > +		dev_info(&pdev->dev,
> > +			"No config available using default values\n");
> > +		pdata = &isi_default_data;
> > +	}
> > +
> > +	isi->pdata = pdata;
> > +	isi->platform_flags = pdata->flags;
> > +	if (isi->platform_flags == 0)
> > +		isi->platform_flags = ISI_DATAWIDTH_8;
> 
> We could be mean here an require that people get the flags correct, e.g.
> 
> 	if (!((isi->platform_flags & ISI_DATA_WIDTH_8) ||
> 	      (isi->platform_flags & ISI_DATA_WIDTH_8))) {
> 		dev_err(&pdev->dev, "No data width specified\n");
> 		err = -ENOMEM;
> 		goto fail;
> 	}
> 
> Which discourages sloppy coding in the board files.
if this means default configuration so not need to have all board to set it
> 
> > +
> > +	isi_writel(isi, V2_CTRL, ISI_BIT(V2_DIS));
> > +	/* Check if module disable */
> > +	while (isi_readl(isi, V2_STATUS) & ISI_BIT(V2_DIS))
> > +		cpu_relax();
> > +
> > +	irq = platform_get_irq(pdev, 0);

Best Regards,
J.
