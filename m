From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 12 Nov 2009 20:37:13 +0100
Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if PCIe
	bridge is present
In-Reply-To: <200911121519.42786.dk-arm-linux@gmx.de>
References: <200911121519.42786.dk-arm-linux@gmx.de>
Message-ID: <20091112193713.GG22741@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 06:19:42AM -0800, Dieter Kiermaier wrote:

> Below you can find a first version of the patch which enables PCI on my openrd-base board
> together with a PCIe->PCI bridge.
> Please let me know if something is wrong with it.
>
> [...]
> 
> Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if PCIe bridge is present

In the end, this is what the patch does, but the issue it solves is (at
least in theory) not specific to PCI.


> If this bit isn't disabled kernel crash during bootup when booted
> with current mainline u-boot (version U-Boot 2009.08-00208-g9ef0569)
> and a PCIe -> PCI bridge is connected to the system.

And this should really explain why the crash happens (which is because
there is a PCI master abort because the PCI scanning code probes all
possible device IDs on the secondary side of the bridge).


> diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> index 77617c7..9e57326 100644
> --- a/arch/arm/mach-kirkwood/openrd_base-setup.c
> +++ b/arch/arm/mach-kirkwood/openrd_base-setup.c

This issue is not OpenRD-specific, so shouldn't be handled in the
OpenRD board setup file.


>  static int __init openrd_base_pci_init(void)
>  {
> +	u32 cpu_config_reg;
> +	void __iomem *base;
> +	base = ioremap(0xf1020100, 4);
> +	if (base)
> +	{
> +		cpu_config_reg = readl(base);
> +		cpu_config_reg &= ~(1 << 2);
> +		writel(cpu_config_reg, base);
> +	}
> +	iounmap(base);

There's no need to ioremap/iounmap -- the 1MB block of CPU peripheral
registers is permanently mapped into the kernel virtual address
region.

How about something like this instead?  (Since you did most of the work
I don't mind having you as the From: on the patch.)



commit 728ae3400ef8fc3da10491d48e6832b6bb7aa281
Author: Lennert Buytenhek <buytenh@wantstofly.org>
Date:   Thu Nov 12 20:31:14 2009 +0100

    [ARM] Kirkwood: disable propagation of mbus error to the CPU local bus
    
    Disable propagation of mbus errors to the CPU local bus, as this causes
    mbus errors (which can occur for example for PCI aborts) to throw CPU
    aborts, which we're not set up to deal with.
    
    Reported-by: Dieter Kiermaier <dk-arm-linux@gmx.de>
    Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 0acb61f..96c98c2 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -915,6 +915,14 @@ void __init kirkwood_init(void)
 	kirkwood_uart0_data[0].uartclk = kirkwood_tclk;
 	kirkwood_uart1_data[0].uartclk = kirkwood_tclk;
 
+	/*
+	 * Disable propagation of mbus errors to the CPU local bus,
+	 * as this causes mbus errors (which can occur for example
+	 * for PCI aborts) to throw CPU aborts, which we're not set
+	 * up to deal with.
+	 */
+	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
+
 	kirkwood_setup_cpu_mbus();
 
 #ifdef CONFIG_CACHE_FEROCEON_L2
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 9e80d92..418f501 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -13,6 +13,9 @@
 
 #include <mach/kirkwood.h>
 
+#define CPU_CONFIG		(BRIDGE_VIRT_BASE | 0x0100)
+#define CPU_CONFIG_ERROR_PROP	0x00000004
+
 #define CPU_CONTROL		(BRIDGE_VIRT_BASE | 0x0104)
 #define CPU_RESET		0x00000002
 
--
