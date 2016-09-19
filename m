From: james.morse@arm.com (James Morse)
Date: Mon, 19 Sep 2016 17:05:48 +0100
Subject: [PATCH v26 0/7] arm64: add kdump support
In-Reply-To: <CAKv+Gu_UvFnPtFHggaO6Z_ePuArdchEK1qYWPkkwpcgLus3Epw@mail.gmail.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <57DC1812.6040906@arm.com>
 <CAKv+Gu_UvFnPtFHggaO6Z_ePuArdchEK1qYWPkkwpcgLus3Epw@mail.gmail.com>
Message-ID: <57E00CDC.70403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/16 21:17, Ard Biesheuvel wrote:
> On 16 September 2016 at 17:04, James Morse <james.morse@arm.com> wrote:
>> Mark, Ard, how does/will reserved-memory work on an APCI only system?
> 
> It works by accident, at the moment. We used to ignore both
> /memreserve/s and the /reserved-memory node, but due to some unrelated
> refactoring, we ended up honouring the reserved-memory node when
> booting via UEFI

Okay, so kdump probably shouldn't rely on this behaviour...

For an acpi-only system, we could get reserve_crashkernel() to copy the uefi
memory map into the reserved region, changing the region types for existing
kernel memory to EfiReservedMemoryType (for example) and fixing up the reserved
region boundaries.

This second memory map could then be added alongside the real one in the
DT/chosen, and used in preference the second time we go through uefi_init() in
the crash kernel.

kexec-tools would still need to keep the '/reserved-memory' node for non-uefi
systems.

Doing this doesn't depend on userspace, and means the uefi memory map is still
the one and only true source of memory layout information. If fixing it like
this is valid I don't think it should block kdump.

... I will think about this some more before trying to put it together.



Thanks,

James
