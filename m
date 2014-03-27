From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 27 Mar 2014 15:00:17 +0100
Subject: [PATCH 1/6] ARM: mvebu: introduce CPU reset code
In-Reply-To: <1395927485-11842-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1395927485-11842-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <53342EF1.3020508@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 27/03/2014 14:38, Thomas Petazzoni wrote:
> The Armada 370 and Armada XP have registers that allow to reset the
> CPUs, which is particularly useful to take the secondary CPUs out of
> reset in the context of the SMP support.
> 
> Unfortunately, an implementation mistake was originally made and the
> support for these registers was integrated into the PMSU driver, which
> is in fact completely unrelated. And it turns out that the Armada 375
> has the same CPU reset registers, but does not have the PMSU
> registers.
> 
> Therefore, this commit creates a small CPU reset driver. All it does
> is provide a simple mvebu_cpu_reset_deassert() function that the SMP
> support code can call to take secondary CPUs out of reset. As of this
> commit, the driver isn't being used, it will be used through changes
> in the following commits.
> 
> Note that we initially planned to use the 'reset controller'
> framework, but it requires the addition of "resets" properties in the
> Device Tree, which are causing too many problems if we want to keep
> the Device Tree backward compatibility. Moreover, the 'reset
> controller' framework is mainly useful when a device driver needs to
> request a reset of its device from a separate reset controller. In our
> case, the CPU reset handling and the SMP core code are both located in
> arch/arm/mach-mvebu/ and are tightly linked together, so there's no
> real benefit in going through a separate framework.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---

[...]

> +static struct of_device_id of_cpu_reset_table[] = {
> +	{.compatible = "marvell,armada-370-cpu-reset", .data = (void*) ARMADA_370_MAX_CPUS },
What about removing the previous line. As explained in patch 5, the CPU
reset driver is not really needed as Armada 370 is single core and the
only use of the CPU reset driver is to boot secondary processors. So by
removing this line we can keep the marvell,armada-370-cpu-reset node in
the device tree without doing useless initialization.

Thanks,

Gregory

> +	{.compatible = "marvell,armada-xp-cpu-reset",  .data = (void*) ARMADA_XP_MAX_CPUS },
> +	{ /* end of list */ },

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
