From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 25 Jun 2014 23:26:21 +0200
Subject: [RFC PATCH 4/4] efi: efistub: convert into static library
In-Reply-To: <20140625203424.GC15494@console-pimps.org>
References: <1402931688-23597-1-git-send-email-ard.biesheuvel@linaro.org>
 <1402931688-23597-4-git-send-email-ard.biesheuvel@linaro.org>
 <20140625203424.GC15494@console-pimps.org>
Message-ID: <CAKv+Gu9P=4WpWhnC+Jav_0O6ns6tgYTJVigUWEw7rw5joZt0LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Matt,

> On 25 jun. 2014, at 22:34, Matt Fleming <matt@console-pimps.org> wrote:
>
>> On Mon, 16 Jun, at 05:14:48PM, Ard Biesheuvel wrote:
>> This patch changes both x86 and arm64 efistub implementations from #including
>> shared .c files under drivers/firmware/efi to building the shared code as a
>> static library.
>>
>> The x86 code uses a stub built into the boot executable which uncompresses the
>> kernel at boot time. In this case, the library is linked into the decompressor.
>>
>> In the arm64 case, the stub is part of the kernel proper so the library is
>> linked into the kernel proper as well.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Sorry for the delay in reviewing this.
>
> Conceptually, this is a nice cleanup. Unfortunately, I'm seeing the
> following build error,
>
> drivers/firmware/efi/libstub/lib.a(efi-stub-helper.o): In function `efi_printk':
> efi-stub-helper.c:(.text+0x1): undefined reference to `__fentry__'
> drivers/firmware/efi/libstub/lib.a(efi-stub-helper.o): In function `efi_get_memory_map':
> efi-stub-helper.c:(.text+0x7f): undefined reference to `__fentry__'
> drivers/firmware/efi/libstub/lib.a(efi-stub-helper.o): In function `efi_high_alloc':
> efi-stub-helper.c:(.text+0x1ea): undefined reference to `__fentry__'
> drivers/firmware/efi/libstub/lib.a(efi-stub-helper.o): In function `efi_low_alloc':
> efi-stub-helper.c:(.text+0x3dd): undefined reference to `__fentry__'
> drivers/firmware/efi/libstub/lib.a(efi-stub-helper.o): In function `efi_free':
> efi-stub-helper.c:(.text+0x59f): undefined reference to `__fentry__'
> drivers/firmware/efi/libstub/lib.a(efi-stub-helper.o):efi-stub-helper.c:(.text+0x5ec): more undefined references to `__fentry__' follow
> drivers/firmware/efi/libstub/lib.a(efi-stub-helper.o):(.data+0x260): undefined reference to `__gcov_merge_add'
> drivers/firmware/efi/libstub/lib.a(efi-stub-helper.o): In function `_GLOBAL__sub_I_65535_0_efi_printk':
> efi-stub-helper.c:(.text.startup+0xc): undefined reference to `__gcov_init'
> make[3]: *** [arch/x86/boot/compressed/vmlinux] Error 1
> make[2]: *** [arch/x86/boot/compressed/vmlinux] Error 2
> make[1]: *** [bzImage] Error 2
>
> This is because we use different CFLAGS for the EFI boot stub on x86.
> Take a look at arch/x86/boot/compressed/Makefile to see what I mean.
>

Meh, I did try building it for x86, but apparently my .config does not
have ftrace etc enabled.

> What I'd suggest is that you simply update the efi-stub-helper.c
> #include path in the x86 EFI boot stub in this series, and only roll out
> the awesome new libstub for arm64. I'll take care of doing the necessary
> CFLAG munging for x86 when I have some spare time. Could you do a v2?
>
> That is, unless you really want to make it work for x86 ;-)
>

If this is primarily about disabling instrumentation stuff, then we
will also be needing it for ARM anyway, and I don't think it will hurt
to just disable it for all archs (including arm64). So I am happy to
do a proper v2 that covers x86 as well.

-- 
Ard.
