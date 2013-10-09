From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Oct 2013 15:09:21 +0200
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
In-Reply-To: <20131009124425.GG25034@n2100.arm.linux.org.uk>
References: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
 <20131009124425.GG25034@n2100.arm.linux.org.uk>
Message-ID: <CACRpkda3J4cCTnFaQFrmZ=box6EeJ8WQZpuQpi2p_BFX+W2vuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 9, 2013 at 2:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Oct 09, 2013 at 02:40:49PM +0200, Linus Walleij wrote:

>> NAK this this a Linux kernel implementation detail. Sherman Yin
>> fixed this up so the drivers does not have to imply any sequence
>> semantic for this.
>>
>> Study commit 03b054e9696c3cbd3d5905ec96da15acd0a2fe8d
>> "pinctrl: Pass all configs to driver on pin_config_set()"
>>
>> It is perfectly legal for a driver to accumulate the settings into
>> e.g. a single register write if it can, e.g.:
>>
>> u32 val = 0;
>>
>> for (i = 0; i < num_configs; i++) {
>>   switch() {
>>   FOO:
>>      val |= 1;
>>      break;
>>    BAR:
>>      val |= 2:
>>      break;
>>    BAZ:
>>      val |=4;
>>      break;
>> };
>>
>> writel(val, base+pinreg);
>>
>> I.e. the driver may choose to apply configs sequentially, but that is
>> not at all necessary.
>
> So, just to be clear, what you're saying is that specifying two settings
> in a pinctrl declaration which provide different values results in
> undefined behaviour?

It's more like the pin control core is passing the array of settings
to the driver and the behaviour is specified per-driver.

So that is from the kernels point of view, no matter whether
device tree is used or not. A specific driver may instill specific
behaviour - sequential or not.

Sherman's driver for the Broadcom Capri had the requirement that
the configuration of all parameters be done with a single register
write to avoid side-effects. So it needs to iterate the configs and
build up a mask and value and write it in one go.

When I look at the i.MX driver (I guess this is what Shawn
is working on here) it can actually be augmented to do it
the same way and avoid this mess altogether:

       for (i = 0; i < num_configs; i++) {
                if (info->flags & SHARE_MUX_CONF_REG) {
                        u32 reg;
                        reg = readl(ipctl->base + pin_reg->conf_reg);
                        reg &= ~0xffff;
                        reg |= configs[i];
                        writel(reg, ipctl->base + pin_reg->conf_reg);
                } else {
                        writel(configs[i], ipctl->base + pin_reg->conf_reg);
                }
                dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%lx\n",
                        pin_reg->conf_reg, configs[i]);
        } /* for each config */

As can be seen it will just writel() the config into the register
for each config, it seems more like there is a bug that also
the else-clause here should be read-modify-write, or am
I getting it all wrong?

In some cases some configs may be electrically conflicting
and completely unsound, like enabling pull-up and pull-down
at the same time - maybe possible in the hardware
but insane, so the driver should detect that state in this
loop and reject such configs, print a warning or make a
best effort.

I am aware that maybe not all drivers are handling this in
the most ultimate way today :-/

Then as this patch was against the device tree documentation:
since the device tree isn't really about sequencing things
(Grant has been onto us in the past for wanting to put sequences
in there) we should probably avoid defining such things as
sequences at all, as that basically moves the hardware
description toward a sequence description language (jam table),
and for that the full open firmware or other BIOS thing (ACPI?)
should be used instead. (If I understood the point correctly.)

I tend to think about the DT language as functional i.e. there
is no way to say anything about sequencing order from it,
I may be wrong here though.

Yours,
Linus Walleij
