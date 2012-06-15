From: zhouqiao@marvell.com (Qiao Zhou)
Date: Fri, 15 Jun 2012 11:17:21 +0800
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <201206141227.48867.arnd@arndb.de>
References: <1339578251-15009-1-git-send-email-zhouqiao@marvell.com>
 <1339578251-15009-2-git-send-email-zhouqiao@marvell.com>
 <201206141227.48867.arnd@arndb.de>
Message-ID: <4FDAA941.2070106@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2012 08:27 PM, Arnd Bergmann wrote:
> On Wednesday 13 June 2012, Qiao Zhou wrote:
>> 88PM800 and 88PM805 are two discrete chips used for power management.
>> Hardware designer can use them together or only one of them according to
>> requirement.
>>
>> There's some logic tightly linked between these two chips. For example, USB
>> charger driver needs to access both chips by I2C interface.
>>
>> Now share one driver to these two devices. Only one I2C client is identified
>> in platform init data. If one chip is also used, user should mark it with
>> related i2c_addr field of platform init data. Then driver could create another
>> I2C client for the chip.
>>
>> All I2C operations are accessed by 80x-i2c driver. In order to support all
>> I2C client address, the read/write API is changed in below.
>>
>> reg_read(client, offset)
>> reg_write(client, offset, data)
>>
>> The benefit is that client drivers only need one kind of read/write API. I2C
>> and MFD driver can be shared in both 800 and 805.
>>
>> Signed-off-by: Qiao Zhou<zhouqiao@marvell.com>
>
>
>
>
>>   drivers/mfd/88pm80x-core.c  | 1002 +++++++++++++++++++++++++++++++++++++++++++
>>   drivers/mfd/88pm80x-i2c.c   |  370 ++++++++++++++++
>>   drivers/mfd/Kconfig         |   11 +
>>   drivers/mfd/Makefile        |    2 +
>>   include/linux/mfd/88pm80x.h |  701 ++++++++++++++++++++++++++++++
>>   5 files changed, 2086 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/mfd/88pm80x-core.c
>>   create mode 100644 drivers/mfd/88pm80x-i2c.c
>>   create mode 100644 include/linux/mfd/88pm80x.h
>>
>> +
>> +static struct resource rtc_resources[] = {
>> +	{
>> +	 .name = "88pm80x-rtc",
>> +	 .start = PM800_IRQ_RTC,
>> +	 .end = PM800_IRQ_RTC,
>> +	 .flags = IORESOURCE_IRQ,
>> +	 },
>> +};
>> +
>> +static struct mfd_cell rtc_devs[] = {
>> +	{
>> +	 .name = "88pm80x-rtc",
>> +	 .num_resources = ARRAY_SIZE(rtc_resources),
>> +	 .resources =&rtc_resources[0],
>> +	 .id = -1,
>> +	 },
>> +};
>> +
>> +static struct resource onkey_resources[] = {
>> +	{
>> +	 .name = "88pm80x-onkey",
>> +	 .start = PM800_IRQ_ONKEY,
>> +	 .end = PM800_IRQ_ONKEY,
>> +	 .flags = IORESOURCE_IRQ,
>> +	 },
>> +};
>> +
>> +static struct mfd_cell onkey_devs[] = {
>> +	{
>> +	 .name = "88pm80x-onkey",
>> +	 .num_resources = 1,
>> +	 .resources =&onkey_resources[0],
>> +	 .id = -1,
>> +	 },
>> +};
>
> I wonder if it really makes sense to use the mfd_cell abstraction here, when each
> array only contains a single device. Why not just use
> platform_device_register_simple()?
two reasons for using mfd_dev: firstly it's extensible if we have more 
onkey_devices in future; secondly it's for device registry consistency.
>
>> +
>> +static struct pm80x_irq_data pm805_irqs[] = {
>> +	[PM805_IRQ_LDO_OFF] = {	/*0 */
>> +			       .reg = PM805_INT_STATUS1,
>> +			       .mask_reg = PM805_INT_MASK1,
>> +			       .offs = 1<<  5,
>> +			       },
>> +	[PM805_IRQ_SRC_DPLL_LOCK] = {
>> +				     .reg = PM805_INT_STATUS1,
>> +				     .mask_reg = PM805_INT_MASK1,
>> +				     .offs = 1<<  4,
>> +				     },
>> +	[PM805_IRQ_CLIP_FAULT] = {
>> +				  .reg = PM805_INT_STATUS1,
>> +				  .mask_reg = PM805_INT_MASK1,
>> +				  .offs = 1<<  3,
>> +				  },
>> +	[PM805_IRQ_MIC_CONFLICT] = {
>> +				    .reg = PM805_INT_STATUS1,
>> +				    .mask_reg = PM805_INT_MASK1,
>> +				    .offs = 1<<  2,
>> +				    },
>
> [coding style] This uses a very unusual indentation. Just use a single tab to
> indent the fields in each of the irq data descriptions.
would update in next version.
>
>> +static inline struct pm80x_irq_data *irq_to_pm805(struct pm80x_chip *chip,
>> +						  int irq)
>> +{
>> +	int offset = irq - chip->pm805_chip->irq_base;
>> +	if (!chip->pm805_chip || (offset<  0)
>> +	    || (offset>= ARRAY_SIZE(pm805_irqs)))
>> +		return NULL;
>> +	return&pm805_irqs[offset];
>> +}
>> +
>> +static irqreturn_t pm805_irq(int irq, void *data)
>> +{
>> +	struct pm80x_chip *chip = data;
>> +	struct pm80x_subchip *pm805_chip = chip->pm805_chip;
>> +	struct pm80x_irq_data *irq_data;
>> +	struct i2c_client *i2c;
>> +	int i, read_reg = -1, value = 0;
>
> The functions for pm800 and pm805 look almost identical. Have you tried
> consolidating them so you can use the same irqchip and code with different
> init data structures?
would update in next version.
>
>> +int pm80x_reg_read(struct i2c_client *i2c, int reg)
>> +{
>> +	struct regmap *map = verify_regmap(i2c);
>> +	unsigned int data;
>> +	int ret;
>> +
>> +	ret = regmap_read(map, reg,&data);
>> +	if (ret<  0)
>> +		return ret;
>> +	else
>> +		return (int)data;
>> +}
>> +EXPORT_SYMBOL(pm80x_reg_read);
>> +
>> +int pm80x_reg_write(struct i2c_client *i2c, int reg,
>> +		     unsigned char data)
>> +{
>> +	struct regmap *map = verify_regmap(i2c);
>> +	int ret;
>> +
>> +	ret = regmap_write(map, reg, data);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(pm80x_reg_write);
>
> These functions should be EXPORT_SYMBOL_GPL if you really need them.
> My impression however is that you'd be better off without them
> and just let the client use the regmap directly after you export
> the verify_regmap function under a more appropriate name.
>
would update EXPORT_SYMBOL_GPL and export related regmap API.
>> +static const struct i2c_device_id pm80x_id_table[] = {
>> +	{"88PM80x", 0},
>> +	{}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
>> +
>> +static int verify_addr(struct i2c_client *i2c)
>> +{
>> +	unsigned short addr_800[] = { 0x30, 0x34 };
>> +	unsigned short addr_805[] = { 0x38, 0x39 };
>> +	int size, i;
>> +
>> +	if (i2c == NULL)
>> +		return 0;
>> +	size = ARRAY_SIZE(addr_800);
>> +	for (i = 0; i<  size; i++) {
>> +		if (i2c->addr == *(addr_800 + i))
>> +			return CHIP_PM800;
>> +	}
>> +	size = ARRAY_SIZE(addr_805);
>> +	for (i = 0; i<  size; i++) {
>> +		if (i2c->addr == *(addr_805 + i))
>> +			return CHIP_PM805;
>> +	}
>> +	return 0;
>> +}
>
> I think you should just put the devices separately into the device
> tree so they get probed independently. Hardcoding the address
> in the source code does not seem appropriate. Also, I would expect
> that the device name is already the specific one (88pm800 or
> 88pm805) in the device tree. Just put both in the pm80x_id_table
> and use the driver_data field to distinguish them.
>
would update in next version.
>> +static int pm80x_pages_init(struct pm80x_chip *chip, struct i2c_client *client,
>> +			    struct pm80x_platform_data *pdata)
>> +{
>> +	/*
>> +	 * Both pm800 and pm805 shares the same platform driver.
>> +	 * check whether we have have pm805 driver.
>> +	 */
>> +	if (pdata->pm805_addr) {
>> +		chip->pm805_addr = pdata->pm805_addr;
>> +		/* in case we only have pm805, it already registers
>> +		 * i2c handle, then no need to register again.
>> +		 */
>> +		if (chip->id != CHIP_PM805) {
>> +			chip->client_pm805 =
>> +			    i2c_new_dummy(client->adapter, chip->pm805_addr);
>> +			chip->regmap_pm805 = devm_regmap_init_i2c(chip->client_pm805,&pm80x_regmap_config);
>> +			i2c_set_clientdata(chip->client_pm805, chip);
>> +
>> +			device_init_wakeup(&chip->client_pm805->dev, 1);
>> +		}
>
> No reason to put the address into platform_data, just use the regular
> i2c device address.
>
would update in next version.
>> +struct pm80x_subchip {
>> +	struct device *dev;
>> +	struct pm80x_chip *chip;
>> +	struct pm80x_platform_data *pdata;
>> +	struct i2c_client *client;
>> +	int irq;
>> +	int irq_base;
>> +	int irq_mode;
>> +};
>
> What is a "subchip"?
>
>> +struct pm80x_chip {
>> +	/*chip_version can only on the top of the struct*/
>> +	unsigned char chip800_version;
>> +	unsigned char chip805_version;
>> +	struct device *dev;
>> +	struct pm80x_subchip *pm800_chip;
>> +	struct pm80x_subchip *pm805_chip;
>> +	struct mutex io_lock;
>> +	struct mutex pm800_irq_lock;
>> +	struct mutex pm805_irq_lock;
>> +	struct i2c_client *client_pm800;
>> +	struct i2c_client *client_pm805;
>> +	struct i2c_client *base_page;	/* chip client for base page */
>> +	struct i2c_client *power_page;	/* chip client for power page */
>> +	struct i2c_client *gpadc_page;	/* chip client for gpadc page */
>> +	struct regmap *regmap_pm800;
>> +	struct regmap *regmap_pm805;
>> +	struct regmap *regmap_power;
>> +	struct regmap *regmap_gpadc;
>> +
>> +	unsigned short pm800_addr;
>> +	unsigned short pm805_addr;
>> +	unsigned short base_page_addr;	/* base page I2C address */
>> +	unsigned short power_page_addr;	/* power page I2C address */
>> +	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
>> +	int id;
>> +	int irq_pm800;
>> +	int irq_pm805;
>> +	int irq_pm800_base;
>> +	int irq_pm805_base;
>> +	unsigned int wu_flag_pm800;
>> +	unsigned int wu_flag_pm805;
>> +};
>
> You have duplicated almost every field in this structure, which appears
> to be very suboptimal. Better put all common fields into one structure
> and then make a derived data structure for the specific ones, like
>
> struct pm80x_chip {
> 	char version;
> 	struct pm80x_subchip *subchip;
> 	struct mutex irq_lock;
> 	struct i2c_client i2c;
> 	...
> 	unsigned int wu_flag;
> };
>
> struct pm800_chip {
> 	struct pm80x_chip chip;
> 	struct i2c_client *base_page;
> 	...
> };
>
> struct pm805_chip {
> 	struct pm80x_chip chip;
> 	struct i2c_client *power_page;
> 	...
> };
>
you're right. the code is not well managed. would update in next version.
>> +struct pm80x_rtc_pdata {
>> +	int		(*sync)(unsigned int ticks);
>> +	int		vrtc;
>> +	int             rtc_wakeup;
>> +};
>> +
>> +struct pm80x_platform_data {
>> +	struct pm80x_rtc_pdata *rtc;
>> +	unsigned short pm800_addr;
>> +	unsigned short pm805_addr;
>> +	unsigned short base_page_addr;	/* base page I2C address */
>> +	unsigned short power_page_addr;	/* power page I2C address */
>> +	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
>> +	unsigned short test_page_addr;	/* test page regs I2C address */
>> +	int i2c_port;		/* Controlled by GI2C or PI2C */
>> +	int irq_mode;		/* Clear interrupt by read/write(0/1) */
>> +	int irq_pm800;		/* IRQ of 88pm800 */
>> +	int irq_pm805;		/* IRQ of 88pm805 */
>> +	int irq_pm800_base;		/* IRQ base number of 88pm800 */
>> +	int irq_pm805_base;		/* IRQ base number of 88pm805 */
>> +	int batt_det;		/* enable/disable */
>> +
>> +	int (*pm800_plat_config)(struct pm80x_chip *chip,
>> +				struct pm80x_platform_data *pdata);
>> +	int (*pm805_plat_config)(struct pm80x_chip *chip,
>> +				struct pm80x_platform_data *pdata);
>> +};
>
> The *_plat_config fields are completely unused here, better remove them.
>
> The interrupt numbers should become irq resources.
>
> Any field in the platform data that cannot be converted to a resource
> or completely removed should have a respective property in the device
> tree binding for this device.
would update in next version.
>
> 	Arnd

Arnd, thanks for your careful review and great suggestions!

-- 

Best Regards
Qiao
