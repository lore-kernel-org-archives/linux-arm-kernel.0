From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Jul 2016 11:39:17 +0100
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <1467701423-31138-1-git-send-email-dirk.behme@de.bosch.com>
References: <1467701423-31138-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20160705103917.GC20478@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 05, 2016 at 08:50:23AM +0200, Dirk Behme wrote:
> Some clocks might be used by the Xen hypervisor and not by the Linux
> kernel. If these are not registered by the Linux kernel, they might be
> disabled by clk_disable_unused() as the kernel doesn't know that they
> are used. The clock of the serial console handled by Xen is one
> example for this. It might be disabled by clk_disable_unused() which
> stops the whole serial output, even from Xen, then.
> 
> Up to now, the workaround for this has been to use the Linux kernel
> command line parameter 'clk_ignore_unused'. See Xen bug
> 
> http://bugs.xenproject.org/xen/bug/45
> 
> too.
> 
> To fix this, we will add the "unused" clocks in Xen to the hypervisor
> node. The Linux kernel has to register the clocks from the hypervisor
> node, then.
> 
> Therefore, check if there is a "clocks" entry in the hypervisor node
> and if so register the given clocks to the Linux kernel clock
> framework and with this mark them as used. This prevents the clocks
> from being disabled.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
> Changes in v2: Drop the Linux implementation details like clk_disable_unused
> 	       in xen.txt.

Thanks for doing this.

>  Documentation/devicetree/bindings/arm/xen.txt | 13 ++++++++
>  arch/arm/xen/enlighten.c                      | 47 +++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> index c9b9321..21fd469 100644
> --- a/Documentation/devicetree/bindings/arm/xen.txt
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -17,6 +17,19 @@ the following properties:
>    A GIC node is also required.
>    This property is unnecessary when booting Dom0 using ACPI.
>  
> +Optional properties:
> +
> +- clocks: one or more clocks to be registered.
> +  Xen hypervisor drivers might replace native drivers, resulting in
> +  clocks not registered by these native drivers. To avoid that these
> +  unregistered clocks are disabled by the Linux kernel initialization
> +  register them in the hypervisor node.
> +  An example for this are the clocks of a serial driver already enabled
> +  by the firmware. If the clocks used by the serial hardware interface
> +  are not registered by the serial driver itself the serial output
> +  might stop once the Linux kernel initialization disables the 'unused'
> +  clocks.

The above describes the set of problems, but doesn't set out the actual
contract. It also covers a number of Linux implementation details in
abstract.

As I commented previously [1], the binding should describe the set of
guarantees that you rewquire (e.g. that the clocks must be left as-is,
not gated, and their rates left unchanged).

Please describe the specific set of guarantees that you require.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/440434.html
