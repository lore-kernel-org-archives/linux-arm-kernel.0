From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 14 Jul 2012 18:43:05 +0200
Subject: [PATCH 3/6] arch/arm/mach-netx/xc.c: ensure a consistent return value
 in error case
In-Reply-To: <1342284188-19176-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1342284188-19176-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1342284188-19176-4-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Typically, the return value desired for the failure of a function with an
integer return value is a negative integer.  In these cases, the return
value is sometimes a negative integer and sometimes 0, due to a subsequent
initialization of the return variable within the loop.

Resetting ret to 0 at the end of the function is not necessary because the
return value of xc_patch is either 0 or a negative integer.

A simplified version of the semantic match that finds this problem is:
(http://coccinelle.lip6.fr/)

//<smpl>
@r exists@
identifier ret;
position p;
constant C;
expression e1,e3,e4;
statement S;
@@

ret = -C
... when != ret = e3
    when any
if at p (...) S
... when any
if (\(ret != 0\|ret < 0\|ret > 0\) || ...) { ... return ...; }
... when != ret = e3
    when any
*if at p (...)
{
  ... when != ret = e4
  return ret;
}
//</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
If relying on the return value of xc_patch to set ret to 0 is considered
too fragile this part of the patch could be dropped.

 arch/arm/mach-netx/xc.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-netx/xc.c b/arch/arm/mach-netx/xc.c
index e4cfb7e..18a98e0 100644
--- a/arch/arm/mach-netx/xc.c
+++ b/arch/arm/mach-netx/xc.c
@@ -149,16 +149,16 @@ int xc_request_firmware(struct xc *x)
 	x->type = head->type;
 	x->version = head->version;
 
-	ret = -EINVAL;
-
 	for (i = 0; i < 3; i++) {
 		src = fw->data + head->fw_desc[i].ofs;
 		dst = *(unsigned int *)src;
 		src += sizeof (unsigned int);
 		size = head->fw_desc[i].size - sizeof (unsigned int);
 
-		if (xc_check_ptr(x, dst, size))
+		if (xc_check_ptr(x, dst, size)) {
+			ret = -EINVAL;
 			goto exit_release_firmware;
+		}
 
 		memcpy((void *)io_p2v(dst), src, size);
 
@@ -169,8 +169,6 @@ int xc_request_firmware(struct xc *x)
 			goto exit_release_firmware;
 	}
 
-	ret = 0;
-
       exit_release_firmware:
 	release_firmware(fw);
 
