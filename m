From: carsten.behling@garz-fricke.com (Carsten Behling)
Date: Wed, 23 Nov 2011 10:31:44 +0100
Subject: AW: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D087B40D16B@wm021.weinmann.com>
References: <D99582E5322435468A77E74BB0039E7B1D1655BF4D@SRV02.hamburg.garz-fricke.de>
 <EF2E73589CA71846A15D0B2CDF79505D087B40D16B@wm021.weinmann.com>
Message-ID: <D99582E5322435468A77E74BB0039E7B1D1655BFBB@SRV02.hamburg.garz-fricke.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> this case is already catched in at91_do_twi_transfer():

Sorry, I did not found this code in your patch.
(http://www.mail-archive.com/linux-i2c at vger.kernel.org/msg06556.html):

> +       if (is_read) {
> +               if (!dev->buf_len)
> +                       at91_twi_write(dev, AT91_TWI_CR,
> +                                      AT91_TWI_START | AT91_TWI_STOP);
> +               else
> +                       at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_START);
> +               at91_twi_write(dev, AT91_TWI_IER,
> +                              AT91_TWI_TXCOMP | AT91_TWI_RXRDY);
> +       } else {
> +               at91_twi_write_next_byte(dev);
> +               at91_twi_write(dev, AT91_TWI_IER,
> +                              AT91_TWI_TXCOMP | AT91_TWI_TXRDY);
> +       }

Is there a more recent version ?

Mit freundlichen Gr??en / Best regards
Carsten Behling

Development Engineer
Garz & Fricke GmbH
Tempowerkring 2, 21079 Hamburg - Germany
Amtsgericht Hamburg HRB 60514
Gesch?ftsf?hrer: Manfred Garz, Matthias Fricke
Phone: +49 (0) 40 791 899 - 56
Fax:    +49 40 / 791 899 - 39
www.garz-fricke.com 

 


-----Urspr?ngliche Nachricht-----
Von: Voss, Nikolaus [mailto:N.Voss at weinmann.de] 
Gesendet: Dienstag, 22. November 2011 17:26
An: Carsten Behling
Cc: 'linux-i2c at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'; 'linux-kernel at vger.kernel.org'
Betreff: RE: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver

Hi,

Carsten Behling wrote on 2011-11-22:
> +static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
> +{
> +       *dev->buf = at91_twi_read(dev, AT91_TWI_RHR) & 0xff;
> +
> +       /* send stop if second but last byte has been read */
> +       if (--dev->buf_len == 1)
> +               at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
> 
> 
> 
> If dev->buf_len =1 at the beginning of a read transfer, a stop condition will
> never be send.

this case is already catched in at91_do_twi_transfer():

+       if (dev->msg->flags & I2C_M_RD) {
+               unsigned start_flags = AT91_TWI_START;
+
+               /* if only one byte is to be read, immediately stop transfer */
+               if (dev->buf_len <= 1 && !(dev->msg->flags & I2C_M_RECV_LEN))
+                       start_flags |= AT91_TWI_STOP;
+               at91_twi_write(dev, AT91_TWI_CR, start_flags);

Thanks for reviewing,
Niko
