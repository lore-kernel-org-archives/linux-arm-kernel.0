From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Jan 2014 13:45:00 -0700
Subject: [PATCH 5/5] ARM: tegra: cpuidle: use firmware call for power down
In-Reply-To: <1390299016-14105-6-git-send-email-acourbot@nvidia.com>
References: <1390299016-14105-1-git-send-email-acourbot@nvidia.com>
 <1390299016-14105-6-git-send-email-acourbot@nvidia.com>
Message-ID: <52E02DCC.1000404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2014 03:10 AM, Alexandre Courbot wrote:
> Invoke the do_idle() firmware call before suspending a CPU so that the
> underlying firmware (if any) can take necessary action.

> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c

> @@ -45,6 +46,8 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
>  
>  	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
>  
> +	call_firmware_op(do_idle);
> +
>  	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
>  
>  	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);

Don't you need to have the kernel also *not* do something when entering
idle; doesn't the FW op replace some of the register writes that the
kernel would otherwise be doing?
