From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 15:06:47 +0200
Subject: [PATCH] binfmt_misc: work around gcc-4.9 warning
Message-ID: <36592637.GQ9Dnm0IKp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-4.9 on ARM gives us a mysterious warning about the binfmt_misc
parse_command function:

fs/binfmt_misc.c: In function 'parse_command.part.3':
fs/binfmt_misc.c:405:7: warning: array subscript is above array bounds [-Warray-bounds]

I've managed to trace this back to the ARM implementation of memset,
which is called from copy_from_user in case of a fault and which does

 #define memset(p,v,n)                                                  \
        ({                                                              \
                void *__p = (p); size_t __n = n;                        \
                if ((__n) != 0) {                                       \
                        if (__builtin_constant_p((v)) && (v) == 0)      \
                                __memzero((__p),(__n));                 \
                        else                                            \
                                memset((__p),(v),(__n));                \
                }                                                       \
                (__p);                                                  \
        })

Apparently gcc gets confused by the check for "size != 0" and believes
that the size might be zero when it gets to the line that does
"if (s[count-1] == '\n')", so it would access data outside of the
array.

gcc is clearly wrong here, since this condition was already checked
earlier in the function and the 'size' value can not change in the
meantime.

Fortunately, we can work around it and get rid of the warning by
rearranging the function to check for zero size after doing the
copy_from_user. It is still safe to pass a zero size into
copy_from_user, so it does not cause any side effects.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index b60500300dd7..1fc2b028d504 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -396,12 +396,12 @@ static int parse_command(const char __user *buffer, size_t count)
 {
 	char s[4];
 
-	if (!count)
-		return 0;
 	if (count > 3)
 		return -EINVAL;
 	if (copy_from_user(s, buffer, count))
 		return -EFAULT;
+	if (!count)
+		return 0;
 	if (s[count-1] == '\n')
 		count--;
 	if (count == 1 && s[0] == '0')
