From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jul 2010 12:57:48 +0100
Subject: [PATCH 3/5] U6715 gpio platform driver This driver is U6XXX
	platform generic
In-Reply-To: <1278316742-11219-4-git-send-email-philippe.langlais@stericsson.com>
References: <1278316742-11219-1-git-send-email-philippe.langlais@stericsson.com>
	<1278316742-11219-4-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100709115748.GD22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 05, 2010 at 09:59:00AM +0200, Philippe Langlais wrote:
> +static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
> +{
> +	u32 reg = bank->gpio_base;

Virtual addresses are pointers not integers and should be of type
void __iomem *.  It's unfortunate that writel() and friends don't
warn about this - but making them do so ends up generating more
code with some GCC versions.

As I've already suggested, you can get around adding lots of casts
to void __iomem * to the code by defining an IOMEM macro, which you
can then use when you define things like GPIOA_PINS_REG.
