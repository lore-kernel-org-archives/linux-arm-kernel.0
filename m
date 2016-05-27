From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 27 May 2016 12:23:11 +0900
Subject: [PATCH v2] ARM: avoid duplicated "Kernel: arch/arm/boot/*Image is
 ready" log
In-Reply-To: <1459736970-21876-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459736970-21876-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNATwQn5v_2=-Z++awyOXcHuJkZ8Oxs+f3XtKOksnYwoZTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

Assuming no objection to this patch,
I will put it into Russell's patch tracker after v4.7-rc1 is out.



2016-04-04 11:29 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> generate invalid images") fixed bad image generation in case of
> parallel building, but as a side effect, Kbuild now descends into
> arch/arm/boot/ again and again, duplicating the log messages.  It is
> clumsy, so let's display the same message only once.
>
> I moved the log rules from arch/arm/boot/Makefile to arch/arm/Makefile
> rather than completely deleting them, because *Image are the final
> targets that users are interested in.
>
> Without this commit, the log of incremental build is like follows:
>
> $ make ARCH=arm UIMAGE_LOADADDR=0x80208000 uImage
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CHK     include/generated/bounds.h
>   CHK     include/generated/timeconst.h
>   CHK     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
> <stdin>:1310:2: warning: #warning syscall preadv2 not implemented [-Wcpp]
> <stdin>:1313:2: warning: #warning syscall pwritev2 not implemented [-Wcpp]
>   CHK     include/generated/compile.h
>   Kernel: arch/arm/boot/Image is ready
>   Kernel: arch/arm/boot/Image is ready
>   Kernel: arch/arm/boot/zImage is ready
>   Kernel: arch/arm/boot/Image is ready
>   Kernel: arch/arm/boot/zImage is ready
>   Image arch/arm/boot/uImage is ready
>
> With this commit:
>
> $ make ARCH=arm UIMAGE_LOADADDR=0x80208000 uImage
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CHK     include/generated/bounds.h
>   CHK     include/generated/timeconst.h
>   CHK     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
> <stdin>:1310:2: warning: #warning syscall preadv2 not implemented [-Wcpp]
> <stdin>:1313:2: warning: #warning syscall pwritev2 not implemented [-Wcpp]
>   CHK     include/generated/compile.h
>   Kernel: Image is ready
>   Kernel: zImage is ready
>   Kernel: uImage is ready
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
