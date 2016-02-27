From: ynvich@gmail.com (Sergei Ianovich)
Date: Sat, 27 Feb 2016 22:32:57 +0300
Subject: [PATCH] spi: lp-8841: return correct error code from probe
In-Reply-To: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
References: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
Message-ID: <1456601577.23036.60.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi?Arnd,

On Thu, 2016-02-25 at 12:37 +0100, Arnd Bergmann wrote:
> The spi_lp8841_rtc_probe() function misses an initialization of the
> return code when it fails to get its memory resource, as gcc notices:
> 
> drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
> drivers/spi/spi-lp8841-rtc.c:239:9: error: 'ret' may be used
> uninitialized in this function [-Werror=maybe-uninitialized]

I wasn't getting this warning when I was building the driver. This
happened because -Wmaybe-uninitialized is suppressed when
CONFIG_CC_OPTIMIZE_FOR_SIZE is selected
(Commit?e74fc973b6e531fef1fce8b101ffff05ecfb774c "Turn off -Wmaybe-
uninitialized when building with -Os").

A recent gcc version like 5.3.1 doesn't seem to produce much false
positives. May it make sense to revert that commit?

The gcc-5.3.1 log for reference.

---8<---
$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
$ make -j 4 -s KCFLAGS=-Wmaybe-uninitialized
ipc/shm.c: In function 'SyS_shmdt':
ipc/shm.c:1344:59: warning: 'file' may be used uninitialized in this function [-Wmaybe-uninitialized]
???????((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
???????????????????????????????????????????????????????????^
ipc/shm.c:1267:15: note: 'file' was declared here
? struct file *file;
???????????????^
mm/vmscan.c: In function 'shrink_zone':
mm/vmscan.c:2418:18: warning: 'lru_pages' may be used uninitialized in this function [-Wmaybe-uninitialized]
????unsigned long lru_pages;
??????????????????^
drivers/gpio/gpiolib-of.c: In function 'of_gpiochip_add':
drivers/gpio/gpiolib-of.c:221:7: warning: 'dflags' may be used uninitialized in this function [-Wmaybe-uninitialized]
???if (gpiod_hog(desc, name, lflags, dflags))
???????^
drivers/gpio/gpiolib-of.c:211:19: note: 'dflags' was declared here
? enum gpiod_flags dflags;
???????????????????^
drivers/gpio/gpiolib-of.c:221:7: warning: 'lflags' may be used uninitialized in this function [-Wmaybe-uninitialized]
???if (gpiod_hog(desc, name, lflags, dflags))
???????^
drivers/gpio/gpiolib-of.c:210:25: note: 'lflags' was declared here
? enum gpio_lookup_flags lflags;
?????????????????????????^
net/core/dev.c: In function 'validate_xmit_skb_list':
net/core/dev.c:2984:15: warning: 'tail' may be used uninitialized in this function [-Wmaybe-uninitialized]
????tail->next = skb;
???????????????^
drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
drivers/spi/spi-lp8841-rtc.c:239:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
? return ret;
?????????^
net/sunrpc/svcauth_unix.c: In function 'unix_gid_parse':
net/sunrpc/svcauth_unix.c:510:2: warning: 'gids' may be used uninitialized in this function [-Wmaybe-uninitialized]
? for (i = 0 ; i < gids ; i++) {
? ^
In file included from include/linux/sunrpc/svcauth.h:16:0,
?????????????????from include/linux/sunrpc/svc.h:18,
?????????????????from include/linux/sunrpc/svcsock.h:12,
?????????????????from net/sunrpc/svcauth_unix.c:6:
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitialized in this function [-Wmaybe-uninitialized]
? return rv - boot.tv_sec;
?????????^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
? time_t rv;
?????????^
net/sunrpc/svcauth_unix.c: In function 'ip_map_parse':
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitialized in this function [-Wmaybe-uninitialized]
? return rv - boot.tv_sec;
?????????^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
? time_t rv;
?????????^
In file included from net/sunrpc/cache.c:34:0:
net/sunrpc/cache.c: In function 'write_flush':
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitialized in this function [-Wmaybe-uninitialized]
? return rv - boot.tv_sec;
?????????^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
? time_t rv;
?????????^
net/sunrpc/auth_gss/svcauth_gss.c: In function 'rsc_parse':
net/sunrpc/auth_gss/svcauth_gss.c:456:22: warning: 'id' may be used uninitialized in this function [-Wmaybe-uninitialized]
???rsci.cred.cr_uid = make_kuid(&init_user_ns, id);
??????????????????????^
In file included from include/linux/sunrpc/svcauth.h:16:0,
?????????????????from include/linux/sunrpc/svc.h:18,
?????????????????from include/linux/sunrpc/auth_gss.h:17,
?????????????????from net/sunrpc/auth_gss/svcauth_gss.c:46:
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitialized in this function [-Wmaybe-uninitialized]
? return rv - boot.tv_sec;
?????????^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
? time_t rv;
?????????^
net/sunrpc/auth_gss/svcauth_gss.c: In function 'rsi_parse':
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitialized in this function [-Wmaybe-uninitialized]
? return rv - boot.tv_sec;
?????????^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
? time_t rv;
?????????^
---8<---
