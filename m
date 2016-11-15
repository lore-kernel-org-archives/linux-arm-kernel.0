From: sriram.dash@nxp.com (Sriram Dash)
Date: Tue, 15 Nov 2016 12:39:26 +0000
Subject: [upstream-release] [PATCH 1/2] drivers: usb: phy: Add qoriq usb
 3.0	phy driver support
In-Reply-To: <DB5PR0401MB1928CA058CC01243457F124791BC0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1479101215-26954-1-git-send-email-sriram.dash@nxp.com>
 <1479101215-26954-2-git-send-email-sriram.dash@nxp.com>
 <DB5PR0401MB1928CA058CC01243457F124791BC0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Message-ID: <DB5PR0401MB1925FB1FE45C15B0671E46D1F5BF0@DB5PR0401MB1925.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Scott Wood
>On 11/13/2016 11:27 PM, Sriram Dash wrote:
>> diff --git a/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>> b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>> new file mode 100644
>> index 0000000..d934c80
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>> @@ -0,0 +1,36 @@
>> +Driver for Freescale USB 3.0 PHY
>> +
>> +Required properties:
>> +
>> +- compatible :	fsl,qoriq-usb3-phy
>

Hi Scott,

>This is a very vague compatible.  Are there versioning registers within this register
>block?
>

There are versioning registers for the phy (1.0 and 1.1). But the current erratum
A008751 does not require the mentioning of the version numbers. Was planning
to take care of the versioning when there is code diversity on the basis of the
version number.
Shall I include the versioning in the documentation now for 1.0 and 1.1?

>> +/* Parameter control */
>> +#define USB3PRM1CR		0x000
>> +#define USB3PRM1CR_VAL		0x27672b2a
>> +
>> +/*
>> + * struct qoriq_usb3_phy - driver data for USB 3.0 PHY
>> + * @dev: pointer to device instance of this platform device
>> + * @param_ctrl: usb3 phy parameter control register base
>> + * @phy_base: usb3 phy register memory base
>> + * @has_erratum_flag: keeps track of erratum applicable on device  */
>> +struct qoriq_usb3_phy {
>> +	struct device *dev;
>> +	void __iomem *param_ctrl;
>> +	void __iomem *phy_base;
>> +	u32 has_erratum_flag;
>> +};
>> +
>> +static inline u32 qoriq_usb3_phy_readl(void __iomem *addr, u32
>> +offset) {
>> +	return __raw_readl(addr + offset);
>> +}
>> +
>> +static inline void qoriq_usb3_phy_writel(void __iomem *addr, u32 offset,
>> +	u32 data)
>> +{
>> +	__raw_writel(data, addr + offset);
>> +}
>
>Why raw?  Besides missing barriers, this will cause the accesses to be native-endian
>which is not correct.
>

The only reason for __raw_writel is to make the code faster. However, shall I use
writel(with both barriers and byte swap) instead and then make appropriate changes
in the value 32'h27672B2A?

>> +/*
>> + * Erratum A008751
>> + * SCFG USB3PRM1CR has incorrect default value
>> + * SCFG USB3PRM1CR reset value should be 32'h27672B2A instead of
>32'h25E72B2A.
>
>When documenting C code, can you stick with C-style numeric constants?
>
>For that matter, just put the constant in the code instead of hiding it in an overly-
>generically-named USB3PRM1CR_VAL and then you won't need to redundantly
>state the value in a comment.  Normally putting magic numbers in symbolic
>constants is a good thing, but in this case it's not actually describing anything and
>the number is of no meaning outside of this one erratum workaround (it might even
>be a different value if another chip has a similar erratum).
>

The POR value of the USB3PRM1CR  should be 32'h27672B2A. So, I had named it as
such. Thanks for the info. Will remove the USB3PRM1CR_VAL and during writel,
will use 0x27672b2a directly. I will take care the next time.

>> + */
>> +static void erratum_a008751(struct qoriq_usb3_phy *phy) {
>> +	qoriq_usb3_phy_writel(phy->param_ctrl, USB3PRM1CR,
>> +				USB3PRM1CR_VAL);
>> +}
>> +
>> +/*
>> + * qoriq_usb3_phy_erratum - List of phy erratum
>> + * @qoriq_phy_erratum - erratum application
>> + * @compat - comapt string for erratum  */
>> +
>> +struct qoriq_usb3_phy_erratum {
>> +	void (*qoriq_phy_erratum)(struct qoriq_usb3_phy *phy);
>> +	char *compat;
>> +};
>> +
>> +/* Erratum list */
>> +struct qoriq_usb3_phy_erratum  phy_erratum_tbl[] = {
>> +	{&erratum_a008751, "fsl,usb-erratum-a008751"},
>> +	/* Add init time erratum here */
>> +};
>
>This needs to be static.
>

Ok. Will take care next time.

>Unnecessary & on the function pointer.
>

Ok. Will change in next version.

>> +static int qoriq_usb3_phy_init(struct phy *x) {
>> +	struct qoriq_usb3_phy *phy = phy_get_drvdata(x);
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(phy_erratum_tbl); i++)
>> +		if (phy->has_erratum_flag & 1 << i)
>> +			phy_erratum_tbl[i].qoriq_phy_erratum(phy);
>> +	return 0;
>> +}
>> +
>> +static const struct phy_ops ops = {
>> +	.init		= qoriq_usb3_phy_init,
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>> +static int qoriq_usb3_phy_probe(struct platform_device *pdev) {
>> +	struct qoriq_usb3_phy *phy;
>> +	struct phy *generic_phy;
>> +	struct phy_provider *phy_provider;
>> +	const struct of_device_id *of_id;
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	int i, ret;
>> +
>> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>> +	if (!phy)
>> +		return -ENOMEM;
>> +	phy->dev = dev;
>> +
>> +	of_id = of_match_device(dev->driver->of_match_table, dev);
>> +	if (!of_id) {
>> +		dev_err(dev, "failed to get device match\n");
>> +		ret = -EINVAL;
>> +		goto err_out;
>> +	}
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>"param_ctrl");
>> +	if (!res) {
>> +		dev_err(dev, "failed to get param_ctrl memory\n");
>> +		ret = -ENOENT;
>> +		goto err_out;
>> +	}
>> +
>> +	phy->param_ctrl = devm_ioremap_resource(dev, res);
>> +	if (!phy->param_ctrl) {
>> +		dev_err(dev, "failed to remap param_ctrl memory\n");
>> +		ret = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>"phy_base");
>> +	if (!res) {
>> +		dev_err(dev, "failed to get phy_base memory\n");
>> +		ret = -ENOENT;
>> +		goto err_out;
>> +	}
>> +
>> +	phy->phy_base = devm_ioremap_resource(dev, res);
>> +	if (!phy->phy_base) {
>> +		dev_err(dev, "failed to remap phy_base memory\n");
>> +		ret = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +
>> +	phy->has_erratum_flag = 0;
>> +	for (i = 0; i < ARRAY_SIZE(phy_erratum_tbl); i++)
>> +		phy->has_erratum_flag |= device_property_read_bool(dev,
>> +						phy_erratum_tbl[i].compat) << i;
>
>I don't see the erratum property in either the binding or the device tree.  Also, a
>property name is not a "compat".
>

Ok. Will rename "char *compat" into "char *prop".

>Is there a reason why this flag and array mechanism is needed, rather than just
>checking the erratum properties from the init function -- or, if you have a good
>reason to not want to do device tree accesses from init, just using a bool per
>erratum?  How many errata are you expecting?
>

The erratum prop will be specified via the dt and parsed in the init. The idea
behind the table is that it will accommodate more errata and every time we
are adding a new erratum, and the code changes would be minimal(with this
approach, we don't have to add new variable in qoriq_usb3_phy struct
corresponding to every new erratum being added).

In my knowledge, there are more than 5 errata in pipeline, and all of them
have to be applied in the init time. So, this table will make the code more
readable and less cumbersome. 

However, in future, if any other erratum comes up, and it has to be applied
at any point other than during init, then the variable has to be added in
qoriq_usb3_phy struct and the property has to be read separately.

>-Scott
