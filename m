From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 20 Jun 2016 12:33:57 +0200
Subject: Auto-detecting touchscreen controller and dealing with hw
 configuration differences on q8 tablets
In-Reply-To: <5E70AD96-4E8E-4430-AF99-0AA0FCF5F8E7@konsulko.com>
References: <bc978925-46a4-c069-8793-903a87ec70b8@redhat.com>
 <5E70AD96-4E8E-4430-AF99-0AA0FCF5F8E7@konsulko.com>
Message-ID: <87r3bsywru.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> u-boot will work, but you will get into trouble if you demand users to drop to u-boot
> to make changes.

On my device I use barebox, which is a bit easier *) to use than U-Boot.

Still I don't expect my users to the bootloader. Instead my hardware has
a 256 byte i2c EEPROM where I store information. And the user can run a
user-space command to change settings there, e.g.

uccomm verbose_boot yes
uccomm power_config ignition

... and so on. I could do some of them via bootloader environment files,
but not all.

And this is the other obvious way of doing "communication" from Linux
user-space to bootloader: setting the environment. The bootloader could
mount the partition and try to source some file, to get the info needed.




*) in barebox, you have actual shell-like script that look sane, not
 variables that call variables, e.g. you can do things like this:

	if [ $oem_id = 255 ]; then
		splash -x 550 -y 500 -b 0xffffff /env/logo.png
		fb0.enable=1
		pwm_02080000.period_ns=200000
		pwm_02080000.duty_ns=160000
		pwm_02080000.enable=1
	fi
	gpio_set_value 191 1

There are also commands available to directly modify the device tree.
