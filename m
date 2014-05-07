From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 May 2014 09:50:32 -0700
Subject: [PATCH v5 08/14] ARM: hisi: add hip04 SoC support
In-Reply-To: <1399473888-12947-9-git-send-email-haojian.zhuang@linaro.org>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140507165032.GC12692@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 10:44:42PM +0800, Haojian Zhuang wrote:
> Hisilicon Hi3xxx is based on Cortex A9 Core. Now HiP04 SoC is based on
> Cortex A15 Core. Since multiple clusters is used in HiP04 SoC, it could
> be based on MCPM.
> 
> And HiP04 supports LPAE to support large memory.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  .../bindings/arm/hisilicon/hisilicon.txt           |  19 ++
>  .../devicetree/bindings/clock/hip04-clock.txt      |  20 ++
>  arch/arm/mach-hisi/Kconfig                         |  10 +-
>  arch/arm/mach-hisi/Makefile                        |   1 +
>  arch/arm/mach-hisi/core.h                          |   2 +
>  arch/arm/mach-hisi/hisilicon.c                     |  12 +
>  arch/arm/mach-hisi/platmcpm.c                      | 314 +++++++++++++++++++++
>  7 files changed, 377 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/hip04-clock.txt
>  create mode 100644 arch/arm/mach-hisi/platmcpm.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index df0a452..20736b0 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -4,6 +4,10 @@ Hisilicon Platforms Device Tree Bindings
>  Hi4511 Board
>  Required root node properties:
>  	- compatible = "hisilicon,hi3620-hi4511";
> +HiP04 D01 Board
> +Required root node properties:
> +	- compatible = "hisilicon,hip04-d01";
> +
>  
>  Hisilicon system controller
>  
> @@ -19,6 +23,13 @@ Optional properties:
>  		If reg value is not zero, cpun exit wfi and go
>  - resume-offset : offset in sysctrl for notifying cpu0 when resume
>  - reboot-offset : offset in sysctrl for system reboot
> +- relocation-entry : relocation address of secondary cpu boot code
> +- relocation-size : relocation size of secondary cpu boot code
> +- bootwrapper-phys : physical address of boot wrapper
> +- bootwrapper-size : size of boot wrapper
> +- bootwrapper-magic : magic number for secondary cpu in boot wrapper
> +The memory area of [bootwrapper-phys : bootwrapper-phys+bootwrapper-size]
> +should be reserved. This should be set in /memreserve/ node in DTS file.

This binding spec should be split up in separate files, it's hard to tell
from the patch what part of the binding this is appending to. Please do
that in a preceding patch, and then add new contents on top.


-Olof
