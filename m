From: aik@ozlabs.ru (Alexey Kardashevskiy)
Date: Wed, 30 Nov 2016 13:11:58 +1100
Subject: [PATCH 3/3] ARM: dts: sunxi: enable SDIO Wi-Fi on Orange Pi Zero
In-Reply-To: <20161129131922.JFbeipav@smtp2o.mail.yandex.net>
References: <20161129131922.JFbeipav@smtp2o.mail.yandex.net>
Message-ID: <a7a3c242-f359-5b32-bff8-4641d8566d50@ozlabs.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/16 21:19, Icenowy Zheng wrote:
> 
> 2016?11?29? 15:16? Alexey Kardashevskiy <aik@ozlabs.ru>???
>>
>>
>>
>> On Wed, Nov 23, 2016 at 6:59 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>>>
>>> Hi,
>>>
>>> On Tue, Nov 22, 2016 at 12:24:21AM +0800, Icenowy Zheng wrote:
>>> > There's a Allwinner's XR819 SDIO Wi-Fi module soldered on the board of
>>> > Orange Pi Zero, which used a dedicated regulator to power.
>>> >
>>> > Add the device tree node of the regulator, the enable gpio (with
>>> > mmc-pwrseq) and the sdio controller.
>>> >
>>> > There's a out-of-tree driver tested to work with this device tree.
>>
>>
>> btw could you please give a pointer where to find a XR819 driver for
> relatively recent kernel (4.8 may be, just not 3.4)? Thanks.
> 
> https://github.com/Icenowy/xradio

Thanks!

I tried, cannot make it work though.

This compiles:

CONFIG_XRADIO=y
CONFIG_XRADIO_SDIO=y
CONFIG_XRADIO_NON_POWER_OF_TWO_BLOCKSIZES=y
# CONFIG_XRADIO_USE_GPIO_IRQ is not set
# CONFIG_XRADIO_5GHZ_SUPPORT is not set
# CONFIG_XRADIO_WAPI_SUPPORT is not set
CONFIG_XRADIO_USE_EXTENSIONS=y

But produces:

[    0.964793] [XRADIO] Driver Label:L34M.01.08.0002
[    0.969659] [XRADIO] Allocated hw_priv @ df684dc0
[    3.038167] [SBUS_ERR] sdio probe timeout!
[    3.046283] [XRADIO_ERR] sbus_sdio_init failed


If I enable CONFIG_XRADIO_USE_GPIO_IRQ (which Kconfig suggest to enable -
do I really need it?), it does not compile:

drivers/built-in.o: In function `sdio_irq_subscribe':
sunxi_sid.c:(.text+0x12dfe8): undefined reference to `xradio_request_gpio_irq'
sunxi_sid.c:(.text+0x12e06c): undefined reference to `xradio_free_gpio_irq'
sunxi_sid.c:(.text+0x12e080): undefined reference to `sunxi_mci_check_r1_ready'
drivers/built-in.o: In function `sdio_irq_unsubscribe':
sunxi_sid.c:(.text+0x12e3b0): undefined reference to `xradio_free_gpio_irq'
Makefile:962: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1


I am using recent upstream kernel and
https://patchwork.kernel.org/patch/9439759/
https://patchwork.kernel.org/patch/9439761/

and I added missing emac.

Basically, here is my current tree with all sun8xi support
https://github.com/aik/linux/commits/pizero

and I just did
git -C drivers/net/ethernet clone https://github.com/Icenowy/xradio

and compiled it into vmlinux (no modules).

What am I missing? Sorry I am a newbie with ARM. Thanks.


-- 
Alexey
