From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jan 2016 10:27:47 +0000
Subject: [PATCH 2/4] irqchip: bcm2836: Add SMP support for the 2836
In-Reply-To: <1451166444-11044-3-git-send-email-eric@anholt.net>
References: <1451166444-11044-1-git-send-email-eric@anholt.net>
 <1451166444-11044-3-git-send-email-eric@anholt.net>
Message-ID: <20160102102747.GO8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 26, 2015 at 01:47:22PM -0800, Eric Anholt wrote:
> +int __init bcm2836_smp_boot_secondary(unsigned int cpu,
> +				      struct task_struct *idle)
> +{
> +	unsigned long secondary_startup_phys =
> +		(unsigned long)virt_to_phys((void *)secondary_startup);
> +
> +	dsb();
> +	writel(secondary_startup_phys,
> +	       intc.base + LOCAL_MAILBOX3_SET0 + 16 * cpu);

Please explain why you need this dsb() - I can't see a reason for it.
writel() has a barrier internally prior to writing the register, and
therefore I think the above dsb() is entirely redundant.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
