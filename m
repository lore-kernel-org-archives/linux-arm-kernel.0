From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Nov 2013 17:45:22 +0900
Subject: [PATCH] ARM: shmobile: Enable DSW2 with gpio-keys on KZM9D
In-Reply-To: <20131114062735.GF22870@verge.net.au>
References: <20131113230345.21482.36997.sendpatchset@w520>
 <20131114052204.GD22870@verge.net.au>
 <20131114062735.GF22870@verge.net.au>
Message-ID: <CANqRtoTb-93b8UPyRLOBS11eXVuoqSB0A5CkGFYMhw42DGsKaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Nov 14, 2013 at 3:27 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Nov 14, 2013 at 02:22:06PM +0900, Simon Horman wrote:
>> On Thu, Nov 14, 2013 at 08:03:45AM +0900, Magnus Damm wrote:
>> > From: Magnus Damm <damm@opensource.se>
>> >
>> > Use the gpio-keys driver to support the 4 pins on the
>> > dip switch DSW2 which is mounted on the KZM9D board.
>> >
>> > Signed-off-by: Magnus Damm <damm@opensource.se>
>>
>> Hi Magnus,
>>
>> I have tried enabling the following on a config produced
>> using the kzm9d_defconfig:
>>
>> CONFIG_INPUT_KEYBOARD
>> CONFIG_INPUT_EVDEV
>> CONFIG_KEYBOARD_GPIO
>>
>> But all I see so far in dmsg is:
>>
>> # dmesg | grep gpio
>> platform gpio_keys.3: Driver gpio-keys requests probe deferral
>>
>> I was expecting something more along the lines of:
>> input: gpio-keys as /devices/platform/gpio-keys/input/input0
>>
>> Could you give me some guidance on how to test this?
>
> I now notice that I also need
> "[PATCH 00/03] gpio: R-Car and EM GPIO update"
>
> But with that applied I now see:
>
> # dmesg  | grep gpio
> gpio-keys gpio_keys.3: Failed to request GPIO 14, error -517
> platform gpio_keys.3: Driver gpio-keys requests probe deferral

Thanks for testing. In case of EMEV2 we don't have any PFC support, so
because of that you probably need to deselect PINCTRL. The patch below
does the trick, but for proper operation you probably have to split
this up per-SoC. And these days KZM9D is MULTIPLATFORM only where
PINCTRL probably wants to be set as a global default, so I suppose the
proper way to support this is to add PFC support for EMEV2.

Another option would be to make these two cases behave the same:
- PINCTRL=y but no pinctrl support for the SoC
- PINCTRL=n

--- 0001/arch/arm/Kconfig
+++ work/arch/arm/Kconfig    2013-11-14 17:42:36.000000000 +0900
@@ -655,7 +655,7 @@ config ARCH_SHMOBILE
     select MIGHT_HAVE_CACHE_L2X0
     select MULTI_IRQ_HANDLER
     select NO_IOPORT
-    select PINCTRL
+#    select PINCTRL
     select PM_GENERIC_DOMAINS if PM
     select SPARSE_IRQ
     help

Cheers,

/ magnus
