From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 19 Sep 2013 20:27:18 +0200
Subject: [PATCH] IXP4xx: Add Gateworks Cambria support.
In-Reply-To: <20130919160309-31798@mutt-kz> (Luka Perkov's message of "Thu, 19
 Sep 2013 18:03:09 +0200")
References: <m3vc1ya9fw.fsf@t19.piap.pl> <20130919160309-31798@mutt-kz>
Message-ID: <m3a9j8wttl.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Luka,

Luka Perkov <luka@openwrt.org> writes:

> I was unable to bring up serial console with your patch. I was using
> latest OpenWrt trunk for rootfs, did you use the same?

No, I use a different, custom initramfs.

> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> IP-Config: Failed to open eth0
> IP-Config: Failed to open eth1
> IP-Config: No network devices available
> Warning: unable to open an initial console.

Perhaps it wants the network console instead?
Are you using "console=ttyS0,115200" or something alike?
Or a /dev filesystem problems maybe?

> I'm no expert on licenses but shouldn't here at least be GPLv2 since the
> file originated from OpenWrt support for this board which is GPLv2.

Of course the license is GPLv2, every Linux kernel file (except maybe
some firmware and non-copyrightable code) is so licensed. See the file
"COPYING"

>> +static struct i2c_board_info __initdata cambria_i2c_board_info[] = {
>> +	{
>> +		I2C_BOARD_INFO("ad7418", 0x28),
>> +	},
>> +	{
>> +		I2C_BOARD_INFO("24c08", 0x50),
>> +		.platform_data	= &cambria_eeprom_info,
>> +	},
>> +};
>
> I couldn't test this because of the console issue but in OpenWrt sources
> the value is 0x51 and not 0x50. Did you change it by accident?

Not really, the board simply has 24C08 at 0x50. OpenWRT does a trick with
offsets here, you can't really have a 24C08 at 0x51 (possible addresses
for most chips are 0x50 and 0x54). I just did it the straight way and it
works fine.

> Also, shouldn't arch/arm/configs/ixp4xx_defconfig be updated too?

Well, probably.
-- 
Krzysztof Halasa
