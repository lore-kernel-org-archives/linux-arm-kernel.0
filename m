From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 14:48:48 +0200
Subject: [PATCH V2 6/6] mpcore_wdt: Move declarations in a separate header
In-Reply-To: <4E1456D9.8090003@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<201107061358.48496.arnd@arndb.de> <4E1456D9.8090003@mvista.com>
Message-ID: <201107061448.49092.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Vitaly Kuzmichev wrote:
> The patch is aimed to resolve checkpatch warning on "extern" function
> prototype:
> 
> WARNING: externs should be avoided in .c files
> #44: FILE: drivers/watchdog/mpcore_wdt.c:37:
> +unsigned long twd_timer_get_rate(void);
> 
> If it's ok to leave this warning I would also like to throw out this patch.

Ah, I see. That part is indeed an interface, so the declaration should be
in a header file that gets included by both the clocksource and the watchdog
driver.

However, you should not put all the local declarations in the header,
and the header needs to be in a location that gets included by
drivers/clocksource/arm_smp_twd.c as well. In this case, I think
it makes more sense to name that header based on the driver that
exports the function, not based on the driver that uses it,
or you can add it to an *appropriate* existing header file, if you
can find one.

An obvious choice would be arch/arm/include/asm/smp_twd.h.

	Arnd
