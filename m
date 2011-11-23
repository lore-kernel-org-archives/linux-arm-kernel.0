From: carsten.behling@garz-fricke.com (Carsten Behling)
Date: Wed, 23 Nov 2011 15:21:52 +0100
Subject: AW: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D087B40D349@wm021.weinmann.com>
References: <D99582E5322435468A77E74BB0039E7B1D1655BF4D@SRV02.hamburg.garz-fricke.de>
 <EF2E73589CA71846A15D0B2CDF79505D087B40D16B@wm021.weinmann.com>
 <D99582E5322435468A77E74BB0039E7B1D1655BFBB@SRV02.hamburg.garz-fricke.de>
 <EF2E73589CA71846A15D0B2CDF79505D087B40D349@wm021.weinmann.com>
Message-ID: <D99582E5322435468A77E74BB0039E7B1D1655C047@SRV02.hamburg.garz-fricke.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I try to use the at24 eeprom driver on top of this driver.

This EEPROM (24c32) works with two address bytes.

Writing results in a call to at91_twi_xfer() with num=1.
In this case the internal address register is not used and the address is sent out within the buffer.

Reading results in a call to at91_twi_xfer() with num=2.
In this case the internal address register is used.

However the MSB of the internal address resides in msg->buf[0] and the LSB resides in msg->buf[1] of the first message.

As a result the code:

+		for (i = 0; i < msg->len; ++i) {
+			internal_address |= ((unsigned)msg->buf[i]) << (8 * i);
+			int_addr_flag += AT91_TWI_IADRSZ_1;
+		}
+		at91_twi_write(dev, AT91_TWI_IADR, internal_address);

constructs an internal address in a wrong byte order.

Example: Try to read from address 0x100:

msg[0]->buf[0] = 0x1; 
msg[0]->buf[1] = 0x0;

results in

internal_address = 0x1;

I think it must be:

+		for (i = 0; i < msg->len; ++i) {
+			internal_address |= ((unsigned)msg->buf[msg->len-1-i]) << (8 * i);
+			int_addr_flag += AT91_TWI_IADRSZ_1;
+		}
+		at91_twi_write(dev, AT91_TWI_IADR, internal_address);

... or the at24 eeprom driver constructs the wrong internal address ...

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
Gesendet: Mittwoch, 23. November 2011 11:29
An: Carsten Behling
Cc: 'linux-i2c at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'; 'linux-kernel@vger.kernel.org'
Betreff: RE: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver

Hi,

Carsten Behling wrote on 2011-11-23:

>> this case is already catched in at91_do_twi_transfer():
> 
> Sorry, I did not found this code in your patch.
> (http://www.mail-archive.com/linux-i2c at vger.kernel.org/msg06556.html):
> 
>> +       if (is_read) {
>> +               if (!dev->buf_len)

yes, this won't work for buf_len == 1. It is corrected in
https://lkml.org/lkml/2011/11/18/223 which I held back for some time
as it should have been just a feature extension. I was not aware it
also fixed the buf_len = 1 bug. Sorry for that...

(Explanation: in the first implementation I immediately decremented
buf_len, so buf_len == 1 could not occur. Later I removed that but
did not fully fold it into the base patch.)

Thanks,
Niko
