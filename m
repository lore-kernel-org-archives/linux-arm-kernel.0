From: marex@denx.de (Marek Vasut)
Date: Thu, 26 Apr 2012 13:26:29 +0200
Subject: possible MXS-i2c bug
Message-ID: <201204261326.29388.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I recently tried mxs-i2c (on 3.4-rc4) with at24 eeprom, didn't work as expected.

Apparently, there might be some timing issue, when I put printk() into the at24 
driver eeprom write function, it "fixed" itself. Though, replacing the i2c 
driver with i2c gpio also fixed the issue, so I suspect the i2c driver has some 
flaw in it.

Further investigation turned out, that the complete() isn't called in the mxs-
i2c driver irq handler unless I put the printk(). Putting the printk() in the 
xfer function of the mxs-i2c driver instead of eeprom write function has the 
same effect -- "fixing" it.

I didn't have time to properly investigate this matter, so consider this as a 
quick and dirty bugreport (maybe?). But thie behavior I saw it quite easily 
replicated, try:

dd if=/dev/zero of=/sys/bus/devices/0-00XY/eeprom bs=<sizeof eeprom> count=1

And the write will timeout.

Has anyone recently tested the driver with such eeprom? Anything from the 24xxx 
series with 16 bit addresses has this problem. I tested and saw this on more 
than one board, so this is not hardware issue.

If noone has any fixes already, I'll debug this tonight or so.

Thanks!

Best regards,
Marek Vasut
