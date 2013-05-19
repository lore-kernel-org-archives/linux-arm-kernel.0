From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 19 May 2013 15:41:55 +0200
Subject: [PATCH v2] net: dm9000: Allow instantiation using device tree
In-Reply-To: <5198D359.5060608@gmail.com>
References: <1368962191-32594-1-git-send-email-tomasz.figa@gmail.com>
 <5198D359.5060608@gmail.com>
Message-ID: <15046898.dr5fzcR9ZS@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Sunday 19 of May 2013 15:27:53 Sylwester Nawrocki wrote:
> Hi,
> 
> On 05/19/2013 01:16 PM, Tomasz Figa wrote:
> > +++ b/Documentation/devicetree/bindings/net/davicom-dm9000.txt
> > @@ -0,0 +1,26 @@
> > +Davicom DM9000 Fast Ethernet controller
> > +
> > +Required properties:
> > +- compatible = "davicom,dm9000";
> > +- reg : physical addresses and sizes of registers, must contain 2
> > entries: +    first entry : address register,
> > +    second entry : address register.
> 
> Two address registers ? Shouldn't one of these be "data register" ?

Oops. I thought I already corrected this typo. Thanks.

> > +Example:
> > +
> > +	ethernet at 18000000 {
> > +		compatible = "davicom,dm9000";
> > +		reg =<0x18000000 0x2 0x18000004 0x2>;
> > +		interrupt-parent =<&gpn>;
> > +		interrupts =<7 4>;
> > +		local-mac-address = [00 00 de ad be ef];
> > +		davicom,no-eeprom;
> > +	};
> > 
> > +static struct dm9000_plat_data *dm9000_parse_dt(struct device *dev)
> > +{
> > +	struct dm9000_plat_data *pdata;
> > +	struct device_node *np = dev->of_node;
> > +	const void *mac_addr;
> > +
> > +	if (!IS_ENABLED(CONFIG_OF) || !np)
> > +		return NULL;
> 
> Shouldn't ERR_PTR() value be returned here ?

Nope. No platform data is a valid case, so no error here.

> > +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata) {
> > +		dev_err(dev, "failed to allocate platform data struct\n");
> 
> There is no need for this error log, k*alloc already logs any failures.

Hmm. Does it print what allocation exactly failed? (e.g. a backtrace)

Not that it would give anything that could help you in an out of memory 
condition like this, but in general it's good to know in what point the 
failure happened.

Best regards,
Tomasz

> > @@ -1373,6 +1402,12 @@ dm9000_probe(struct platform_device *pdev)
> > 
> >   	int i;
> >   	u32 id_val;
> > 
> > +	if (!pdata) {
> > +		pdata = dm9000_parse_dt(&pdev->dev);
> > +		if (IS_ERR(pdata))
> > +			return PTR_ERR(pdata);
> > +	}
> 
> Thanks,
> 
> Sylwester
