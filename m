From: ccross@android.com (Colin Cross)
Date: Tue, 18 Oct 2011 11:37:28 -0700
Subject: [PATCH] [3.3] ARM: tegra: use APB DMA for accessing APB devices
In-Reply-To: <1318961898-21254-1-git-send-email-olof@lixom.net>
References: <1318961898-21254-1-git-send-email-olof@lixom.net>
Message-ID: <CAMbhsRRPmd7jAMkbB_HBw-UeQi1W2-+n_qkhsfHfP6rSd01naw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 11:18 AM, Olof Johansson <olof@lixom.net> wrote:
> From: Jon Mayo <jmayo@nvidia.com>
>
> Tegra2 hangs if APB registers are accessed from the cpu during an
> apb dma operation. The workaround is to use apb dma to read/write the
> registers instead.
>
> There is a dependency loop between fuses, clocks, and APBDMA. ?If dma
> is enabled, fuse reads must go through APBDMA to avoid corruption due
> to a hw bug. ?APBDMA requires a clock to be enabled. ?Clocks must read
> a fuse to determine allowable cpu frequencies.
>
> Separate out the fuse DMA initialization, and allow the fuse read
> and write functions to be called without using DMA before the DMA
> initialization has been completed. ?Access to the fuses before APBDMA
> is initialized won't hit the hardware bug because nothing else can be
> using DMA.
>
> Original fuse registar access code from Varun Wadekar
> <vwadekar@nvidia.com>, improved by Colin Cross <ccross@android.com>
> and later moved to separate driver by Jon Mayo <jmayo@nvidia.com>.
>
> Signed-off-by: Jon Mayo <jmayo@nvidia.com>
> [olof: hooked up init calls to dma init, minor cleanups]
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> ?arch/arm/mach-tegra/Makefile | ? ?1 +
> ?arch/arm/mach-tegra/apbio.c ?| ?149 ++++++++++++++++++++++++++++++++++++++++++
> ?arch/arm/mach-tegra/apbio.h ?| ? 22 ++++++
> ?arch/arm/mach-tegra/dma.c ? ?| ? ?4 +
> ?4 files changed, 176 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-tegra/apbio.c
> ?create mode 100644 arch/arm/mach-tegra/apbio.h
>
<snip>

> diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
> index c0cf967..b7b6957 100644
> --- a/arch/arm/mach-tegra/dma.c
> +++ b/arch/arm/mach-tegra/dma.c
> @@ -33,6 +33,8 @@
> ?#include <mach/iomap.h>
> ?#include <mach/suspend.h>
>
> +#include "apbio.h"
> +
> ?#define APB_DMA_GEN ? ? ? ? ? ? ? ? ? ? ? ? ? ?0x000
> ?#define GEN_ENABLE ? ? ? ? ? ? ? ? ? ? ? ? ? ? (1<<31)
>
> @@ -735,6 +737,8 @@ int __init tegra_dma_init(void)
>
> ? ? ? ?tegra_dma_initialized = true;
>
> + ? ? ? tegra_init_apb_dma();
> +
It seems wrong for the dma api init to call init on one of the users
of the dma api.  For explicit ordering dependencies like this, maybe
postcore_initcall is not the right way to trigger tegra_dma_init.

> ? ? ? ?return 0;
> ?fail:
> ? ? ? ?writel(0, addr + APB_DMA_GEN);
> --
> 1.7.4.1
>
>
