From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Jan 2013 19:50:40 -0800
Subject: [PATCHv2 for soc 4/4] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <1359651943-21752-5-git-send-email-dinguyen@altera.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-5-git-send-email-dinguyen@altera.com>
Message-ID: <20130201035040.GE4838@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 31, 2013 at 11:05:43AM -0600, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Because the CPU1 start address is different for socfpga-vt and
> socfpga-cyclone5, we add code to use the correct CPU1 start addr.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
> ---
>  .../bindings/arm/altera/socfpga-system.txt         |    2 ++
>  arch/arm/boot/dts/socfpga_cyclone5.dts             |    4 ++++
>  arch/arm/boot/dts/socfpga_vt.dts                   |    4 ++++
>  arch/arm/mach-socfpga/core.h                       |    4 +++-
>  arch/arm/mach-socfpga/headsmp.S                    |   16 ++++++++++++----
>  arch/arm/mach-socfpga/platsmp.c                    |    3 ++-
>  arch/arm/mach-socfpga/socfpga.c                    |    8 ++++++++
>  7 files changed, 35 insertions(+), 6 deletions(-)

> @@ -72,6 +73,13 @@ void __init socfpga_sysmgr_init(void)
>  	struct device_node *np;
>  
>  	np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
> +
> +	if (of_property_read_u32(np, "cpu1-start-addr",
> +			(u32 *) &cpu1start_addr)) {
> +		early_printk("Need cpu1-start-addr in device tree.\n");
> +		panic("Need cpu1-start-addr in device tree.\n");
> +	}
> +
>  	sys_manager_base_addr = of_iomap(np, 0);

Wouldn't it be easier to diagnose this failure if you just printed the error
and continued booting without the second CPU? An early panic is usually really
hard to debug since you might not get early console without extra work.


-Olof
