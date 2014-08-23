From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Aug 2014 21:04:48 +0200
Subject: [PATCH] ipmi: work around gcc-4.9 build warning
Message-ID: <58708252.p9ogO3naVQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building ipmi on arm with gcc-4.9 results in this warning
for an allmodconfig build:

drivers/char/ipmi/ipmi_si_intf.c: In function 'ipmi_thread':
include/linux/time.h:28:5: warning: 'busy_until.tv_sec' may be used uninitialized in this function [-Wmaybe-uninitialized]
  if (lhs->tv_sec > rhs->tv_sec)
     ^
drivers/char/ipmi/ipmi_si_intf.c:1007:18: note: 'busy_until.tv_sec' was declared here
  struct timespec busy_until;
                  ^

The warning is bogus and this case can not occur. Apparently
this is a false positive resulting from gcc getting a little
smarter about tracking assignments but not smart enough. Marking
the ipmi_thread_busy_wait function as inline gives the gcc
optimization logic enough information to figure out for itself
that the case cannot happen, which gets rid of the warning
without adding any fake initialization.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 5d665680ae33..539ff0db52fc 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -965,9 +965,9 @@ static inline int ipmi_si_is_busy(struct timespec *ts)
 	return ts->tv_nsec != -1;
 }
 
-static int ipmi_thread_busy_wait(enum si_sm_result smi_result,
-				 const struct smi_info *smi_info,
-				 struct timespec *busy_until)
+static inline int ipmi_thread_busy_wait(enum si_sm_result smi_result,
+					const struct smi_info *smi_info,
+					struct timespec *busy_until)
 {
 	unsigned int max_busy_us = 0;
 
