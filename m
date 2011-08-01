From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 1 Aug 2011 10:50:47 +0800
Subject: [PATCH v2 4/7] tty: serial: support device tree in pxa
In-Reply-To: <20110729164922.GA30298@n2100.arm.linux.org.uk>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-4-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
	<20110729164539.GM11164@ponder.secretlab.ca>
	<20110729164922.GA30298@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZwYjQp5c=4f=CbqjrXFxzSURSv6i9QHMyjyPszs=kzh9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2011 at 12:49 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 29, 2011 at 10:45:39AM -0600, Grant Likely wrote:
>> On Thu, Jul 28, 2011 at 02:41:30PM +0800, Haojian Zhuang wrote:
>> > +#ifdef CONFIG_OF
>> > + ? for (i = 0; i < PXA_SERIAL_NR; i++) {
>> > + ? ? ? ? ? if (serial_pxa_ports[i] == NULL)
>> > + ? ? ? ? ? ? ? ? ? break;
>> > + ? }
>> > + ? if (i >= PXA_SERIAL_NR) {
>> > + ? ? ? ? ? pr_warn("can't find pxa serial port\n");
>> > + ? ? ? ? ? return -ENODEV;
>> > + ? }
>> > +
>> > + ? if (of_property_read_u32(np, "clock-frequency", &clk)) {
>> > + ? ? ? ? ? pr_warn("no clock-frequency property set\n");
>> > + ? ? ? ? ? return -ENODEV;
>> > + ? }
>> > + ? if (of_property_read_u32(np, "current-speed", &spd) == 0)
>> > + ? ? ? ? ? sport->port.custom_divisor = clk / (16 * spd);
>> > +
>> > + ? sprintf(name, "pxa2xx-uart.%d", i);
>> > + ? sport->clk = clk_get_sys(name, NULL);
>> > + ? if (IS_ERR(sport->clk)) {
>> > + ? ? ? ? ? ret = PTR_ERR(sport->clk);
>> > + ? ? ? ? ? goto err_free;
>> > + ? }
>> > + ? sport->port.uartclk = clk;
>> > +#else
>> > + ? i = dev->id;
>> > ? ? sport->clk = clk_get(&dev->dev, NULL);
>> > ? ? if (IS_ERR(sport->clk)) {
>> > ? ? ? ? ? ? ret = PTR_ERR(sport->clk);
>> > ? ? ? ? ? ? goto err_free;
>> > ? ? }
>> > + ? sport->port.uartclk = clk_get_rate(sport->clk);
>> > +#endif
>>
>> This means a kernel build can either support DT or non-DT, but not
>> both. ?DT & non-DT booting are full supported with the same kernel
>> image, so don't do it this way.
>>
>> Instead, check for the presence of an of_node. ?If it is there, do the
>> DT parsing. ?If now, still support the old method.
>
> Oh ffs, why is this DT stuff causing all the clk stuff to have to change.
> And specifically why is stuff converting to use clk_get_sys().
>
> clk_get_sys() is there to allow system devices to get their clocks.
> It's not for general drivers to use.
>
> Please, stop this madness.
>

So how could I get these clocks?

Thanks
Haojian
