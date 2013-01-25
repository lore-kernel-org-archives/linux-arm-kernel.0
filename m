From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:45:25 +0000
Subject: [PATCH 15/19] sunrpc: don't warn for unused variable 'buf'
In-Reply-To: <4FA345DA4F4AE44899BD2B03EEEC2FA91833C205@sacexcmbx05-prd.hq.netapp.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-16-git-send-email-arnd@arndb.de>
 <4FA345DA4F4AE44899BD2B03EEEC2FA91833C205@sacexcmbx05-prd.hq.netapp.com>
Message-ID: <201301252345.25829.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 January 2013, Myklebust, Trond wrote:
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > Marking it as __maybe_unused avoids a harmless gcc warning.
> 
> Alternatively, just declare it using the RPC_IFDEBUG() macro.

Right, makes sense: that's more consistent with other functions
doing the same thing. Thanks for taking a look.

	Arnd

8<----

>From 3b2baeac061bd60dbf14bb61bcc03cbd64c85ac4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Nov 2012 22:46:26 +0000
Subject: [PATCH] sunrpc: don't warn for unused variable 'buf'

When RPC_DEBUG is unset, the dprintk() macro does nothing,
causing the 'buf' variable in svc_printk to become unused.
Enclosing it in RPC_IFDEBUG avoids a harmless gcc warning.

Without this patch, building at91_dt_defconfig results in:

net/sunrpc/svc.c: In function 'svc_printk':
net/sunrpc/svc.c:1051:7: warning: unused variable 'buf' [-Wunused-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: "J. Bruce Fields" <bfields@redhat.com>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: linux-nfs at vger.kernel.org
Cc: netdev at vger.kernel.org

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index dbf12ac..9485e66 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1047,7 +1047,7 @@ void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
-	char 	buf[RPC_MAX_ADDRBUFLEN];
+	RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 
 	va_start(args, fmt);
 
