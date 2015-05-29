From: eric@anholt.net (Eric Anholt)
Date: Fri, 29 May 2015 14:02:49 -0700
Subject: [PATCH 2/7] ARM: bcm2835: Add a Raspberry Pi-specific clock
 driver.
In-Reply-To: <55679085.6040402@wwwdotorg.org>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-3-git-send-email-eric@anholt.net>
 <55679085.6040402@wwwdotorg.org>
Message-ID: <87h9qvcd1i.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 05/18/2015 01:43 PM, Eric Anholt wrote:
>>  obj-$(CONFIG_ARCH_BCM2835)		+= clk-bcm2835.o
>> +obj-$(CONFIG_ARCH_BCM2835)		+= clk-raspberrypi.o
>
> Shouldn't this replace the old legacy code in clk-bcm2835.c?

I don't think we can, because of DT backwards compat (Sigh).
>
> I wonder if a separate Kconfig symbol is warranted for the clock driver.
> Looking at the context in the patch, it's common not to do that though.

I've moved it under RASPBERRYPI_FIRMWARE, since it needs that to build.

>> diff --git a/drivers/clk/clk-raspberrypi.c b/drivers/clk/clk-raspberrypi.c
>
>> +struct rpi_firmware_clock {
>> +	/* Clock definitions in our static struct. */
>> +	int clock_id;
>
> Why not just use the raw HW IDs (from the mailbox protocol) as the ID in
> DT and the driver? The only thing that would need to change is to add a
> error check for "clkspec->args[0] == 0" in
> rpi_firmware_delayed_get_clk(). The advantage would be that
> include/dt-bindings/clk/raspberrypi.h would exactly match the firmware
> protocol, and hence be easily correlated with the documentation.

Done.

>> +static int rpi_clk_set_rate(struct clk_hw *hw,
>> +			    unsigned long rate, unsigned long parent_rate)
>> +{
>> +	struct rpi_firmware_clock *rpi_clk =
>> +		container_of(hw, struct rpi_firmware_clock, hw);
>> +	u32 packet[2];
>> +	int ret;
>> +
>> +	packet[0] = rpi_clk->clock_id;
>> +	packet[1] = rate;
>> +	ret = rpi_firmware_property(rpi_clk->firmware_node,
>
> The docs indicate there's a third word here "skip setting turbo". Is
> that optional?
>
> https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface

Yeah, it's optional based on the buffer size specified in the packet.

>> +static long rpi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>> +			       unsigned long *parent_rate)
>> +{
>> +	/*
>> +	 * The firmware will end up rounding our rate to something,
>> +	 * but we don't have an interface for it.  Just return the
>> +	 * requested value, and it'll get updated after the clock gets
>> +	 * set.
>> +	 */
>> +	return rate;
>> +}
>
> Hmm. I wonder if that will confuse things; I thought the purpose of
> round_rate() was so code could know exactly what would happen ahead of time?

Well, we don't have the ability.  Things seem to work, anyway.
Certainly better than just living with fixed clocks for everything like
we are today.

>> +static struct clk *rpi_firmware_delayed_get_clk(struct
>> of_phandle_args *clkspec, + void *_data)
>
>> +	rpi_clk = &rpi_clocks[clkspec->args[0]];
>> +
>> +	firmware_node = of_parse_phandle(of_node, "firmware", 0);
>> +	if (!firmware_node) {
>> +		dev_err(dev, "%s: Missing firmware node\n", rpi_clk->name);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	/* Try a no-op transaction to see if the driver is loaded yet. */
>> +	ret = rpi_firmware_property_list(firmware_node, NULL, 0);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>
> I would move all that into this driver's probe().

We can't move all this into the driver's probe, because this is where
we're returning -EPROBE_DEFER.  We could potentially do just the phandle
parse up front and allocate some memory to pass it and our own device
node to this function through the _data arg, but I don't see much point.

>> +CLK_OF_DECLARE(rpi_firmware_clocks, "raspberrypi,firmware-clocks",
>> +	       rpi_firmware_init_clock_provider);
>
> Oh, I guess the same comment as for the firmware node applies re: the
> over-genericity of the DT compatible value applies here too. Perhaps
> raspberrypi,bcm2835-firmware-clocks to match Lee's proposal for the
> firmware node?

Done.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/8e2e93a0/attachment.sig>
