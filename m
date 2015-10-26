From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 26 Oct 2015 17:33:06 -0500
Subject: [PATCH v4 3/3] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <562EA894.8070505@arm.com>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
 <562EA894.8070505@arm.com>
Message-ID: <562EAA22.3010905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2015 05:26 PM, Jeremy Linton wrote:
> On 10/08/2015 02:02 PM, Ard Biesheuvel wrote:
>> Since arm64 does not use a builtin decompressor, the EFI stub is built
>> into the kernel proper. So far, this has been working fine, but actually,
>> since the stub is in fact a PE/COFF relocatable binary that is executed
>> at an unknown offset in the 1:1 mapping provided by the UEFI firmware, we
>> should not be seamlessly sharing code with the kernel proper, which is a
>> position dependent executable linked at a high virtual offset.
>
> This patch appears to be causing a build break
>
>   STUBCPY drivers/firmware/efi/libstub/lib-sort.stub.o
> 0000000000000000 R_AARCH64_ABS64   __efistub___crc_sort
> drivers/firmware/efi/libstub/lib-sort.stub.o: absolute symbol references
> not allowed in the EFI stub
>
> __kcrctab_sort:
>      .xword    __crc_sort
>      .weak    __crc_sort
>      .text
>
>
> Which is the EXPORT_SYMBOL() in sort.c combined with !CONFIG_MODVERSIONS.

	Sorry, I that should be CONFIG_MODVERSIONS..
