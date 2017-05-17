From: stefan@agner.ch (Stefan Agner)
Date: Wed, 17 May 2017 11:16:13 -0700
Subject: [PATCH 2/2] pinctrl: pinctrl-imx: do not assume mux 0 is gpio
In-Reply-To: <AM3PR04MB3061FB0760F94F2F816055A80E70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1494830906-6442-1-git-send-email-aisheng.dong@nxp.com>
 <1494830906-6442-3-git-send-email-aisheng.dong@nxp.com>
 <6d47abc0527ae6f2214a9b37dfbeb154@agner.ch>
 <AM3PR04MB3061FB0760F94F2F816055A80E70@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <e056a1185a4094e558fb20c7eb19da3d@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-17 00:18, A.S. Dong wrote:
>> -----Original Message-----
>> From: Stefan Agner [mailto:stefan at agner.ch]
>> Sent: Tuesday, May 16, 2017 1:27 AM
>> To: A.S. Dong
>> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy Duan;
>> kernel at pengutronix.de; Alexandre Courbot
>> Subject: Re: [PATCH 2/2] pinctrl: pinctrl-imx: do not assume mux 0 is gpio
>>
>> On 2017-05-14 23:48, Dong Aisheng wrote:
>> > Do not assume MUX 0 is GPIO function in core driver as a different SoC
>> > may have different value. e.g. MX7ULP Mux 1 is GPIO.
>> >
>> > Cc: Linus Walleij <linus.walleij@linaro.org>
>> > Cc: Alexandre Courbot <gnurou@gmail.com>
>> > Cc: Shawn Guo <shawnguo@kernel.org>
>> > Cc: Stefan Agner <stefan@agner.ch>
>> > Cc: Fugang Duan <fugang.duan@nxp.com>
>> > Cc: Bai Ping <ping.bai@nxp.com>
>> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> > ---
>> >  drivers/pinctrl/freescale/pinctrl-imx.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
>> > b/drivers/pinctrl/freescale/pinctrl-imx.c
>> > index 0d6aaca..ed8ea32 100644
>> > --- a/drivers/pinctrl/freescale/pinctrl-imx.c
>> > +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
>> > @@ -281,7 +281,7 @@ static int imx_pmx_gpio_request_enable(struct
>> > pinctrl_dev *pctldev,
>> >  			continue;
>> >  		for (pin = 0; pin < grp->num_pins; pin++) {
>> >  			imx_pin = &((struct imx_pin *)(grp->data))[pin];
>> > -			if (imx_pin->pin == offset && !imx_pin->mux_mode)
>> > +			if (imx_pin->pin == offset)
>> >  				goto mux_pin;
>>
>> The reason I added that check was to make sure we pick a mux option which
>> is GPIO... With this change, any pinmux might be picked...
>>
> 
> First of all, this seems to be wrong to me that GPIO mux mode is SoC
> Dependant and should not be put in pinctrl-imx core driver.

Hm, agree, we should consider to move
imx_pmx_gpio_request_enable/disable_free and imx_pmx_gpio_set_direction
into pinctrl-vf610.c

> 
> Secondly, I think we may be over worried and it's not quite necessary
> As we did not do the sanity check for both raw config and mux data read
> From Device tree, why only do it for GPIO?
> 
> We may trust the data in device tree.

In Vybrid, there is no need to explicitly assign a pinmux to use a pin
as GPIO. So the pinmux could be anything... The implemented semantics
for Vyrbid is really different than i.MX, see below.

> 
>> >  		}
>> >  	}
>> > @@ -292,6 +292,7 @@ static int imx_pmx_gpio_request_enable(struct
>> > pinctrl_dev *pctldev,
>> >  	reg = readl(ipctl->base + pin_reg->mux_reg);
>> >  	reg &= ~info->mux_mask;
>> >  	reg |= imx_pin->config;
>> > +	reg |= imx_pin->mux_mode << info->mux_shift;
>>
>> ... and muxed...
>>
>> Not sure if we want that.
>>
>> I had to control GPIO output/input through pinctrl since Vybrid does not
>> allow to control that from the GPIO block.
>>
>> However, according to your GPIO patchset, the i.MX 7ULP has a new register
>> GPIO_PDDR to control output from the GPIO block. Is controlling the output
>> driver from IOMUXC still required?
> 
> Yes, it's still required.
> 

That sounds weird, what is the GPIO_PDDR for then? Sure I  need to
enable the output driver to drive the pin, but can I disable output just
using GPIO_PDDR?

Maybe we have a miss understanding here:

Lets assume we want to switch a GPIO between output and input:

echo "output" > /sys/class/gpio/gpioN/direction
..
echo "input" > /sys/class/gpio/gpioN/direction

Do I need to disable the output driver in the IOMUXC or can we just
disable GPIO_PDDR and use the pin as input?

If we can disable the output driver just using GPIO_PDDR, we can avoid
the gpio_set_direction cross call.


>> If not, I really would just not use all
>> that "find pinctrl config" hackery... e.g. add a new flag,
>> USE_IOMUXC_FOR_GPIO_OUTPUT, and set that only for Vybrid.
>>
>> This would also align much better with the other i.MX devices, where
>> pinmuxing and GPIO is completely orthogonal.
>>
> 
> Actually this patch came only because to make the exist code
> not break MX7ULP.
> 
> Actually I'm wondering why we need implement 
> imx_pmx_gpio_request_enable function?
> 
> Per my understanding, IMX binding already set GPIO mux by
> Parsing MUX mode from device tree, so why need gpio_request_enable
> which looks like is duplicated.
> 
> Can you help explain it?

I suggest to read this clarification email wrt to pinctrl/gpio from
Linus Walleij:
https://lkml.org/lkml/2016/10/10/87

To summarize: We have different semantics in Vybrid: The GPIO subsystem
automatically mux the GPIO for you. So in Vybrid, you do not have to mux
a GPIO (but a valid entry in your device tree is needed, but does not
assigned to any node).

Is what the driver is doing for Vybrid wrong? It is different from i.MX,
but afaik, it is not really wrong... Its a valid implementation
according to the currently defined semantics...  Due to the *need* to
touch pinctrl for direction, I had to implement cross calls anyway, so I
thought I might as well go full mile and also mux the GPIO on request...

So the question is, what semantic do we want for i.MX 7ULP? Since it is
a i.MX device, we probably want the same semantics as i.MX 6/7 is
already using for the sake of consistency. So in this case the
gpio_request_enable/disable callbacks are not needed...

This is how I hope we can do the implementation for i.MX 7ULP:
- Do not use gpio_request_enable/disable
- Do not use gpio_set_direction either
- Users using a GPIO should enable output driver in IOMUXC (just use a
pin configuration where output driver is enabled)
- The GPIO driver only enables/disables the output driver using its
GPIO_PDDR register depending on GPIO direction

--
Stefan
