From: stefan@agner.ch (Stefan Agner)
Date: Fri, 27 Mar 2015 12:56:43 +0100
Subject: [PATCH] pinctrl: fsl: imx: Check for 0 config register
In-Reply-To: <20150327104134.GW32677@pengutronix.de>
References: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
 <139dc298c0914b3536445dddd37be286@agner.ch>
 <20150327104134.GW32677@pengutronix.de>
Message-ID: <499f4d7a167f8f41a319dd939869abba@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-27 11:41, Uwe Kleine-K?nig wrote:
> On Fri, Mar 27, 2015 at 11:32:31AM +0100, Stefan Agner wrote:
>> On 2015-03-24 16:26, Markus Pargmann wrote:
>> > 0 is used in all pinfunction definitions when a config register is not
>> > available, for example imx25-pinfunc.h. If a configuration value is used
>> > for such a pinfunction the driver will always write it to the
>> > configuration register if it is not -1. For a 0 configuration register
>> > the configuration value is written to offset 0x0. This can lead to a
>> > crashing/hanging system without any warning message.
>>
>> 0 is a valid offset for Vybrid's mux register, however, since Vybrid set
>> the SHARE_MUX_CONF_REG, intepreting a 0 in conf_reg as "not set"
>> actually works.
>>
>> What is a bit a bummer is that we now have different meanings of 0,
>> depending on the field:
>> - For the first field (mux), 0 is a valid offset
>> - For the second field (config), 0 means not valid
>>
>> However, I can't think of a easy solution which would solve this in a
>> cleaner mannor... Maybe a comment in the function header how the 5 u32's
>> are intepreted would appropriate?
> That means that on Vybrid you need to write to offset 0 a config value?
> Or not?

Vybrid has a shared conf/mux_reg, hence the SHARE_MUX_CONF_REG is set.
Vybrid need to write to offset 0, and is using the conf_reg as offset
value in imx_pinconf_set:
...
	for (i = 0; i < num_configs; i++) {
		if (info->flags & SHARE_MUX_CONF_REG) {
			u32 reg;
			reg = readl(ipctl->base + pin_reg->conf_reg);
			reg &= ~0xffff;
			reg |= configs[i];
			writel(reg, ipctl->base + pin_reg->conf_reg);
		} else {


However, that conf_reg value is derived from mux_reg. This is what is
done at that if in that patch. Original code:
		if (info->flags & SHARE_MUX_CONF_REG)
			conf_reg = mux_reg;
		else
			conf_reg = be32_to_cpu(*list++);


So, due to that, this patch does not affect the value computed for
conf_reg on Vybrid devices (a value of 0 is still possible for Vybrid).
Hence, everything should work fine... The different interpretation of
the value "0" for the regs is somewhat confusing, but probably
unavoidable without DT changes....

--
Stefan
