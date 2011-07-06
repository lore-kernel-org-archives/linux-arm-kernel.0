From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 14:22:38 +0200
Subject: [PATCH V2 3/6] mpcore_wdt: Fix WDIOC_SETOPTIONS handling
In-Reply-To: <1309892440-3260-4-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-4-git-send-email-vkuzmichev@mvista.com>
Message-ID: <201107061422.38705.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Vitaly Kuzmichev wrote:
> 
> According to the include/linux/watchdog.h WDIOC_SETOPTIONS is
> classified as 'read from device' ioctl call:
>   #define WDIOC_SETOPTIONS        _IOR(WATCHDOG_IOCTL_BASE, 4, int)
> 
> However, the driver 'mpcore_wdt' performs 'copy_from_user' only if
> _IOC_WRITE is set, thus the local variable 'uarg' which is used in
> WDIOC_SETOPTIONS handling remains uninitialized.
> 
> The proper way to fix this is to bind WDIOC_SETOPTIONS to _IOW,
> but this will break compatibility.
> So adding additional condition for performing 'copy_from_user'.
> 
> Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>

Is the new watchdog driver core ready for 3.1? If so, the best
solution would be to get rid of the entire ioctl function in
the mpcore_wdt driver and just use the core for that.

Otherwise, this patch is probably the best solution in the meantime.

	Arnd
