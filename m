From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 1 Jun 2015 19:51:54 +0200
Subject: [PATCH v2 3/5] i2c: at91: add support for new alternative
 command mode
In-Reply-To: <82c39f262f553a43ea9208b4f9804bbf26a62d90.1433173031.git.cyrille.pitchen@atmel.com>
References: <cover.1433173031.git.cyrille.pitchen@atmel.com>
 <82c39f262f553a43ea9208b4f9804bbf26a62d90.1433173031.git.cyrille.pitchen@atmel.com>
Message-ID: <20150601175154.GN4710@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/06/2015 at 17:49:13 +0200, Cyrille Pitchen wrote :
> @@ -504,8 +589,22 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
>  		at91_twi_write(dev, AT91_TWI_IADR, internal_address);
>  	}
>  
> -	at91_twi_write(dev, AT91_TWI_MMR, (m_start->addr << 16) | int_addr_flag
> -		       | ((m_start->flags & I2C_M_RD) ? AT91_TWI_MREAD : 0));
> +	is_read = (m_start->flags & I2C_M_RD);
> +	if (dev->pdata->has_alt_cmd) {
> +		if (m_start->len > 0) {
> +			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_ACMEN);
> +			at91_twi_write(dev, AT91_TWI_ACR,
> +				       AT91_TWI_ACR_DATAL(m_start->len) |
> +				       ((is_read) ? AT91_TWI_ACR_DIR : 0));
> +			use_alt_cmd = true;
> +		} else
> +			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_ACMDIS);

braces {} should be used on all arms of this statement



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
