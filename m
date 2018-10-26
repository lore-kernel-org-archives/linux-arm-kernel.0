From: stefan@agner.ch (Stefan Agner)
Date: Fri, 26 Oct 2018 10:15:30 +0200
Subject: [PATCH V2 4/8] gpio: vf610: add optional clock support
In-Reply-To: <AM0PR04MB42115EAC49CC0F67BE45CCB380F00@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-5-git-send-email-aisheng.dong@nxp.com>
 <c023948f3baee96cb186f970fdb71ebd@agner.ch>
 <AM0PR04MB42115EAC49CC0F67BE45CCB380F00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <24253e7336192f7afeefe385953d04b3@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.10.2018 05:49, A.s. Dong wrote:
>> -----Original Message-----
>> From: Stefan Agner [mailto:stefan at agner.ch]
>> Sent: Friday, October 26, 2018 1:59 AM
> [...]
>>
>> On 23.10.2018 13:49, A.s. Dong wrote:
>> > Some SoCs need the gpio clock to be enabled before accessing HW
>> > registers. This patch add the optional clock handling.
>> >
>> > Cc: Linus Walleij <linus.walleij@linaro.org>
>> > Cc: Stefan Agner <stefan@agner.ch>
>> > Cc: Shawn Guo <shawnguo@kernel.org>
>> > Cc: linux-gpio at vger.kernel.org
>> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> > ---
>> > v1->v2:
>> >  * new patch
>> > ---
>> >  drivers/gpio/gpio-vf610.c | 20 ++++++++++++++++++++
>> >  1 file changed, 20 insertions(+)
>> >
>> > diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
>> > index d4ad6d0..cbc4f44 100644
>> > --- a/drivers/gpio/gpio-vf610.c
>> > +++ b/drivers/gpio/gpio-vf610.c
>> > @@ -16,6 +16,7 @@
>> >   */
>> >
>> >  #include <linux/bitops.h>
>> > +#include <linux/clk.h>
>> >  #include <linux/err.h>
>> >  #include <linux/gpio.h>
>> >  #include <linux/init.h>
>> > @@ -256,6 +257,7 @@ static int vf610_gpio_probe(struct platform_device
>> > *pdev)  {
>> >  	struct device *dev = &pdev->dev;
>> >  	struct device_node *np = dev->of_node;
>> > +	struct clk *clk_gpio, *clk_port;
>> >  	struct vf610_gpio_port *port;
>> >  	struct resource *iores;
>> >  	struct gpio_chip *gc;
>> > @@ -280,6 +282,24 @@ static int vf610_gpio_probe(struct platform_device
>> *pdev)
>> >  	if (port->irq < 0)
>> >  		return port->irq;
>> >
>> > +	clk_gpio = devm_clk_get(&pdev->dev, "gpio");
>> > +	clk_port = devm_clk_get(&pdev->dev, "port");
>>
>> Are you sure that those are two independent clocks? On i.MX 7 usually there
>> was a single clock gate controlling multiple clocks at once (which should be
>> modeled as a single clock gate in the clock tree).
>>
> 
> Yes, they're two separate clocks in HW for gpio and port controller
> respectively.
> One is for GPIO general purpose input/output function which another
> for port Interrupt.
> Just like we have separate register ranges for gpio and port.

Oh I see, that is the same with Vybrid actually. However, in Vybrid, for
some reason, there is only a clock for port (Port X multiplexing
control).

Can we make port clock independently optional?

E.g.

	clk_port = devm_clk_get(&pdev->dev, "port");
	if (clk_gpio == ERR_PTR(-EPROBE_DEFER))
		return -EPROBE_DEFER;

	clk_gpio = devm_clk_get(&pdev->dev, "gpio");
	if (clk_gpio == ERR_PTR(-EPROBE_DEFER))
		return -EPROBE_DEFER;

	if (!IS_ERR_OR_NULL(clk_port)) {
		ret = clk_prepare_enable(clk_port);
		if (ret)
			return ret;
	}

	if (!IS_ERR_OR_NULL(clk_gpio))
		ret = clk_prepare_enable(clk_gpio);
		if (ret) {
			clk_disable_unprepare(clk_port);
			return ret;
		}
	}

Also there is some error handling a bit further down which needs proper
disabling the clocks.

--
Stefan


> 
> Regards
> Dong Aisheng
> 
>> --
>> Stefan
>>
>> > +	if ((PTR_ERR(clk_gpio) == -EPROBE_DEFER) ||
>> > +	    (PTR_ERR(clk_port) == -EPROBE_DEFER)) {
>> > +		return -EPROBE_DEFER;
>> > +	} else if (!IS_ERR_OR_NULL(clk_gpio) &&
>> > +		   !IS_ERR_OR_NULL(clk_port)) {
>> > +		ret = clk_prepare_enable(clk_gpio);
>> > +		if (ret)
>> > +			return ret;
>> > +
>> > +		ret = clk_prepare_enable(clk_port);
>> > +		if (ret) {
>> > +			clk_disable_unprepare(clk_gpio);
>> > +			return ret;
>> > +		}
>> > +	}
>> > +
>> >  	gc = &port->gc;
>> >  	gc->of_node = np;
>> >  	gc->parent = dev;
