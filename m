From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 23 Dec 2010 11:59:38 +1300
Subject: [PATCH 1/6 v11] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20101222222501.GA32693@alchark-u3s>
References: <AANLkTin4XqbGwznp56Xjt_zest6rxNmir0QDJWTySY4+@mail.gmail.com>
	<4D0FD747.9020700@bluewatersys.com>
	<AANLkTikAWjK7ACyt=LedhyyrhsCk1WCiyWz182CXMe9C@mail.gmail.com>
	<4D0FE546.7050302@bluewatersys.com>
	<AANLkTinyYKrhTcBMMCE4A2oFQHm11cqSZQozytGu+d6o@mail.gmail.com>
	<4D1011CF.9080800@bluewatersys.com>
	<AANLkTi=7O-HwQRcybnLSt+r+A64g=D7rZY7NbdEMFys3@mail.gmail.com>
	<4D110269.9030805@bluewatersys.com>
	<20101222211815.GA31054@alchark-u3s>
	<4D12730B.2030909@bluewatersys.com>
	<20101222222501.GA32693@alchark-u3s>
Message-ID: <4D1282DA.4020804@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2010 11:25 AM, Alexey Charkov wrote:
> This adds support for the family of Systems-on-Chip produced initially
> by VIA and now its subsidiary WonderMedia that have recently become
> widespread in lower-end Chinese ARM-based tablets and netbooks.
> 
> Support is included for both VT8500 and WM8505, selectable by a
> configuration switch at kernel build time.
> 
> Included are basic machine initialization files, register and
> interrupt definitions, support for the on-chip interrupt controller,
> high-precision OS timer, GPIO lines, necessary macros for early debug,
> pulse-width-modulated outputs control, as well as platform device
> configurations for the specific drivers implemented elsewhere.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> 
> This incorporates latest comments by Ryan regarding helper inlines
> in devices-{vt8500,wm8505}.c
> 
> Best regards,
> Alexey

One final nitpick :-).

> +static int vt8500_muxed_gpio_direction_input(struct gpio_chip *chip,
> +				       unsigned offset)
> +{
> +	struct vt8500_gpio_chip *vt8500_chip = to_vt8500(chip);
> +	unsigned val = readl(regbase + 0x20 + vt8500_chip->regoff);
> +
> +	val &= ~(1 << vt8500_chip->shift << offset);
> +	writel(val, regbase + 0x20 + vt8500_chip->regoff);

The magic numbers (0x20) in the gpio functions should probably be
#defined as register names. I'm guessing this is the input enable
register? Often people do helper functions for this, i.e:

static inline void gpio_write_reg(struct vt8500_gpio_chip *chip,
				  unsigned val, unsigned reg)
{
	writel(val, regbase + chip->regoff + reg);
}

Other than that, looks good.

Reviewed-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
