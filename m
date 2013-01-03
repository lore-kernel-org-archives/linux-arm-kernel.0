From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 Jan 2013 10:29:23 -0700
Subject: [PATCH 1/2] timer: vt8500: Move system timer to clocksource
In-Reply-To: <1357183510-8476-2-git-send-email-linux@prisktech.co.nz>
References: <1357183510-8476-1-git-send-email-linux@prisktech.co.nz>
 <1357183510-8476-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <50E5BFF3.9060805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2013 08:25 PM, Tony Prisk wrote:
> Move mach-vt8500/timer.c to drivers/clocksource/vt8500_timer.c
> and make necessary changes to Kconfig and Makefile.
> 
> vt8500_timer is moved from vt8500.c to clocksource/vt8500_timer.c
> and added to common.h for reference from the board descriptor.

> diff --git a/arch/arm/mach-vt8500/common.h b/arch/arm/mach-vt8500/common.h

> +/* defined in drivers/clocksource/vt8500_timer.c */
> +extern struct sys_timer vt8500_timer;
> +void __init vt8500_timer_init(void);

struct sys_timer has been deleted; the patches to do so are in the most
recent 2 linux-next. Another advantage of this change if your SoC
supports DT is that you don't need to explicitly prototype a separate
struct or function per clocksource driver, but board files can simply
call clocksource_of_init(), and the core code will look up the
appropriate clocksource driver to initialize using DT.

You can find the series at:

git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
arm-timer-rework

I believe that branch should be stable now unless any bugs are found so
you can base your changes on it; I plan to send a pull request to
include that branch in arm-soc tomorrow morning.
