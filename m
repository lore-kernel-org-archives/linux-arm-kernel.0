From: julien.grall@arm.com (Julien Grall)
Date: Fri, 8 Jul 2016 10:34:43 +0100
Subject: [PATCH v3] xen/arm: enable clocks used by the hypervisor
In-Reply-To: <1467963871-31556-1-git-send-email-dirk.behme@de.bosch.com>
References: <1467963871-31556-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <577F73B3.8090807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On 08/07/16 08:44, Dirk Behme wrote:
> Xen hypervisor drivers might replace native OS drivers. The result is
> that some important clocks that are enabled by the OS in the non-Xen
> case are not properly enabled in the presence of Xen. The clocks
> property enumerates the clocks that must be enabled by the Xen clock
> consumer.
>
> An example is a serial driver enabled by the hypervisor. Xen must

I would say "An example is the UART used by the hypervisor."

> consume and enable these clocks in the OS to ensure behavior continues
> after firmware configures the UART hardware and corresponding clock
> harder.

What do you mean by "harder"?

Also, relying on DOM0 to enable the clock looks very wrong to me and you 
give an example which prove that. The UART will be used before hand by 
Xen, however it will not be possible to use it if you expect DOM0 to 
enable the clock (or even modify the clock frequency).

The clock should be enabled either by the firmware or Xen. But not DOM0. 
DOM0 should not touch this clock at all.

Furthermore, this property could be used for clock associated to device 
that will be passthrough-ed to a guest. In this case, the clock would be 
enabled even if the device is not in use which will result more power 
consumption.

>
> Up to now, the workaround for this has been to use the Linux kernel
> command line parameter 'clk_ignore_unused'. See Xen bug
>
> http://bugs.xenproject.org/xen/bug/45
>
> too.
>
> To fix this, we will add the "unused" clocks in Xen to the hypervisor
> node. The OS has to consume and enable the clocks from the hypervisor
> node, then.
>
> Therefore, check if there is a "clocks" entry in the hypervisor node
> and if so consume and enable the given clocks. This prevents the clocks
> from being disabled by the OS.
>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
> Changes in v3: Use the xen.txt description proposed by Michael. Thanks!
>
> Changes in v2: Drop the Linux implementation details like clk_disable_unused
> 	       in xen.txt.
>
>   Documentation/devicetree/bindings/arm/xen.txt | 13 ++++++++
>   arch/arm/xen/enlighten.c                      | 47 +++++++++++++++++++++++++++
>   2 files changed, 60 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> index c9b9321..00f2165 100644
> --- a/Documentation/devicetree/bindings/arm/xen.txt
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -17,6 +17,19 @@ the following properties:
>     A GIC node is also required.
>     This property is unnecessary when booting Dom0 using ACPI.
>
> +Optional properties:
> +
> +clocks: one or more clocks to be enabled
> +  Xen hypervisor drivers might replace native OS drivers. The result is

"native OS" has no meaning on Xen. This seems to be a cumbersome way to 
say that the device will be used by the hypervisor and hidden to DOM0 
(aka hardware domain).

> +  that some important clocks that are enabled by the OS in the non-Xen
> +  case are not properly enabled in the presence of Xen. The clocks
> +  property enumerates the clocks that must be enabled by the Xen clock
> +  consumer.
> +  An example is a serial driver enabled by the hypervisor. Xen must
> +  consume and enable these clocks in the OS to ensure behavior continues
> +  after firmware configures the UART hardware and corresponding clock
> +  harder.
> +
>   To support UEFI on Xen ARM virtual platforms, Xen populates the FDT "uefi" node
>   under /hypervisor with following parameters:

Regards,

-- 
Julien Grall
