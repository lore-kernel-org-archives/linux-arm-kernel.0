From: marex@denx.de (Marek Vasut)
Date: Thu, 19 Jul 2012 00:24:50 +0200
Subject: Linux ARM with XZ compression issue
In-Reply-To: <CAJfuBxxKD_sF3DXZ8bUbSKcvxJY8ngXbHQmp0FBpV-Qytsw5XQ@mail.gmail.com>
References: <201207181634.58089.marex@denx.de>
 <CAJfuBxxKD_sF3DXZ8bUbSKcvxJY8ngXbHQmp0FBpV-Qytsw5XQ@mail.gmail.com>
Message-ID: <201207190024.50846.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jim Cromie,

> hi Marek,
> 
> Surprising problem - is strstr the only one missing ?

I think so.

> Its only used in the stub fn, so you could cheat and
> just return 0, or warn less discriminately and return 0.
> Obviously, that wouldnt be acceptable for mainline.

Correct, so I'm looking for proper solution.

> What happens if you build with compression other than XZ ?

LZMA is good, GZ as well.

> is it specific to XZ as you said, or a more general problem ?

Specific to XZ.

> On Wed, Jul 18, 2012 at 8:34 AM, Marek Vasut <marex@denx.de> wrote:
> > Hello,
> > 
> > I'm seeing the following issue when building arm linux kernel compressed
> > with XZ
> > 
> > compression:
> >   XZKERN  arch/arm/boot/compressed/piggy.xzkern
> >   CC      arch/arm/boot/compressed/decompress.o
> > 
> > In file included from include/linux/kernel.h:23:0,
> > 
> >                  from
> > 
> > arch/arm/boot/compressed/../../../../lib/xz/xz_private.h:15,
> > 
> >                  from
> > 
> > arch/arm/boot/compressed/../../../../lib/decompress_unxz.c:145,
> > 
> >                  from arch/arm/boot/compressed/decompress.c:50:
> > include/linux/dynamic_debug.h: In function
> > ?ddebug_dyndbg_module_param_cb?: include/linux/dynamic_debug.h:111:2:
> > error: implicit declaration of function ?strstr?
> > [-Werror=implicit-function-declaration]
> > cc1: some warnings being treated as errors
> > make[2]: *** [arch/arm/boot/compressed/decompress.o] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [arch/arm/boot/compressed/vmlinux] Error 2
> > make: *** [uImage] Error 2
> > 
> > This is because ARM doesn't implement strstr() in the decompressor phase.
> > Newly added strstr() in include/linux/dynamic_debug.h triggers the
> > issue:
> > 
> > b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 108) static inline
> > int ddebug_dyndbg_module_param_cb(char *param, char *val,
> > b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 109)
> > const char *modname)
> > b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 110) {
> > b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 111)        if
> > (strstr(param, "dyndbg")) {
> > 516cf1be (Jim Cromie      2012-05-01 05:23:12 -0600 112)               
> > /* avoid pr_warn(), which wants pr_fmt() fully defined */
> > 516cf1be (Jim Cromie      2012-05-01 05:23:12 -0600 113)
> > printk(KERN_WARNING "dyndbg param is supported only in "
> > b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 114)
> > "CONFIG_DYNAMIC_DEBUG builds\n");
> > b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 115)               
> > return 0; /* allow and ignore */
> > b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 116)        }
> > b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 117)        return
> > -EINVAL; b48420c1 (Jim Cromie      2012-04-27 14:30:35 -0600 118) }
> > 
> > What do you suggest please? Implement strstr() for ARM into
> > arch/arm/kernel/compressed/string.c maybe? I checked into the GLIBC
> > strstr() implementation, though that seems quite complex for this
> > purpose.
> > 
> > Best regards,
> > Marek Vasut

Best regards,
Marek Vasut
