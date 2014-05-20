From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Tue, 20 May 2014 10:23:30 +0000
Subject: [PATCH] ARM: imx6: init enet MAC address
In-Reply-To: <20140520095705.GJ5858@pengutronix.de>
References: <1400566266-22746-1-git-send-email-b38611@freescale.com>
 <20140520090312.GH5858@pengutronix.de>
 <9e30b11d922542fb851c09c46685599d@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140520095705.GJ5858@pengutronix.de>
Message-ID: <f87d9afcbd79499883c9f33b620bd66e@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>
Data: Tuesday, May 20, 2014 5:57 PM

>To: Duan Fugang-B38611
>Cc: Li Frank-B20596; Guo Shawn-R65073; linux-arm-
>kernel at lists.infradead.org; kernel at pengutronix.de
>Subject: Re: [PATCH] ARM: imx6: init enet MAC address
>
>On Tue, May 20, 2014 at 09:24:01AM +0000, fugang.duan at freescale.com wrote:
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>> Data: Tuesday, May 20, 2014 5:03 PM
>>
>> >To: Duan Fugang-B38611
>> >Cc: Li Frank-B20596; Guo Shawn-R65073; linux-arm-
>> >kernel at lists.infradead.org; kernel at pengutronix.de
>> >Subject: Re: [PATCH] ARM: imx6: init enet MAC address
>> >
>> >On Tue, May 20, 2014 at 02:11:06PM +0800, Fugang Duan wrote:
>> >> Enet get MAC address order:
>> >> From module parameters or kernel command line -> device tree ->
>> >> pfuse
>> >> -> mac registers set by bootloader -> random mac address.
>> >>
>> >> When there have no "fec.macaddr" parameters set in kernel command
>> >> line, enet driver get MAC address from device tree. And then if the
>> >> MAC address set in device tree and is valid, enet driver get MAC
>> >> address from device tree. Otherwise, enet get MAC address from pfuse.
>> >> So, in the condition, update the MAC address (read from pfuse) to
>> >> device tree.
>> >>
>> >> +#define OCOTP_MACn(n)		(0x00000620 + (n) * 0x10)
>> >> +#define IMX_MAX_ENET_NUM	2
>> >> +void __init imx6_enet_mac_init(const char *compatible)
>> >
>> >static
>> >
>> The .fun() will be called for imx6sl, imx6sx(the latest chip) machine
>files.
>>
>> >> +{
>> >> +	struct device_node *ocotp_np, *enet_np, *from = NULL;
>> >> +	void __iomem *base;
>> >> +	struct property *newmac;
>> >> +	u32 macaddr0_low;
>> >> +	u32 macaddr0_high = 0;
>> >> +	u32 macaddr1_high = 0;
>> >> +	u8 *macaddr;
>> >> +	int i;
>> >> +
>> >> +	for (i = 0; i < IMX_MAX_ENET_NUM; i++) {
>> >> +		enet_np = of_find_compatible_node(from, NULL,
>compatible);
>> >> +		if (!enet_np)
>> >> +			return;
>> >> +
>> >> +		from = enet_np;
>> >> +
>> >> +		if (of_get_mac_address(enet_np))
>> >> +			goto put_enet_node;
>> >> +
>> >> +		ocotp_np = of_find_compatible_node(NULL, NULL,
>"fsl,imx6q-
>> >ocotp");
>> >> +		if (!ocotp_np) {
>> >> +			pr_warn("failed to find ocotp node\n");
>> >> +			goto put_enet_node;
>> >> +		}
>> >> +
>> >> +		base = of_iomap(ocotp_np, 0);
>> >> +		if (!base) {
>> >> +			pr_warn("failed to map ocotp\n");
>> >> +			goto put_ocotp_node;
>> >> +		}
>> >
>> >Move this outside the loop.
>> >
>> Agree, I will move the ocotp node from the loop.
>>
>> >> +
>> >> +		macaddr0_low = readl_relaxed(base + OCOTP_MACn(1));
>> >> +		if (i)
>> >> +			macaddr1_high = readl_relaxed(base +
>OCOTP_MACn(2));
>> >> +		else
>> >> +			macaddr0_high = readl_relaxed(base +
>OCOTP_MACn(0));
>> >
>> >You go over these register reads two times and read the very same
>> >registers two times. Argh! Could please look at your code before
>> >posting it?
>> >
>> For some other platform like imx6sx has two enet MACs, so "i" is 0, 1.
>> You means OCOTP_MACn(1) is read twice, I will change it. Thanks.
>
>What you do is:
>
>	for (i = 0; i < IMX_MAX_ENET_NUM; i++) {
>		...
>		macaddr0_low = readl_relaxed(base + OCOTP_MACn(1));
>		if (i)
>			macaddr1_high = readl_relaxed(base + OCOTP_MACn(2));
>		else
>			macaddr0_high = readl_relaxed(base + OCOTP_MACn(0));
>		...
>	}
>
>What you should do is:
>
>	macaddr0_low = readl_relaxed(base + OCOTP_MACn(1));
>	macaddr1_high = readl_relaxed(base + OCOTP_MACn(2));
>	macaddr0_high = readl_relaxed(base + OCOTP_MACn(0));
>
>	for (i = 0; i < IMX_MAX_ENET_NUM; i++) {
>		...
>	}
>>
>> >> +
>> >> +		newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
>> >> +		if (!newmac)
>> >> +			goto put_ocotp_node;
>> >> +
>> >> +		newmac->value = newmac + 1;
>> >> +		newmac->length = 6;
>> >> +		newmac->name = kstrdup("local-mac-address", GFP_KERNEL);
>> >> +		if (!newmac->name) {
>> >> +			kfree(newmac);
>> >> +			goto put_ocotp_node;
>> >> +		}
>> >> +
>> >> +		macaddr = newmac->value;
>> >> +		if (i) {
>> >> +			macaddr[0] = (macaddr1_high >> 24) & 0xff;
>> >> +			macaddr[1] = (macaddr1_high >> 16) & 0xff;
>> >> +			macaddr[2] = (macaddr1_high >> 8) & 0xff;
>> >> +			macaddr[3] = macaddr1_high & 0xff;
>> >> +			macaddr[4] = (macaddr0_low >> 24) & 0xff;
>> >> +			macaddr[5] = (macaddr0_low >> 16) & 0xff;
>> >> +		} else {
>> >> +			macaddr[0] = (macaddr0_low >> 8) & 0xff;
>> >> +			macaddr[1] = macaddr0_low & 0xff;
>> >> +			macaddr[2] = (macaddr0_high >> 24) & 0xff;
>> >> +			macaddr[3] = (macaddr0_high >> 16) & 0xff;
>> >> +			macaddr[4] = (macaddr0_high >> 8) & 0xff;
>> >> +			macaddr[5] = macaddr0_high & 0xff;
>> >> +		}
>> >
>> >It makes no sense to have a IMX_MAX_ENET_NUM define when the code
>> >assumes that the only valid value is 2.
>> >
>> You mean remove the "IMX_MAX_ENET_NUM" ?
>>
>> >All this is probably far more readable and less fishy when you move
>> >the fixup of a single enet device to a extra function which you call
>> >from the loop.
>> >
>> Because imx6sx has two enet MACs, and the function is called for
>imx6qdl/imx6sl/imx6sx, so add the loop in here.
>> For imx6qdl/imx6sl, there just have one MAC, the second loop don't go
>through the flow.
>> Do you have other suggestion ?
>
>What I want to say is: When you have a loop and the loop body gets to
>complicated, then it often improves readability to move the loop body to
>an extra function, like this:
>
>static int imx6_enet_mac_init_one(struct device_node *enet, const u8 *mac)
>{
>	struct property *newmac;
>	u8 mac[6];
>
>	if (of_get_mac_address(enet))
>		return 0;
>
>	newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
>	if (!newmac)
>		return -ENOMEM;
>
>	newmac->length = 6;
>	newmac->name = kstrdup("local-mac-address", GFP_KERNEL);
>	newmac->value = kmemdup(mac, 6, GFP_KERNEL);
>
>	of_update_property(enet_np, newmac);
>
>	release_stuff();
>}
>
>int imx6_enet_mac_init(const char *compatible) {
>	struct device_node *from = NULL;
>	u8 mac[6];
>
>	macaddr0_low = readl_relaxed(base + OCOTP_MACn(1));
>	macaddr1_high = readl_relaxed(base + OCOTP_MACn(2));
>	macaddr0_high = readl_relaxed(base + OCOTP_MACn(0));
>
>	mac[0] = ...;
>
>	enet_np = of_find_compatible_node(NULL, NULL, compatible);
>	if (!enet_np)
>		return 0;
>
>	imx6_enet_mac_init_one(enet_np, mac);
>
>	enet_np = of_find_compatible_node(enet_np, NULL, compatible);
>	if (!enet_np)
>		return 0;
>
>	mac[0] = ...;
>
>	imx6_enet_mac_init_one(enet_no, mac);
>}
>
>(here I removed the loop which makes the code even more straight
>forward)
>
>Sascha
>
Sascha, thanks for your suggestion !  It is more readable. I will send out the patch V2.
