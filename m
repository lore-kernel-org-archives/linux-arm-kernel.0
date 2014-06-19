From: greg@kroah.com (Greg KH)
Date: Thu, 19 Jun 2014 12:10:51 -0700
Subject: lustre virtual block device doesn't build w/
 CONFIG_ARM64_64K_PAGES=y
In-Reply-To: <20140619183321.GA23200@fluid.dannf>
References: <20140619183321.GA23200@fluid.dannf>
Message-ID: <20140619191051.GA26573@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 12:33:21PM -0600, dann frazier wrote:
> With current git, lustre fails to build with CONFIG_ARM64_64K_PAGES=y
> and CONFIG_LUSTRE_LLITE_LLOOP=m:
> 
> make -f scripts/Makefile.build obj=drivers/staging/lustre/lustre/llite
>   gcc -Wp,-MD,drivers/staging/lustre/lustre/llite/.lloop.o.d  -nostdinc -isystem /usr/lib/gcc/aarch64-linux-gnu/4.8/include -I./arch/arm64/include -Iarch/arm64/include/generated  -Iinclude -I./arch/arm64/include/uapi -Iarch/arm64/include/generated/uapi -I./include/uapi -Iinclude/generated/uapi -include ./include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -mgeneral-regs-only -fno-delete-null-pointer-checks -O2 -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Idrivers/staging/lustre/include/ -Idrivers/staging/lustre/lustre/llite/../include  -DMODULE  -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(lloop)"  -D"KBUILD_MODNAME=KBUILD_STR(llite_lloop)" -c -o drivers/staging/lustre/lustre/llite/.tmp_lloop.o drivers/staging/lustre/lustre/llite/lloop.c
> drivers/staging/lustre/lustre/llite/lloop.c: In function ?loop_set_fd?:
> drivers/staging/lustre/lustre/llite/lloop.c:523:78: error: duplicate case value
>   CLASSERT(PAGE_CACHE_SIZE < (1 << (sizeof(unsigned short) * 8)));
>                                                                               ^
> drivers/staging/lustre/lustre/llite/lloop.c:523:18: error: previously used here
>   CLASSERT(PAGE_CACHE_SIZE < (1 << (sizeof(unsigned short) * 8)));
>                   ^

Looks like lustre can't handle 64K page sizes, so it refuses to build :(

I sugest turning this code off, you really don't want to be running it
anyway...

greg k-h
