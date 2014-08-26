From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 26 Aug 2014 18:19:35 +0200
Subject: [PATCH 1/9] arm64: Fix efi kernel entry
In-Reply-To: <20140826155505.GG16482@arm.com>
References: <cover.1408736066.git.geoff@infradead.org>
 <873e73a998c198de69f6f01f92176be2b613c500.1408736066.git.geoff@infradead.org>
 <20140826155505.GG16482@arm.com>
Message-ID: <CAKv+Gu8V1xXtGZm5ae+NiFGDuNr20TUBhL=vCgQ6J2S5CQJakg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 August 2014 17:55, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Aug 22, 2014 at 08:49:15PM +0100, Geoff Levand wrote:
>> The recent addition of EFI support has changed the way the arm64 kernel
>> image is entered based on whether or not CONFIG_EFI is defined.  To support
>> this conditional entry point add a new global symbol start to head.S that
>> marks the entry, and change the the linker script ENTRY() command to define
>> start as the kernel entry.
>
> I don't yet understand what the problem is. The _text symbol is
> currently defined in vmlinux.lds.S to be the beginning of the .head.text
> section. Whether we have CONFIG_EFI or not, the entry point is the same.
>

First of all, the 'add x13, x18, #0x16' was carefully chosen to be
both a "MZ" prefix and an executable instruction without any harmful
side effects. So currently, the EFI stub jumps to that add
instruction, and not to the 'b stext' that comes after. There is an
issue with that, which I have already proposed a patch for (arm64/efi:
efistub: jump to 'stext' directly, not through the header), but this
is related to the guarantees the UEFI spec gives about where the
header gets loaded (if at all).

However, going back to your patch, setting ENTRY() only affects the
vmlinux ELF image, and this information gets stripped when creating
the binary. Do you need the entry point to be set so you can load
vmlinux using the debugger, perhaps? In that case, did you have any
problems branching to the add instruction? If so, I would like to know
about it.

-- 
Ard.
