From: r.baldyga@samsung.com (Robert Baldyga)
Date: Mon, 13 Jul 2015 11:03:50 +0200
Subject: [PATCH v3 1/5] usb: gadget: ffs: call functionfs_unbind() if
 _ffs_func_bind() fails
In-Reply-To: <1436778234-12787-1-git-send-email-r.baldyga@samsung.com>
References: <1436778234-12787-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436778234-12787-2-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function ffs_do_functionfs_bind() calls functionfs_bind() which allocates
usb request and increments refcounts. These things needs to be cleaned
up by if further steps of initialization fail by calling functionfs_unbind().

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Acked-by: Michal Nazarewicz <mina86@mina86.com>
---
 drivers/usb/gadget/function/f_fs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6e7be91..adc6d52 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2897,11 +2897,17 @@ static int ffs_func_bind(struct usb_configuration *c,
 			 struct usb_function *f)
 {
 	struct f_fs_opts *ffs_opts = ffs_do_functionfs_bind(f, c);
+	struct ffs_function *func = ffs_func_from_usb(f);
+	int ret;
 
 	if (IS_ERR(ffs_opts))
 		return PTR_ERR(ffs_opts);
 
-	return _ffs_func_bind(c, f);
+	ret = _ffs_func_bind(c, f);
+	if (ret && !--ffs_opts->refcnt)
+		functionfs_unbind(func->ffs);
+
+	return ret;
 }
 
 
-- 
1.9.1
