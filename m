From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 31 Jul 2012 10:15:11 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q: Invert the GPIO controller order
In-Reply-To: <20120730142443.GL6802@n2100.arm.linux.org.uk>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <1343219864-3040-2-git-send-email-dirk.behme@de.bosch.com>
 <20120728134114.GH2128@S2101-09.ap.freescale.net>
 <8E7BE7398BB9294F8B826ADE09B18EBE6CC2FF7EE1@SI-MBX20.de.bosch.com>
 <20120730142443.GL6802@n2100.arm.linux.org.uk>
Message-ID: <5017940F.4070706@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2012 16:24, Russell King - ARM Linux wrote:
> On Mon, Jul 30, 2012 at 09:28:21AM +0200, Thomae Matthias (CM-AI/PJ-CF31) wrote:
>> I care about the global number because it is used to access GPIOs
>> from userspace via the Sysfs interface (see Documentation/gpio.txt).
>> Without the 2 patches, the GPIOs are mapped this way:
>>
>> gpiochip_add: registered GPIOs 224 to 255 on device: 209c000.gpio
>> gpiochip_add: registered GPIOs 192 to 223 on device: 20a0000.gpio
>> gpiochip_add: registered GPIOs 160 to 191 on device: 20a4000.gpio
>> gpiochip_add: registered GPIOs 128 to 159 on device: 20a8000.gpio
>> gpiochip_add: registered GPIOs 96 to 127 on device: 20ac000.gpio
>> gpiochip_add: registered GPIOs 64 to 95 on device: 20b0000.gpio
>> gpiochip_add: registered GPIOs 32 to 63 on device: 20b4000.gpio
>>
>> With the patches, the mapping looks like this:
>>
>> gpiochip_add: registered GPIOs 192 to 223 on device: 20b4000.gpio
>> gpiochip_add: registered GPIOs 160 to 191 on device: 20b0000.gpio
>> gpiochip_add: registered GPIOs 128 to 159 on device: 20ac000.gpio
>> gpiochip_add: registered GPIOs 96 to 127 on device: 20a8000.gpio
>> gpiochip_add: registered GPIOs 64 to 95 on device: 20a4000.gpio
>> gpiochip_add: registered GPIOs 32 to 63 on device: 20a0000.gpio
>> gpiochip_add: registered GPIOs 0 to 31 on device: 209c000.gpio
>>
>> I.e. pin 0 on gpio1 is now accessed via /sys/class/gpio/gpio0
>> instead of /sys/class/gpio/gpio224.
> 
> I think you're caring too much about the numbers you see within the Linux
> kernel...
> 
> So what happens when your platform is built as part of a single zImage
> along side a platform needing all the 256 GPIOs?  If the answer is "it
> doesn't work" you need to go back and re-evaluate what you're doing.
> 
> Especially with DT, you shouldn't need to worry about the absolute GPIO
> numbering.

Ok, thanks! If the patches we sent are not the way to go, maybe we need 
a better understanding then. Trying to learn something, I'd like to ask:

 From my understanding, a user in the _user_ space expects a 1:1 mapping:

user touching /sys/class/gpio/gpio0   -> controls HW GPIO bank 1 pin  0
...
user touching /sys/class/gpio/gpio31  -> controls HW GPIO bank 1 pin 31
...
user touching /sys/class/gpio/gpio223 -> controls HW GPIO bank 7 pin 31

Is this understanding wrong? Or is there a way to achieve this with the 
existing DT logic?

The above is what we tried to achieve with our patches. Without the 
patches, an unmodified DT and kernel gives us:

user touching /sys/class/gpio/gpio0   -> n/a (*)
...
user touching /sys/class/gpio/gpio32  -> controls HW GPIO bank 7 pin  0
...
user touching /sys/class/gpio/gpio224 -> controls HW GPIO bank 1 pin  0
...
user touching /sys/class/gpio/gpio255 -> controls HW GPIO bank 1 pin 31

(*) Note the offset of 32 due to ARCH_NR_GPIO is 256 while only 224 
GPIOs are there. And the 'inverted' access order from bank 7 to 1.

Many thanks for the help and best regards

Dirk
