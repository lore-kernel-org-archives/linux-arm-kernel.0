From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 07 Jan 2013 15:26:01 +0100
Subject: [PATCH 1/3] gpio: pca953x: make the register access by GPIO bank
In-Reply-To: <1357493688-25061-2-git-send-email-gregory.clement@free-electrons.com>
References: <1357493688-25061-1-git-send-email-gregory.clement@free-electrons.com>
 <1357493688-25061-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <50EADAF9.2030805@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Le 06/01/2013 18:34, Gregory CLEMENT a ?crit :
> +static int pca953x_write_regs(struct pca953x_chip *chip, int reg, u8 *val)
>  {
>  	int ret = 0;
>  
>  	if (chip->gpio_chip.ngpio <= 8)
> -		ret = i2c_smbus_write_byte_data(chip->client, reg, val);
> -	else if (chip->gpio_chip.ngpio == 24) {
> -		cpu_to_le32s(&val);
> +		ret = i2c_smbus_write_byte_data(chip->client, reg, *val);
> +	else if (chip->gpio_chip.ngpio >= 24) {
> +		int bank_shift = fls(chip->gpio_chip.ngpio) - 3;
>  		ret = i2c_smbus_write_i2c_block_data(chip->client,
> -						(reg << 2) | REG_ADDR_AI,
> -						3,
> -						(u8 *) &val);
> +					(reg << bank_shift) | REG_ADDR_AI,
> +					NBANK(chip),
> +					val);
>  	}
>  	else {
>  		switch (chip->chip_type) {
>  		case PCA953X_TYPE:
>  			ret = i2c_smbus_write_word_data(chip->client,
> -							reg << 1, val);
> +							reg << 1, (u16) *val);
>  			break;
>  		case PCA957X_TYPE:
>  			ret = i2c_smbus_write_byte_data(chip->client, reg << 1,
> -							val & 0xff);
> +							val[0]);
>  			if (ret < 0)
>  				break;
>  			ret = i2c_smbus_write_byte_data(chip->client,
>  							(reg << 1) + 1,
> -							(val & 0xff00) >> 8);
> +							val[1]);
>  			break;
>  		}
>  	}

I just tested your patch on a PCA9555 on the Crystalfontz CFA-10049, and
it doesn't work anywore. It returns ENXIO now when you use this
function. As discussed on IRC, it seems that the fix would be to replace
all the calls to fls(chip->gpio_chip.ngpio) by fls(chip->gpio_chip.ngpio
- 1).

Also, all the irq handling is not compiling anymore for trivial errors
(variables not defined, incompatible types, etc.). So obviously, I
couldn't test the changes you made on the IRQ related functions.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
