From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Dec 2012 16:35:02 +0000
Subject: [PATCH RESEND 5/6 v10] gpio: Add device tree support to block
 GPIO API
In-Reply-To: <50D07DFF.2040102@antcom.de>
References: <1355495185-24220-1-git-send-email-stigge@antcom.de>
 <1355495185-24220-6-git-send-email-stigge@antcom.de>
 <20121217155153.GD16561@e106331-lin.cambridge.arm.com>
 <50D07DFF.2040102@antcom.de>
Message-ID: <20121218163502.GB32484@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 02:30:23PM +0000, Roland Stigge wrote:
> Hi Mark,
> 
> On 12/17/2012 04:51 PM, Mark Rutland wrote:
> >> +static int __devinit gpioblock_of_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device_node *block;
> >> +	unsigned *gpios;
> >> +	int ngpio;
> >> +	int ret;
> >> +	struct gpio_block *gb;
> >> +
> >> +	for_each_available_child_of_node(pdev->dev.of_node, block) {
> >> +		int i;
> >> +
> >> +		ngpio = of_gpio_count(block);
> >> +		gpios = kzalloc(ngpio * sizeof(*gpios), GFP_KERNEL);
> > 
> > What if the block node is malformed? ngpio might be -ENOENT or -EINVAL.
> 
> AFAICS, of_gpio_count() always returns at least 0. Both if
> CONFIG_OF_GPIO is y, m or n. And called of_gpio_named_count() also
> currently doesn't return error values. Further, other drivers using
> of_gpio_count() don't expect or catch <0.

Whoops. I'd managed to misread the logic in of_gpio_named_count, sorry.

> However, it's reasonable to guard against of_gpio_count() < 1 since
> probing without provided blocks should be void.
> 
> Will change this for the next patch update together with your leakage
> findings.
> 
> Thanks for reporting!
> 
> Roland

Sounds good!

Thanks,
Mark.
