From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 3 Dec 2013 13:02:59 -0800
Subject: Build warning in drivers/dma/mmp_tdma.c
In-Reply-To: <529DB5C8.1010500@marvell.com>
References: <CAPcyv4i1i+3ia5qcYA-LR4TFq1MOCXTHLhW2u5maq6Us9kyATg@mail.gmail.com>
 <CAMj5Bkjk6v_2Op1oph8GGw2mf8w40c-L3JhBRPNsRewiFxQHpw@mail.gmail.com>
 <529C37F3.1040205@marvell.com>
 <CAPcyv4jfk+JBv7WY_njuYtx8hERZHhoCAij=FOfqxAhLJAHnFA@mail.gmail.com>
 <CAMj5Bkjkndq1-AJSm0k9Mm8xeaWEGktoFb6nZ3kr7RackFdcaw@mail.gmail.com>
 <529D4273.10602@gmail.com> <529DB5C8.1010500@marvell.com>
Message-ID: <CAA9_cmc0+onxBJ4_xRAPSfH2Hx6ky87EZk9_8kJvbED03_Ca1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 3, 2013 at 2:43 AM, Qiao Zhou <zhouqiao@marvell.com> wrote:
> On 12/03/2013 10:31 AM, Haojian Zhuang wrote:
>>
>> I prefer to add CONFIG_MMP_SRAM instead, since sram isn't available in
>> pxa168.
>
> Hi Dan,
>
> I have two patches. Could you help check whether it can fix the issue?
>
> BTW, actually the 2nd alone is enough. The 1st patch is just in case that
> you still want to use the old sram driver, and you need to enable MMP_SRAM.
>
> All, please help review the patches.
>
> From 94601015d525db6d2baf47f4d517f38ae2e5e802 Mon Sep 17 00:00:00 2001
> From: Qiao Zhou <zhouqiao@marvell.com>
> Date: Tue, 3 Dec 2013 11:06:29 +0800
> Subject: [PATCH 1/2] arm: mmp: build sram driver alone
>
> sram driver can be used by many chips besides CPU_MMP2, and so build
> it alone.
>
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
>  arch/arm/mach-mmp/Makefile |    3 ++-
>
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
> index 9b702a1..98f0f63 100644
> --- a/arch/arm/mach-mmp/Makefile
> +++ b/arch/arm/mach-mmp/Makefile
> @@ -7,7 +7,8 @@ obj-y                           += common.o devices.o time.o
>  # SoC support
>  obj-$(CONFIG_CPU_PXA168)       += pxa168.o
>  obj-$(CONFIG_CPU_PXA910)       += pxa910.o
>
> -obj-$(CONFIG_CPU_MMP2)         += mmp2.o sram.o
> +obj-$(CONFIG_CPU_MMP2)         += mmp2.o
> +obj-$(CONFIG_MMP_SRAM)         += sram.o

Missing the Kconfig change to add "config MMP_SRAM"?

>
>  ifeq ($(CONFIG_COMMON_CLK), )
>  obj-y                          += clock.o
> --
> 1.7.0.4
>
>
> From 5396b1bffd574dbe778387979ecc24c51ee0c7a4 Mon Sep 17 00:00:00 2001
> From: Qiao Zhou <zhouqiao@marvell.com>
> Date: Tue, 3 Dec 2013 18:17:02 +0800
> Subject: [PATCH 2/2] dma: mmp-tdma: use gen_pool to get asram
>
> use generic pool to get audio sram, instead of sram driver
>
> Signed-off-by: nhcao <nhcao@marvell.com>
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
>  drivers/dma/Kconfig    |    1 +
>  drivers/dma/mmp_tdma.c |   22 +++++++++++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index dd2874e..eeffe3c 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -288,6 +288,7 @@ config MMP_TDMA
>
>         bool "MMP Two-Channel DMA support"
>         depends on ARCH_MMP
>         select DMA_ENGINE
> +       select GENERIC_ALLOCATOR

You still need a depends on MMP_SRAM right?  Otherwise this just turns
the compile error into a much more subtle runtime failure.
