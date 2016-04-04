From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon, 4 Apr 2016 10:32:37 +0200
Subject: [PATCH v8] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <CAKv+Gu-BHhf=aQ6ZP3J=q8T9FRtq-hfzTNvdJ3=HgMt=hVP8nQ@mail.gmail.com>
References: <1459237458-12352-1-git-send-email-fu.wei@linaro.org>
 <CAKv+Gu-BHhf=aQ6ZP3J=q8T9FRtq-hfzTNvdJ3=HgMt=hVP8nQ@mail.gmail.com>
Message-ID: <570226A5.4000304@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.03.2016 09:05, Ard Biesheuvel wrote:
> On 29 March 2016 at 09:44,  <fu.wei@linaro.org> wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> This commit provides APEI arch-specific bits for aarch64
>>
>> Meanwhile,
>> (1)add a new subfunction "hest_ia32_init" for
>> "acpi_disable_cmcff" which is used by IA-32 Architecture
>> Corrected Machine Check (CMC).
>> (2)move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
>> a generic place.
>> (3)select EFI when ACPI_APEI is set on ARM64,
>> because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.
>
> I think selecting 'EFI' is not the right approach here, especially
> since EFI is implied by ACPI on that architecture. But selecting a
> user configurable option like this is typically not recommended. Why
> doesn't ACPI_APEI depend on ACPI?

It does, ACPI_APEI is subsection of the main ACPI menu option, but I 
don't see that ACPI implies EFI in Kconfig.

Also, I agree with Ard, EFI should not be selected conditionally for 
ARM64 for ACPI_APEI.

We need EFI only for ARM64 so how about:
+       select HAVE_ACPI_APEI if (ACPI && EFI)
in arch/arm64/Kconfig and leave ACPI_APEI as is?

Regards,
Tomasz
