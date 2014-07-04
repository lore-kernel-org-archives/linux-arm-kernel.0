From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Jul 2014 17:51:31 +0200
Subject: [PATCH v2 2/2] efi/arm64: preserve FP/SIMD registers on UEFI
 runtime services calls
In-Reply-To: <20140704154522.GJ16404@arm.com>
References: <1403777346-28629-1-git-send-email-ard.biesheuvel@linaro.org>
 <1403777346-28629-3-git-send-email-ard.biesheuvel@linaro.org>
 <20140704154522.GJ16404@arm.com>
Message-ID: <CAKv+Gu947rsPRbWEY=TDBkkvoNanu-P+6Eej7Z3_crysx96F=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2014 17:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Jun 26, 2014 at 11:09:06AM +0100, Ard Biesheuvel wrote:
>> According to the UEFI spec section 2.3.6.4, the use of FP/SIMD instructions is
>> allowed, and should adhere to the AAPCS64 calling convention, which states that
>> 'only the bottom 64 bits of each value stored in registers v8-v15 need to be
>> preserved' (section 5.1.2).
>>
>> This applies equally to UEFI Runtime Services called by the kernel, so make sure
>> the FP/SIMD register file is preserved in this case.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> While the code looks fine, I think there is a mismatch between what the
> subject says and what the patch does (enabling EFI_RUNTIME_WRAPPERS).
>

Not entirely. In order to be able to insert calls to
kernel_neon_begin()/end() into the runtime services calls, we need
a) to supply definitions for efi_call_virt() and __efi_call_virt()
that contain those calls to kernel_neon_begin()/end()
b) to enable runtime wrappers (which is what uses those definitions)

Would you prefer those to be split in 2 patches?

--
Ard.
