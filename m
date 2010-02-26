From: jbe@pengutronix.de (Juergen Beisert)
Date: Fri, 26 Feb 2010 10:56:36 +0100
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <210155.75899.qm@web51001.mail.re2.yahoo.com>
References: <210155.75899.qm@web51001.mail.re2.yahoo.com>
Message-ID: <201002261056.37618.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam wrote:
> > Are you sure that this works? Don't you see a lot of Bad
> > blocks reports
> > in boot messages?
>
> I followed the same approach used on other i.MX boards. This is what I see:
> ...
> NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung NAND 256MiB 1,8V
> 8-bit) Scanning device for bad blocks
> Bad eraseblock 42 at 0x000000540000
> Bad eraseblock 125 at 0x000000fa0000
> Bad eraseblock 887 at 0x000006ee0000
> Bad eraseblock 1750 at 0x00000dac0000
> Bad eraseblock 2046 at 0x00000ffc0000
> Bad eraseblock 2047 at 0x00000ffe0000
> Registering mxc_nand as whole device
>
> If I define it as:
>
> static struct mxc_nand_platform_data mx31pdk_nand_board_info = {
> 	.width = 1,
> 	.hw_ecc = 1,
> 	.flash_bbt =1,
> };

Your bootloader also use a Bad Block Table? Then also your kernel should use 
it. If hardware ECC is in use, its always a good idea to collect the bad 
blocks into a BBT. Most of the time you can't control at which offset in the 
OOB data the NAND controller will store the ECC sum. There is the risk it 
will destroy manufacturer's bad block markers. So, its better to collect 
these marked bad blocks into a BBT the first time you use the NAND device. 
After that _only_ the BBT should be used to handle bad blocks (in the boot 
loader and the kernel).

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
