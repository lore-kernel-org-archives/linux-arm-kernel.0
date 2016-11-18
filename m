From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2016 12:48:07 +0000
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <9481995.AMBiYg893F@wuerfel>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <3360559.T0zQaY0FJ3@wuerfel>
 <62d93a1f-fd34-771b-4280-6b7cde5c61ad@samsung.com>
 <9481995.AMBiYg893F@wuerfel>
Message-ID: <20161118124805.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 01:14:35PM +0100, Arnd Bergmann wrote:
> @@ -41,6 +43,9 @@ void scu_enable(void __iomem *scu_base)
>  {
>  	u32 scu_ctrl;
>  
> +	if (scu_base)
> +		scu_base = scu_base_addr;
> +

This looks to me like nonsense.

>  #ifdef CONFIG_ARM_ERRATA_764369
>  	/* Cortex-A9 only */
>  	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
> @@ -85,6 +90,9 @@ int scu_power_mode(void __iomem *scu_base, unsigned int mode)
>  	unsigned int val;
>  	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(smp_processor_id()), 0);
>  
> +	if (scu_base)
> +		scu_base = scu_base_addr;
> +

Ditto.

Rather than doing this, I'd much prefer to always store the SCU base in
the SCU code, and remove the "void __iomem *scu_base" argment from all
these functions.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
