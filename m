From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jul 2015 11:34:29 +0100
Subject: [PATCH 4/4] arm: psci: add cpuidle_ops support
In-Reply-To: <1436350417-6712-5-git-send-email-jszhang@marvell.com>
References: <1436350417-6712-1-git-send-email-jszhang@marvell.com>
 <1436350417-6712-5-git-send-email-jszhang@marvell.com>
Message-ID: <20150708103429.GL7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 06:13:37PM +0800, Jisheng Zhang wrote:
> This patch implements cpuidle_ops using psci. After this patch, we can use
> cpuidle-arm.c with psci backend for both arm and arm64.

I really don't see the point of most of the patches in this series.

To summarise, what you're doing is:

1. Renaming arch/arm/kernel/psci_smp.c to arch/arm/kernel/psci.c
2. Adding a #ifdef CONFIG_SMP around _all_ the code in psci.c
3. Adding cpuidle code with an #ifdef CONFIG_CPU_IDLE around all the
   CPU idle code.

So, we end up with a file which contains:

/*
 header
 */
#include statements

/*
 some commentry relevant to SMP code
 */
#ifdef CONFIG_CPU_IDLE
... cpu idle code ...
#endif
#ifdef CONFIG_SMP
... smp code ...
#endif

which (a) is a mess, and (b) is unnecessary.  The only relevant bits which
are shared are the #include statements.

Please try this alternative approach:

1. Leave psci_smp.c alone.
2. Add arch/arm/kernel/psci_cpuidle.c containing the #include statements
   you need, and the CPU idle code.

I think such an approach will reduce your patch series to two patches,
one moving the ARM64 code, and one adding the cpuidle code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
