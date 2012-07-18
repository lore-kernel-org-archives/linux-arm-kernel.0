From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Jul 2012 16:34:57 +0200
Subject: Linux ARM with XZ compression issue
Message-ID: <201207181634.58089.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm seeing the following issue when building arm linux kernel compressed with XZ 
compression:

  XZKERN  arch/arm/boot/compressed/piggy.xzkern
  CC      arch/arm/boot/compressed/decompress.o
In file included from include/linux/kernel.h:23:0,
                 from 
arch/arm/boot/compressed/../../../../lib/xz/xz_private.h:15,
                 from 
arch/arm/boot/compressed/../../../../lib/decompress_unxz.c:145,
                 from arch/arm/boot/compressed/decompress.c:50:
include/linux/dynamic_debug.h: In function ?ddebug_dyndbg_module_param_cb?:
include/linux/dynamic_debug.h:111:2: error: implicit declaration of function 
?strstr? [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[2]: *** [arch/arm/boot/compressed/decompress.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [arch/arm/boot/compressed/vmlinux] Error 2
make: *** [uImage] Error 2

This is because ARM doesn't implement strstr() in the decompressor phase. Newly 
added strstr() in include/linux/dynamic_debug.h triggers the issue:

b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 108) static inline int 
ddebug_dyndbg_module_param_cb(char *param, char *val,
b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 109)                                                
const char *modname)
b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 110) {
b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 111)        if 
(strstr(param, "dyndbg")) {
516cf1be (Jim Cromie      2012-05-01 05:23:12 -0600 112)                /* avoid 
pr_warn(), which wants pr_fmt() fully defined */
516cf1be (Jim Cromie      2012-05-01 05:23:12 -0600 113)                
printk(KERN_WARNING "dyndbg param is supported only in "
b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 114)                        
"CONFIG_DYNAMIC_DEBUG builds\n");
b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 115)                return 
0; /* allow and ignore */
b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 116)        }
b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 117)        return -EINVAL;
b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 118) }

What do you suggest please? Implement strstr() for ARM into 
arch/arm/kernel/compressed/string.c maybe? I checked into the GLIBC strstr() 
implementation, though that seems quite complex for this purpose.

Best regards,
Marek Vasut
