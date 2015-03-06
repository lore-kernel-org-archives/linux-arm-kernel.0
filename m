From: stefan@agner.ch (Stefan Agner)
Date: Fri, 06 Mar 2015 14:31:51 +0100
Subject: [PATCH 1/5] mtd: nand: =?UTF-8?Q?vf=36=31=30=5Fnfc=3A=20Frees?=
 =?UTF-8?Q?cale=20NFC=20for=20VF=36=31=30=2C=20MPC=35=31=32=35=20and=20oth?=
 =?UTF-8?Q?ers?=
In-Reply-To: <20150306061502.GB10997@pengutronix.de>
References: <1425510624-22250-1-git-send-email-stefan@agner.ch>
 <1425510624-22250-2-git-send-email-stefan@agner.ch>
 <20150306061502.GB10997@pengutronix.de>
Message-ID: <fdfc84d92bbcb8abc98f2c29e1aa368b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-06 07:15, Sascha Hauer wrote:
> Hi Stefan,
> 
> On Thu, Mar 05, 2015 at 12:10:20AM +0100, Stefan Agner wrote:
>> +
>> +static int vf610_nfc_probe_dt(struct device *dev, struct vf610_nfc_config *cfg)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	int buswidth;
>> +	u32 clkrate;
>> +
>> +	if (!np)
>> +		return 1;
>> +
>> +	cfg->flash_bbt = of_get_nand_on_flash_bbt(np);
>> +
>> +	if (!of_property_read_u32(np, "clock-frequency", &clkrate))
>> +		cfg->clkrate = clkrate;
> 
> Normally the clock-frequency property tells the driver at which
> frequency the device actually is running, not to tell the driver at
> which frequency the device *should* run. It's strange to use the value
> of the clock-frequency property as input to clk_set_rate(). Maybe the
> assigned clock binding is more appropriate here, see
> Documentation/devicetree/bindings/clock/clock-bindings.txt.

What we try to do here is to specify the hardware limitations. There
seem to be some hardware restrictions when it comes to clock
frequencies. There has been a rather long discussion over at Freescales
community about it:
https://community.freescale.com/thread/317074

Not sure if this is the right way to specify the supported frequencies,
or should we create a custom property for this, something like
fsl,max-nfc-frequency = <33000000>?


> 
> BTW the above can easier be written as:
> 
> 	of_property_read_u32(np, "clock-frequency", &cfg->clkrate);
> 
> No return value checking necessary.
> 
>> +static int vf610_nfc_probe(struct platform_device *pdev)
>> +{
>> +	struct vf610_nfc *nfc;
>> +	struct resource *res;
>> +	struct mtd_info *mtd;
>> +	struct nand_chip *chip;
>> +	struct vf610_nfc_config *cfg;
>> +	int err = 0;
>> +	int page_sz;
>> +	int irq;
>> +
>> +	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
>> +	if (!nfc)
>> +		return -ENOMEM;
>> +
>> +	nfc->cfg = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
>> +	if (!nfc->cfg)
>> +		return -ENOMEM;
>> +	cfg = nfc->cfg;
> 
> Why is nfc->cfg allocated separately instead of embedding it into struct
> vf610_nfc? Is this some platform_data leftover you can remove now?
> 

Yeah, looks like a platform_data leftover, will change that.

>> +
>> +	nfc->dev = &pdev->dev;
>> +	nfc->page = -1;
>> +	mtd = &nfc->mtd;
>> +	chip = &nfc->chip;
>> +
>> +	mtd->priv = chip;
>> +	mtd->owner = THIS_MODULE;
>> +	mtd->dev.parent = nfc->dev;
>> +	mtd->name = DRV_NAME;
>> +
>> +	err = vf610_nfc_probe_dt(nfc->dev, cfg);
>> +	if (err)
>> +		return -ENODEV;
> 
> Does this driver work without device tree or not? Currently the driver
> bails out when device tree support is enabled but no device node is
> given. When device tree support is disabled in the kernel though the
> driver happily continues here.
> 

Hm, I never tried using this Driver without DT. I guess in practice, we
won't get here in a DT enabled kernel anyway: If there is no device tree
node with one of the drivers compatibility ids, the probe function won't
be called.

Theoretically, the IP supported by this driver is part of two other
SoC's which are supported by Linux: PowerPC MPC5125 (DT) and a ColdFire
MCF54418 (non-DT). So this driver might be used on a ColdFire SoC using
the platform support. Currently, one would just not have the ability to
set the hardware ECC options... I'm a bit reluctant to implement full
platform support without being able to properly test it. If anybody is
interested in it, one could easily extend the driver...

Put Geert in CC...

--
Stefan
