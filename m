From: jgq516@gmail.com (xiao jiang)
Date: Wed, 20 Oct 2010 09:45:58 +0800
Subject: [PATCH 1/1] Mx35pdk: enable debug board support
In-Reply-To: <AANLkTimJ_5ci9MnyxhUXemAc6YJGb2KXR2q-QX-MKEHo@mail.gmail.com>
References: <1287129633-9244-1-git-send-email-jgq516@gmail.com>
	<AANLkTikY=wBiJZ0NFKJKX-TTKRAj_LWmaxD-BpuPNYzL@mail.gmail.com>
	<AANLkTi=jyQDNmGK1-VB_xOP8H4+jXNwS6oHgft90gGLW@mail.gmail.com>
	<AANLkTim65XWxn_Mc59PXbiOOqUVMDNqeweU38y_3R7_X@mail.gmail.com>
	<AANLkTi=upCD4iKhkvkzk7Kcb++OYR3pZTQw4i9fTEkFg@mail.gmail.com>
	<AANLkTimqGRiP1QUtNdJuyQMN_bf+4R7dEn-LNd7bhAu4@mail.gmail.com>
	<AANLkTinD_LWiqh9Pc-jOsKArfBBLAYeExgfdNMb5CaAT@mail.gmail.com>
	<AANLkTimJ_5ci9MnyxhUXemAc6YJGb2KXR2q-QX-MKEHo@mail.gmail.com>
Message-ID: <AANLkTimdEhO9m7HW-TNxPaEVk85GDEThyn_DanJ_CZ+i@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

2010/10/20 Fabio Estevam <festevam@gmail.com>

> Xiao,
>
> On Tue, Oct 19, 2010 at 2:54 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Tue, Oct 19, 2010 at 1:59 PM, xiao jiang <jgq516@gmail.com> wrote:
> >>
> >>
> > ...
> >>>
> >> I don't think so, since **_PIN_** is expected for IOMUX_TO_IRQ, not
> >> **_PAD_**, and I think kernel can't pass compile with
> >> "IOMUX_TO_IRQ(MX35_PAD_GPIO1_1__GPIO1_1)"
> >
> > Have you tried the same method as in MX51_3ds?
> >
> > #define EXPIO_PARENT_INT    (MXC_INTERNAL_IRQS + GPIO_PORTx + y)
> >
> > Regards,
> >
> > Fabio Estevam
> >
>
> Please try the the patch below. Worked fine for me.
>
The patch is ok for me too,  and  the definition of EXPIO_PARENT_INT is
similar like mx51_3ds board
as I had said before.
But since mxc_expio_init() should be return *0* if the debug board is
detected, We should use
mxc_expio_init(**_BASE_ADDR, EXPIO_PARENT_INT) other than
!mxc_expio_init(**_BASE_ADDR, EXPIO_PARENT_INT), right?  The same issue also
existed in mach-mx31_3ds.c.

Thanks,
Xiao Jiang



diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index 096fd33..9658e2d 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -143,6 +143,7 @@ config MACH_ARMADILLO5X0
>  config MACH_MX35_3DS
>        bool "Support MX35PDK platform"
>        select ARCH_MX35
> +       select MXC_DEBUG_BOARD
>        select IMX_HAVE_PLATFORM_IMX_UART
>        select IMX_HAVE_PLATFORM_MXC_NAND
>        default n
> diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c
> b/arch/arm/mach-mx3/mach-mx35_3ds.c
> index 91bb065..b7e6b9c 100644
> --- a/arch/arm/mach-mx3/mach-mx35_3ds.c
> +++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
> @@ -39,10 +39,15 @@
>  #include <mach/common.h>
>  #include <mach/iomux-mx35.h>
>  #include <mach/mxc_ehci.h>
> +#include <mach/3ds_debugboard.h>
> +#include <mach/irqs.h>
>
>  #include "devices-imx35.h"
>  #include "devices.h"
>
> +#define EXPIO_PARENT_INT       (MXC_INTERNAL_IRQS + GPIO_PORTA + 1)
> +
>  static const struct imxuart_platform_data uart_pdata __initconst = {
>        .flags = IMXUART_HAVE_RTSCTS,
>  };
> @@ -140,6 +145,10 @@ static void __init mxc_board_init(void)
>        mxc_register_device(&mxc_usbh1, &usb_host_pdata);
>
>        imx35_add_mxc_nand(&mx35pdk_nand_board_info);
> +
> +       if (!mxc_expio_init(MX35_CS5_BASE_ADDR, EXPIO_PARENT_INT))
> +               printk(KERN_WARNING "Init of the debugboard failed, all "
> +                                   "devices on the board are
> unusable.\n");
>  }
>
>  static void __init mx35pdk_timer_init(void)
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101020/52825fdd/attachment-0001.html>
