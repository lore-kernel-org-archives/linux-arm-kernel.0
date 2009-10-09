From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Fri, 9 Oct 2009 08:51:44 +0200
Subject: [PATCH v2] OpenRD base: Initialize PCI express and i2c
In-Reply-To: <20091009082645.7e37573d@marrow.netinsight.se>
References: <200910081333.43065.dk-arm-linux@gmx.de>
	<alpine.LFD.2.00.0910081337260.18779@xanadu.home>
	<20091009082645.7e37573d@marrow.netinsight.se>
Message-ID: <200910090851.44868.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

I've tested you patch against 2.6.32-rc3 from Linus' tree and it works fine and applies without any issues.

Without patch:
h-3.2# uname -a
Linux DB88FXX81 2.6.32-rc3-00256-g36a0790 #1 PREEMPT Fri Oct 9 08:44:33 CEST 2009 armv5tel GNU/Linux
sh-3.2#
sh-3.2#
sh-3.2# lspci
sh-3.2#

with applied patch:

sh-3.2# uname -a
Linux DB88FXX81 2.6.32-rc3-00256-g36a0790-dirty #2 PREEMPT Fri Oct 9 08:47:02 CEST 2009 armv5tel GNU/Linux
sh-3.2# lspci
00:00.0 Class 0580: Device 11ab:6281 (rev 02)
00:01.0 Class 0200: Device 10ec:8168 (rev 01)
sh-3.2#

Sorry for the silly question, but what have I do to ack it?

Greetings,
Dieter

> Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
> ---
> Right now I don't have a PCI card to test with, so Dieter: could you
> test the patch and ack it?
> 
> ChangeLog:
> 
> v2:
>   * Rebase against 2.6.32
>   * Remove UART1 initialization (UART1 is not always present - either
>     the SD card or UART1 is selected)
> 
>  arch/arm/mach-kirkwood/openrd_base-setup.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> index 947dfb8..77617c7 100644
> --- a/arch/arm/mach-kirkwood/openrd_base-setup.c
> +++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
> @@ -70,8 +70,20 @@ static void __init openrd_base_init(void)
>  	kirkwood_ge00_init(&openrd_base_ge00_data);
>  	kirkwood_sata_init(&openrd_base_sata_data);
>  	kirkwood_sdio_init(&openrd_base_mvsdio_data);
> +
> +	kirkwood_i2c_init();
>  }
>  
> +static int __init openrd_base_pci_init(void)
> +{
> +	if (machine_is_openrd_base())
> +		kirkwood_pcie_init();
> +
> +	return 0;
> + }
> +subsys_initcall(openrd_base_pci_init);
> +
> +
>  MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
>  	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
>  	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
