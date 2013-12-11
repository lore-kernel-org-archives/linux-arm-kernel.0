From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 11 Dec 2013 17:39:42 +0800
Subject: [PATCH] ARM: pxa: fix USB gadget driver compilation regression
In-Reply-To: <1386751738-13563-1-git-send-email-linus.walleij@linaro.org>
References: <1386751738-13563-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <52A832DE.6050105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 04:48 PM, Linus Walleij wrote:
> After commit 88f718e3fa4d67f3a8dbe79a2f97d722323e4051
> "ARM: pxa: delete the custom GPIO header" a compilation
> error was introduced in the PXA25x gadget driver.
> An attempt to fix the problem was made in
> commit b144e4ab1ef130e8bf30bcd3e529b7f35112c503
> "usb: gadget: fix pxa25x compilation problems"
> by explictly stating the driver needs the <mach/hardware.h>
> header, which solved the compilation for a few boards,
> such as the pxa255-idp and its defconfig.
>
> However the Lubbock board has this special clause in
> drivers/usb/gadget/pxa25x_udc.c:
>
> This include file has an implicit dependency on
> <mach/irqs.h> having been included before <mach/lubbock.h>
> was included.
>
> Before commit 88f718e3fa4d67f3a8dbe79a2f97d722323e4051
> "ARM: pxa: delete the custom GPIO header" this implicit
> dependency for the pxa25x_udc compile on the Lubbock was
> satisfied by <linux/gpio.h> implicitly including
> <mach/gpio.h> which was in turn including <mach/irqs.h>,
> apart from the earlier added <mach/hardware.h>.
>
> Fix this by having the PXA25x <mach/lubbock.h> explicitly
> include <mach/irqs.h>.
>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Greg Kroah-Hartmann <gregkh@linuxfoundation.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/arm/mach-pxa/include/mach/lubbock.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-pxa/include/mach/lubbock.h b/arch/arm/mach-pxa/include/mach/lubbock.h
> index 2a086e8373eb..958cd6af9384 100644
> --- a/arch/arm/mach-pxa/include/mach/lubbock.h
> +++ b/arch/arm/mach-pxa/include/mach/lubbock.h
> @@ -10,6 +10,8 @@
>    * published by the Free Software Foundation.
>    */
>
> +#include <mach/irqs.h>
> +
>   #define LUBBOCK_ETH_PHYS	PXA_CS3_PHYS
>
>   #define LUBBOCK_FPGA_PHYS	PXA_CS2_PHYS
>

Applied.

Thanks
Haojian
