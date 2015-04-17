From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Apr 2015 00:22:01 +0100
Subject: [PATCH 7/7] ARM: BCM63xx: Add SMP support for BCM63138
In-Reply-To: <1429310032-19402-8-git-send-email-f.fainelli@gmail.com>
References: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
 <1429310032-19402-8-git-send-email-f.fainelli@gmail.com>
Message-ID: <20150417232201.GD12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 03:33:52PM -0700, Florian Fainelli wrote:
> +
> +extern unsigned int VFP_arch;
...
> +	/* The BCM63138 SoC has two Cortex-A9 CPUs, CPU0 features a complete
> +	 * and fully functional VFP unit that can be used, but CPU1 does not.
> +	 * Since we will not be able to trap kernel-mode NEON to force
> +	 * migration to CPU0, just do not advertise VFP support at all.
> +	 *
> +	 * This will make vfp_init bail out and do not attempt to use VFP at
> +	 * all, for kernel-mode NEON, we do not want to introduce any
> +	 * conditionals in hot-paths, so we just restrict the system to UP.
> +	 */
> +#ifdef CONFIG_VFP
> +	if (ncores > 1) {
> +		pr_warn("SMP: secondary CPUs lack VFP unit, disabling VFP\n");
> +		VFP_arch = 1;

What makes you think that doing this hack would be somehow acceptable?

Please, do the job properly.  Add a function hook into the VFP code
called "vfp_disable()" so that it's obvious that you want to disable
it - and, because that code will be localised to VFP, it then becomes
acceptable to set VFP_arch=1.  Don't rely on current VFP behaviour
through setting VFP_arch directly in from platform code - that's
nothing more than a hack and a disgusting layering violation.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
