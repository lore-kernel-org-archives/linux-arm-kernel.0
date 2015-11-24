From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Nov 2015 10:38:14 +0100
Subject: [PATCH v4 3/3] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <20151124093438.GA31343@rric.localdomain>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
 <20151124093438.GA31343@rric.localdomain>
Message-ID: <CAKv+Gu-5NwLmLC1=QW+90+z8U6tRG7nTrBCyKRSEBVfYVMcReg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2015 at 10:34, Robert Richter
<robert.richter@caviumnetworks.com> wrote:
> Ard,
>
> On 08.10.15 20:02:04, Ard Biesheuvel wrote:
>> +quiet_cmd_stubcopy = STUBCPY $@
>> +      cmd_stubcopy = if $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@; then   \
>> +                  $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y)        \
>> +                  && (echo >&2 "$@: absolute symbol references not allowed in the EFI stub"; \
>> +                      rm -f $@; /bin/false); else /bin/false; fi
>
> This one is causing some more build errors for my setup. Any hint how
> to fix that?
>

Did you remove -R .debug* from the STUBCOPY_FLAGS-$(CONFIG_ARM64) line?

The problem here is that
a) .debug contains absolute relocations, which is harmless by itself
since they are not used by the program itself, but
b) the .debug sections also contain references to the ksymtab and
kcrctab sections, which should be removed, and removing those and
keeping .debug* sadly doesn't work.

-- 
Ard.


>
>   STUBCPY drivers/firmware/efi/libstub/arm-stub.stub.o
> 0000000000000006 R_AARCH64_ABS32   .debug_abbrev
> 000000000000000c R_AARCH64_ABS32   .debug_str+0x0000000000000890
> 0000000000000011 R_AARCH64_ABS32   .debug_str+0x0000000000004ecd
> 0000000000000015 R_AARCH64_ABS32   .debug_str+0x0000000000000bb1
> 0000000000000019 R_AARCH64_ABS64   .init.text
> 0000000000000021 R_AARCH64_ABS64   .init.text+0x00000000000008cc
> 0000000000000029 R_AARCH64_ABS32   .debug_line
> 0000000000000030 R_AARCH64_ABS32   .debug_str+0x00000000000000eb
> 0000000000000047 R_AARCH64_ABS32   .debug_str+0x0000000000003ca8
> 0000000000000059 R_AARCH64_ABS32   .debug_str+0x0000000000004798
> 0000000000000060 R_AARCH64_ABS32   .debug_str+0x0000000000005008
> ...
> 000000000000a4bb R_AARCH64_ABS32   .debug_str+0x0000000000004a75
> 000000000000a4da R_AARCH64_ABS32   .debug_str+0x00000000000029ee
> 000000000000a4f7 R_AARCH64_ABS32   .debug_str+0x0000000000001d95
> 000000000000a519 R_AARCH64_ABS32   .debug_str+0x0000000000000773
> 0000000000000006 R_AARCH64_ABS32   .debug_info
> 0000000000000010 R_AARCH64_ABS64   .init.text
> 0000000000000623 R_AARCH64_ABS64   .init.text
> 0000000000000014 R_AARCH64_ABS32   .debug_frame
> 0000000000000018 R_AARCH64_ABS64   .init.text
> 000000000000002c R_AARCH64_ABS32   .debug_frame
> 0000000000000030 R_AARCH64_ABS64   .init.text+0x0000000000000018
> 0000000000000074 R_AARCH64_ABS32   .debug_frame
> 0000000000000078 R_AARCH64_ABS64   .init.text+0x0000000000000140
> 000000000000009c R_AARCH64_ABS32   .debug_frame
> 00000000000000a0 R_AARCH64_ABS64   .init.text+0x0000000000000158
> 00000000000000c4 R_AARCH64_ABS32   .debug_frame
> 00000000000000c8 R_AARCH64_ABS64   .init.text+0x0000000000000170
> 000000000000012c R_AARCH64_ABS32   .debug_frame
> 0000000000000130 R_AARCH64_ABS64   .init.text+0x0000000000000390
> 0000000000000154 R_AARCH64_ABS32   .debug_frame
> 0000000000000158 R_AARCH64_ABS64   .init.text+0x00000000000003b0
> 00000000000001a4 R_AARCH64_ABS32   .debug_frame
> 00000000000001a8 R_AARCH64_ABS64   .init.text+0x0000000000000780
> drivers/firmware/efi/libstub/arm-stub.stub.o: absolute symbol references not allowed in the EFI stub
