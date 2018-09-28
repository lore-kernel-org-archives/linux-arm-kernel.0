From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 28 Sep 2018 09:08:19 +0100
Subject: [PATCH 0/3] ARM/PSCI: Fix THUMB2_KERNEL entry points
In-Reply-To: <20180927192711.26455-1-f.fainelli@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
Message-ID: <c68b01ab-9077-73cc-8356-25a4e3a909f0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-09-27 8:27 PM, Florian Fainelli wrote:
> Hi all,
> 
> While playing with THUMB2_KERNEL on ARCH_BRCMSTB, several issues came up
> which are addressed by these 3 patches.

Hmmm, PSCI looks to explicitly support Thumb entrypoints ("T32 support" 
in section 6.4.3 of DEN0022D), so these changes smell a little of 
papering over a more fundamental problem, which is presumably either 
that Thumb symbols are not being resolved correctly, or that the 
firmware you're using has a bug.

Robin.

> The THUMB() assembler macro is a no-op unless CONFIG_THUMB2_KERNEL so
> using it unconditionally for CONFIG_ARM should not cause a problem
> AFAICT.
> 
> Those patches can all be independently picked up by their respective
> maintainers and don't depent on one another.
> 
> Thank you!
> 
> Florian Fainelli (3):
>    firmware/psci: Fix cpu_resume entry points with THUMB2_KERNEL
>    ARM: psci: Fix secondary core boot with THUMB2_KERNEL
>    soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL
> 
>   arch/arm/kernel/psci_smp.c          |  4 ++--
>   drivers/firmware/psci.c             | 18 +++++++++++++++---
>   drivers/soc/bcm/brcmstb/pm/pm-arm.c |  2 +-
>   3 files changed, 18 insertions(+), 6 deletions(-)
> 
