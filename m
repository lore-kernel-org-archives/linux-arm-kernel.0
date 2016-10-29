From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 29 Oct 2016 21:36:58 +0200
Subject: [PATCH 04/15] video: fbdev: use permission-specific DEVICE_ATTR
 variants
In-Reply-To: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1477769829-22230-5-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEVICE_ATTR_RW for read-write attributes.  This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@rw@
declarer name DEVICE_ATTR;
identifier x,x_show,x_store;
@@

DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);

@script:ocaml@
x << rw.x;
x_show << rw.x_show;
x_store << rw.x_store;
@@

if not (x^"_show" = x_show && x^"_store" = x_store)
then Coccilib.include_match false

@@
declarer name DEVICE_ATTR_RW;
identifier rw.x,rw.x_show,rw.x_store;
@@

- DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
+ DEVICE_ATTR_RW(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/wm8505fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index e925619..253ffe9 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -182,7 +182,7 @@ static ssize_t contrast_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(contrast, 0644, contrast_show, contrast_store);
+static DEVICE_ATTR_RW(contrast);
 
 static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
 {
