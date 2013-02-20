From: james.hogan@imgtec.com (James Hogan)
Date: Wed, 20 Feb 2013 15:14:47 +0000
Subject: [PATCH 01/11] ARM: disable virt_to_bus/virt_to_bus almost
 everywhere
In-Reply-To: <1360849767-1463135-2-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-2-git-send-email-arnd@arndb.de>
Message-ID: <CAAG0J9_VqCGJJJZjSWGfFggALHU=vdWsSBeS39-DtxV=VXcJwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 February 2013 13:49, Arnd Bergmann <arnd@arndb.de> wrote:
> We are getting a number of warnings about the use of the deprecated
> bus_to_virt function in drivers using the ARM ISA DMA API:
>
> drivers/parport/parport_pc.c: In function 'parport_pc_fifo_write_block_dma':
> drivers/parport/parport_pc.c:622:3: warning: 'bus_to_virt' is deprecated
> (declared at arch/arm/include/asm/memory.h:253) [-Wdeprecated-declarations]
>
> This is only because that function gets used by the inline
> set_dma_addr() helper. We know that any driver for the ISA DMA API
> is correctly using the DMA addresses, so we can change this
> to use the __bus_to_virt() function instead, which does not warn.
>
> After this, there are no remaining drivers that are used on
> any defconfigs on ARM using virt_to_bus or bus_to_virt, with
> the exception of the OSS sound driver. That driver is only used
> on RiscPC, NetWinder and Shark, so we can set ARCH_NO_VIRT_TO_BUS
> on all other platforms and hide the deprecated functions, which
> is far more effective than marking them as deprecated, in order
> to avoid any new users of that code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig                 | 4 ++++
>  arch/arm/configs/shark_defconfig | 1 -
>  arch/arm/include/asm/dma.h       | 2 +-
>  arch/arm/include/asm/memory.h    | 2 ++
>  4 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 67874b8..91d4aea 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1450,6 +1450,10 @@ config ISA_DMA
>         bool
>         select ISA_DMA_API
>
> +config ARCH_NO_VIRT_TO_BUS
> +       def_bool y
> +       depends on !ARCH_RPC && !ARCH_NETWINDER && !ARCH_SHARK

Hi Arnd,

There's a patch in linux-next by Stephen Rothwell "Centralise
CONFIG_ARCH_NO_VIRT_TO_BUS" that removes this Kconfig symbol,
inverting/replacing it with "select HAVE_VIRT_TO_BUS" (including for
arch/arm) which will undo the effects of this.

Cheers
James
