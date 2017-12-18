From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Dec 2017 21:24:45 +0100
Subject: [PATCH V2 3/9] ARM: stm32: prepare stm32 family to welcome armv7
 architecture
In-Reply-To: <1513610272-7824-4-git-send-email-ludovic.Barre@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
 <1513610272-7824-4-git-send-email-ludovic.Barre@st.com>
Message-ID: <CAK8P3a1WzkVQ3591XjVQPLCqP0_zZ4ksqJqWvm7de_OnkE3oaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 4:17 PM, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch prepares the STM32 machine for the integration of Cortex-A
> based microprocessor (MPU), on top of the existing Cortex-M
> microcontroller family (MCU). Since both MCUs and MPUs are sharing
> common hardware blocks we can keep using ARCH_STM32 flag for most of
> them. If a hardware block is specific to one family we can use either
> ARM_SINGLE_ARMV7M or ARCH_MULTI_V7 flag.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Looks good overall. Two more small comments:


>
> +if ARCH_STM32
> +
>  config MACH_STM32F429
> -       bool "STMicrolectronics STM32F429"
> -       depends on ARCH_STM32
> +       bool "STMicroelectronics STM32F429"
> +       depends on ARM_SINGLE_ARMV7M
>         default y

Instead of the explicit dependency for each board, I'd leave the surrounding
'if ARM_SINGLE_ARMV7M'. I think you had in v1.

> diff --git a/arch/arm/mach-stm32/Makefile b/arch/arm/mach-stm32/Makefile
> index bd0b7b5..5940af1 100644
> --- a/arch/arm/mach-stm32/Makefile
> +++ b/arch/arm/mach-stm32/Makefile
> @@ -1 +1 @@
> -obj-y += board-dt.o
> +obj-$(CONFIG_ARM_SINGLE_ARMV7M) += board-mcu-dt.o
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-mcu-dt.c
> similarity index 100%
> rename from arch/arm/mach-stm32/board-dt.c
> rename to arch/arm/mach-stm32/board-mcu-dt.c

Why the rename? I don't expect the new machines to have any notable
contents in a board file, if any at all, so just use one file for both.
I see the board-dt.c file refers to armv7m_restart, we can either put
that in an #ifdef, or find a way to make it the default for all armv7-m
platforms that don't provide any other restart method.

     Arnd
