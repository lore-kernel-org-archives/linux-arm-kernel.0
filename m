From: jnair@caviumnetworks.com (Jayachandran C)
Date: Sat, 20 Jan 2018 23:00:48 -0800
Subject: [PATCH v2] irqchip/gic-v3-its: Add workaround for ThunderX2
 erratum #174
In-Reply-To: <20180118052820.30286-1-ganapatrao.kulkarni@cavium.com>
References: <20180118052820.30286-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20180121070038.GA4450@jc-sabre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 10:58:20AM +0530, Ganapatrao Kulkarni wrote:
> This erratum is observed on the ThunderX2 GICv3 ITS. When a
> MOVI command is used to change affinity of a LPI to a collection/cpu
> on another node, the LPI is not delivered to the cpu.
> An additional INV command is required after the MOVI to deliver
> the LPI to the new destination.
> 
> If we add INV after MOVI, there is a chance that we lose LPIs which
> are raised when the affinity is changed. So for now, adding workaround fix
> to disable inter node affinity change.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
> 
> v2: Added workaround to avoid inter node affinity change.
> 
> v1: Initial patch
> 
>  Documentation/arm64/silicon-errata.txt |  1 +
>  arch/arm64/Kconfig                     | 10 ++++++++++
>  drivers/irqchip/irq-gic-v3-its.c       | 21 ++++++++++++++++++++-
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index fc1c884..fb27cb5 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -63,6 +63,7 @@ stable kernels.
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
>  | Cavium         | ThunderX Core   | #30115          | CAVIUM_ERRATUM_30115        |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
> +| Cavium         | ThunderX2 ITS   | #174            | CAVIUM_ERRATUM_174          |
>  | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
>  | Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
>  |                |                 |                 |                             |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c9a7e9e..0dbf3bd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -461,6 +461,16 @@ config ARM64_ERRATUM_843419
>  
>  	  If unsure, say Y.
>  
> +config CAVIUM_ERRATUM_174
> +	bool "Cavium ThunderX2 erratum 174"
> +	default y
> +	help
> +	  Cavium ThunderX2 dual socket systems may loose interrupts
> +	  on affinity change to a cpu on other node.
> +	  This workaround fix avoids inter node affinity change.

This has to be fixed up to match the commit message (and for spelling).
I have seen some questions offlist about how important this fix is,
and how it can affect users - so that would be useful to have in the
description as well.

To clarify, this errata comes into play only when the irq affinity is
forced from the node given by the device (and ITS) affinity to another
node.  This should not happen in normal, useful configurations.

Also, we will hold further posting of this errata until we do another
round of investigation with the hardware team for a better solution.
If we can handle the pending interrupts for the small window of MOVI/INV
in first workaround, we will not need this restriction at all.

JC.
