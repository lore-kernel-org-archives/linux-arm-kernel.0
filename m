From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Thu, 20 Mar 2014 06:07:31 +0000
Subject: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
In-Reply-To: <20140318081019.GJ11360@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
 <1394894616.578942243@f331.i.mail.ru> <20140318081019.GJ11360@pengutronix.de>
Message-ID: <5b62326226b54b1da0addf839cbcd104@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Subject: Re: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
> 
> On Sat, Mar 15, 2014 at 06:43:36PM +0400, Alexander Shiyan wrote:
> > ???????, 15 ????? 2014, 13:44 +01:00 ?? Markus Pargmann <mpa@pengutronix.de>:
> > > This patch replaces the ssi specific functions write_ssi, read_ssi and
> > > write_ssi_mask by standard regmap function calls.
> > ...
> > > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > ...
> > > +static const struct regmap_config fsl_ssi_regconfig = {
> > > +	.max_register = CCSR_SSI_SACCDIS,
> > > +	.reg_bits = 32,
> > > +	.val_bits = 32,
> > > +	.reg_stride = 4,
> > > +#ifdef PPC
> > > +	.val_format_endian = REGMAP_ENDIAN_BIG,
> > > +#endif
> > > +};
> >
> > Why we cannot use REGMAP_ENDIAN_NATIVE here for all cases?
> > Theoretically, we can use for i.MX SOCs with different endianness,
> > so this will help us.
> 
> I can change and test it on i.MX, but I am not sure if it helps with the
> PPC situation as I don't have the hardware.
> 

For the scenario of PowerPC(for CPU and devices mostly are in BE mode):
CPU		SSI
BE		BE	we can just use the REGMAP_ENDIAN_NATIVE here.

For the scenario of ARM(for CPU and devices mostly are in LE mode):
CPU		SSI
LE		LE	we can also just use the REGMAP_ENDIAN_NATIVE here.

While for the scenario like our LS1(ARM) platform.
CPU		SSI
LE		BE	then should we set the .val_format_endian to
			REGMAP_ENDIAN_BIG


And so not only for PowerPC, but also maybe for ARM platforms.
So here how about just adding one Boolean property like 'big-endian' in DT node
to learn the endianness of the devices dynamically ?  

Thanks,
:)

Best Regards,
Xiubo
