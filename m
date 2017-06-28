From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 28 Jun 2017 08:55:08 -0700
Subject: [RFC 1/5] drivers: Add boot constraints core
In-Reply-To: <24921f2a6a86cb9b2b3a1cae86649180bc116a62.1498642745.git.viresh.kumar@linaro.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <24921f2a6a86cb9b2b3a1cae86649180bc116a62.1498642745.git.viresh.kumar@linaro.org>
Message-ID: <78941b27-c233-837d-9709-b11c01f1ab1f@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2017 03:26 AM, Viresh Kumar wrote:
> Some devices are powered ON by the bootloaders before the bootloader
> handovers control to Linux. It maybe important for those devices to keep
> working until the time a Linux device driver probes the device and
> reconfigure its resources.
> 
> A typical example of that can be the LCD controller, which is used by
> the bootloaders to show image(s) while the device is booting into Linux.
> The LCD controller can be using some resources, like clk, regulators,
> etc, that are shared between several devices. These shared resources
> should be programmed so that all the users of them are satisfied. If
> some user (X) driver gets probed before the LCD controller driver in
> this case, then it may end up reconfiguring these resources to ranges
> satisfying the current users (only user X) and that can make the LCD
> screen unstable.
> 
> This patch introduces the concept of boot-constraints, which will be set
> by the bootloaders and the kernel will satisfy them until the time
> driver for such a device is probed (successfully or unsuccessfully).
> 
> The list of boot constraint types is empty for now, and will be added by
> a later patch.
> 
> Only two routines are exposed by the boot constraints core for now:
> 
> - boot_constraint_add(): This will be called by parts of the kernel
>   (before the device is probed) to set the constraints.
> 
> - boot_constraints_remove(): This is called only by the driver core
>   after a device is probed successfully or unsuccessfully. Special
>   handling is done here for deffered probing.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/Kconfig            |  11 +++
>  drivers/base/Makefile           |   1 +
>  drivers/base/boot_constraint.c  | 210 ++++++++++++++++++++++++++++++++++++++++
>  drivers/base/dd.c               |  20 ++--
>  include/linux/boot_constraint.h |  28 ++++++
>  5 files changed, 263 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/base/boot_constraint.c
>  create mode 100644 include/linux/boot_constraint.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index d718ae4b907a..d71217a91793 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -339,4 +339,15 @@ config CMA_ALIGNMENT
>  
>  endif
>  
> +config BOOT_CONSTRAINTS
> +	bool "Boot constraints for devices"
> +	default y

Why default y?

As Linus just wrote yesterday:

No. We've tried. The only sensible default (and that I try to enforce)
is "new featrures default to 'n'"

> +	help
> +	  This enables boot constraints detection for devices. These constraints
> +	  are (normally) set by the Bootloader and must be satisfied by the
> +	  kernel until the relevant device driver is probed. Once the driver is
> +	  probed, the constraint is dropped.
> +
> +	  If unsure, say Y.
> +
>  endmenu
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index f2816f6ff76a..6094b3b75184 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -5,6 +5,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
>  			   cpu.o firmware.o init.o map.o devres.o \
>  			   attribute_container.o transport_class.o \
>  			   topology.o container.o property.o cacheinfo.o
> +obj-$(CONFIG_BOOT_CONSTRAINTS) += boot_constraint.o
>  obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
>  obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
>  obj-y			+= power/


-- 
~Randy
