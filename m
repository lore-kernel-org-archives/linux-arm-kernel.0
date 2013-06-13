From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Jun 2013 13:23:41 -0600
Subject: [PATCH v2 3/3] ARM: tegra: set CPU reset handler with firmware op
In-Reply-To: <1371114745-24710-4-git-send-email-acourbot@nvidia.com>
References: <1371114745-24710-1-git-send-email-acourbot@nvidia.com>
 <1371114745-24710-4-git-send-email-acourbot@nvidia.com>
Message-ID: <51BA1C3D.1010608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2013 03:12 AM, Alexandre Courbot wrote:
> Use a firmware operation to set the CPU reset handler and only resort to
> doing it ourselves if there is none defined.
> 
> This supports the booting of secondary CPUs on devices using a TrustZone
> secure monitor.

> diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c

> +	err = call_firmware_op(set_cpu_boot_addr, 0, reset_address);
> +	switch (err) {
> +	case -ENOSYS:
> +		tegra_cpu_reset_handler_set(reset_address);
> +		/* pass-through */

Rather than detecting -ENOSYS and falling back to the custom
tegra_cpu_reset_handler_set(), does it make sense to plug in
tegra_cpu_reset_handler_set as the firmware op when there is no secure
firmware detected? That way, this code wouldn't need the special case;
that would be isolated to firmware.c.
