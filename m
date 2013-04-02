From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 02 Apr 2013 12:19:19 +0100
Subject: [BUG] mod/file2alias: build error in devicetable-offsets.c
 [was: asm/types.h Header file wont get generated while building uImage ?]
In-Reply-To: <m2ip48d62f.fsf@igel.home>
References: <CA+V-a8vYsBLVH-3Bm35Sv9K9ZMTcMB4_P_V3kBjyuEKDozPi5w@mail.gmail.com>
 <1363949290.3528.37.camel@linaro1.home> <m2ip48d62f.fsf@igel.home>
Message-ID: <1364901559.3650.12.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-03-30 at 20:46 +0100, Andreas Schwab wrote:
> "Jon Medhurst (Tixy)" <tixy@linaro.org> writes:
> 
> > For builds which succeed I see this order:
> >
> >   WRAP    arch/arm/include/generated/asm/types.h
> >   [...]
> >   GEN     include/generated/asm-offsets.h
> >
> > and for those which fail:
> >
> >   CC      scripts/mod/devicetable-offsets.s
> >   In file included from include/linux/types.h:5:0,
> >                    from include/linux/mod_devicetable.h:11,
> >                    from scripts/mod/devicetable-offsets.c:2:
> >   include/uapi/linux/types.h:4:23: fatal error: asm/types.h: No such file or directory
> >   [...]
> >   WRAP    arch/arm/include/generated/asm/types.h
> 
> Does that help?

It's rather difficult to be certain as I've only seen it in our daily
automated builds but I forced the failure on my local PC by adding
'sleep 2' to the rules in scripts/Makefile.asm-generic and doing a build
with -j4. Then after applying the below fix I couldn't reproduce the
failure. I'll add the fix to the trees our automated builds use and
report if I see any other issues but I don't anticipate any.

Thanks for looking at this.


> diff --git a/Makefile b/Makefile
> index a5f3203..2a484db 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -512,7 +512,8 @@ ifeq ($(KBUILD_EXTMOD),)
>  # Carefully list dependencies so we do not try to build scripts twice
>  # in parallel
>  PHONY += scripts
> -scripts: scripts_basic include/config/auto.conf include/config/tristate.conf
> +scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
> +	 asm-generic
>  	$(Q)$(MAKE) $(build)=$(@)
>  
>  # Objects we will link into vmlinux / subdirs we need to visit
> 
> Andreas.
> 

-- 
Tixy
