From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 31 May 2016 09:53:57 +0800
Subject: building and using modules on arm64 hikey board
In-Reply-To: <574C8C69.6020501@broadcom.com>
References: <87a3195c-febb-a6c8-a679-272b9f7b59cc@broadcom.com>
 <0240F9F0-0146-4DCC-B512-195415B29B34@linaro.org>
 <574C8C69.6020501@broadcom.com>
Message-ID: <20160531095357.3eb6548c@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 May 2016 20:54:33 +0200
Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> On 30-05-16 13:30, Ard Biesheuvel wrote:
> > This is likely caused by the fact that the Android AArch64 toolchain uses -fpic by default. Could you try adding -fno-pic to the CFLAGS?  
> 
> I did only to notice with 'make V=1 ...' that it was already used hence
> showing up in the compile command line twice. To no avail so that ain't
> working.

Per my experience, the default ld in android toolchain is gold, can you plz try
to use ld.bfd instead?

> 
> Regards,
> Arend
> 
> >> On 30 mei 2016, at 12:21, Arend Van Spriel <arend.vanspriel@broadcom.com> wrote:
> >>
> >> I got myself an arm64 HiKey board from LeMaker and build an Android AOSP
> >> image for it (see [1]). For development I would like to use
> >> CONFIG_MODULES. However, when I try to insmod the build module I get:
> >>
> >> [  287.903653] module cfg80211: overflow in relocation type 261 val
> >> ffffffbffc006530
> >>
> >> Looking AArch64 ELF documentation [2], section 4.6.5, it has:
> >> code|name            |operation |overflow check   |
> >> 261 |R_AARCH64_PREL32|S + A - P |-2^31 <= X < 2^32|
> >>
> >> So basically the highest 32 bits should all be one and so ffffffbf is
> >> invalid. From what I could find searching internet it could be an issue
> >> with linker options so I build kernel and modules with V=1. Here the
> >> linker invocation for them:
> >>
> >> + aarch64-linux-android-ld -EL -p --no-undefined -X --build-id -o vmlinux \
> >> -T ./arch/arm64/kernel/vmlinux.lds arch/arm64/kernel/head.o
> >> init/built-in.o \
> >> --start-group usr/built-in.o arch/arm64/kernel/built-in.o
> >> arch/arm64/mm/built-in.o \
> >> arch/arm64/net/built-in.o arch/arm64/kvm/built-in.o
> >> arch/arm64/crypto/built-in.o \
> >> ./drivers/firmware/efi/libstub/lib.a kernel/built-in.o certs/built-in.o
> >> mm/built-in.o \
> >> fs/built-in.o ipc/built-in.o security/built-in.o crypto/built-in.o
> >> block/built-in.o \
> >> arch/arm64/lib/lib.a lib/lib.a arch/arm64/lib/built-in.o lib/built-in.o
> >> drivers/built-in.o \
> >> sound/built-in.o firmware/built-in.o net/built-in.o virt/built-in.o
> >> --end-group .tmp_kallsyms2.o
> >>
> >>  aarch64-linux-android-ld -EL -r  -T ./scripts/module-common.lds
> >> --build-id \
> >>  -o net/wireless/cfg80211.ko net/wireless/cfg80211.o
> >> net/wireless/cfg80211.mod.o
> >>
> >> Attached are vmlinux.lds and module-common.lds. I also tried taking
> >> upstream arch/arm64/kernel/module.lds in hikey-linaro tree. If someone
> >> can give a hint or educated guess at what to try it would be appreciated.
> >>
> >> Regards,
> >> Arend
> >>
> >> [1] https://source.android.com/source/devices.html#building-kernel
> >> [2]
> >> http://infocenter.arm.com/help/topic/com.arm.doc.ihi0056b/IHI0056B_aaelf64.pdf
> >> <module-common.lds>
> >> <vmlinux.lds>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
