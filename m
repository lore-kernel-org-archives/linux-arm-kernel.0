From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Mon, 18 Jul 2011 15:45:57 +0530
Subject: [PATCH 3/4] dt: omap3: add generic board file for dt support
In-Reply-To: <CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
	<CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
	<CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
Message-ID: <CAP6yH7eSmdU16r5iC2MwvU3RwOBXaJNygMUXG=HSMiWUKnor-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 17 July 2011 10:43, Grant Likely <grant.likely@secretlab.ca> wrote:
> Hi Manjunath,
>
> Comments below. ?I left in a lot of context for the new folks that
> I've cc'd (Tony and Kevin).
>
> On Sat, Jul 16, 2011 at 2:07 PM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
>> On Thu, Jul 14, 2011 at 4:45 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>>> > +static void __init omap3_init(void)
>>>> > +{
>>>> > + ? ? ? struct device_node *node;
>>>> > +
[...]
>> +static struct omap_device *of_omap_i2c_device_create(struct device_node *node,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?const char *bus_id,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?void *platform_data,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device *parent)
>> +{
>> + ? ? ? struct platform_device *pdev;
>> + ? ? ? struct i2c_board_info *i2c_board_info;
>> + ? ? ? u8 id;
>> +
>> + ? ? ? printk("Creating omap i2c device %s\n", node->full_name);
>> +
>> + ? ? ? if (!of_device_is_available(node))
>> + ? ? ? ? ? ? ? return NULL;
>> +
>> + ? ? ? id = simple_strtol(bus_id, NULL, 0);
>> + ? ? ? pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
>> + ? ? ? pdev->dev.of_node = of_node_get(node);
>> + ? ? ? if (!pdev->dev.of_node) {
>> + ? ? ? ? ? ? ? speed = 100;
>> + ? ? ? } else {
>> + ? ? ? ? ? ? ? u32 prop;
>> + ? ? ? ? ? ? ? if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &prop))
>> + ? ? ? ? ? ? ? ? ? ? ? speed = prop/100;
>> + ? ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? ? speed = 100;
>> + ? ? ? }
>> + ? ? ? printk("%s : speed->%d\n",__func__, speed);
>> +
>> + ? ? ? for_each_child_of_node(bus, child) {
>> + ? ? ? ? ? ? ? u32 prop;
>> +
>> + ? ? ? ? ? ? ? printk(" ? create child: %s\n", child->full_name);
>> + ? ? ? ? ? ? ? i2c_board_info = kzalloc(sizeof(*i2c_board_info), GFP_KERNEL);
>> + ? ? ? ? ? ? ? if (!of_property_read_u32(pdev->dev.of_node, "reg",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &prop))
>> + ? ? ? ? ? ? ? i2c_board_info->addr = prop;
>> + ? ? ? ? ? ? ? if (!of_property_read_u32(pdev->dev.of_node, "interrupts",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &prop))
>> + ? ? ? ? ? ? ? i2c_board_info->irq = prop;
>> + ? ? ? ? ? ? ? i2c_board_info->platform_data = platform_data;
>> + ? ? ? ? ? ? ? strncpy(i2c_board_info->type, child->name,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sizeof(i2c_board_info->type));
>> + ? ? ? }
>> + ? ? ? omap_register_i2c_bus(id, speed, i2c_board_info, 1);
>
> While this does in a sense work, and creates an omap_device for the
> i2c bus that does get probed, it ends up encoding an awful lot of
> device specific details into the generic devicetree support code. ?The
> i2c bus driver itself must be responsible for decoding the speed and
> child nodes, and in fact it can easily be modified to do so (I've

Decoding speed in i2c driver seems to be fine. But the i2c child nodes are
board specific. We might bring board specific handling code into i2c driver
with this approach.

BTW, I have observed that, if we create i2c device node in omapx-soc.dtsi
file and the define i2c bus clock-frequency in beagle.dts, the clock-frequency
is not available in driver probe. Is this expected behavior?

-M
