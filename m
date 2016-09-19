From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 19 Sep 2016 17:10:27 +0100
Subject: [PATCH v26 0/7] arm64: add kdump support
In-Reply-To: <57E00CDC.70403@arm.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <57DC1812.6040906@arm.com>
 <CAKv+Gu_UvFnPtFHggaO6Z_ePuArdchEK1qYWPkkwpcgLus3Epw@mail.gmail.com>
 <57E00CDC.70403@arm.com>
Message-ID: <CAKv+Gu-pDS8C9uAkWq3mbuT2TZ9G6h-XTEd75fqaZv74kQ4WuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 September 2016 at 17:05, James Morse <james.morse@arm.com> wrote:
> On 16/09/16 21:17, Ard Biesheuvel wrote:
>> On 16 September 2016 at 17:04, James Morse <james.morse@arm.com> wrote:
>>> Mark, Ard, how does/will reserved-memory work on an APCI only system?
>>
>> It works by accident, at the moment. We used to ignore both
>> /memreserve/s and the /reserved-memory node, but due to some unrelated
>> refactoring, we ended up honouring the reserved-memory node when
>> booting via UEFI
>
> Okay, so kdump probably shouldn't rely on this behaviour...
>

No, but I would still like to keep /reserved-memory node support for
dynamic ranges, since they are guaranteed not to contain anything
'magic' left behind by the firmware. So if we keep /that/, keeping
static allocation support (with validation, as I proposed in the
series I quoted) is only a small step.

-- 
Ard.

> For an acpi-only system, we could get reserve_crashkernel() to copy the uefi
> memory map into the reserved region, changing the region types for existing
> kernel memory to EfiReservedMemoryType (for example) and fixing up the reserved
> region boundaries.
>
> This second memory map could then be added alongside the real one in the
> DT/chosen, and used in preference the second time we go through uefi_init() in
> the crash kernel.
>
> kexec-tools would still need to keep the '/reserved-memory' node for non-uefi
> systems.
>
> Doing this doesn't depend on userspace, and means the uefi memory map is still
> the one and only true source of memory layout information. If fixing it like
> this is valid I don't think it should block kdump.
>
> ... I will think about this some more before trying to put it together.
>
>
>
> Thanks,
>
> James
