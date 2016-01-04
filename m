From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Jan 2016 20:28:52 +0100
Subject: [PATCH 6/6] arm64: switch to relative exception tables
In-Reply-To: <568AC64A.4090601@zytor.com>
References: <1451837157-447-1-git-send-email-ard.biesheuvel@linaro.org>
 <1451837157-447-7-git-send-email-ard.biesheuvel@linaro.org>
 <20160104144643.GE1616@arm.com> <568AB65A.8030901@zytor.com>
 <3908561D78D1C84285E8C5FCA982C28F39FA127B@ORSMSX114.amr.corp.intel.com>
 <568AC64A.4090601@zytor.com>
Message-ID: <CAKv+Gu-n70=Kdf2NtygzYxEURO+Dnk1cmMX6D3gmXQ1E5-PHUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2016 at 20:21, H. Peter Anvin <hpa@zytor.com> wrote:
> On 01/04/2016 10:20 AM, Luck, Tony wrote:
>>> May I humbly ask why the [Finnish] you don't use the equivalent of the
>>> x86 _ASM_EXTABLE() macro?  In fact, why don't we make that one generic, too?
>>
>> I'm messing with that right now (with help from Andy Lutomirski and Boris) to
>> add different classes of exception table (so I can tag some instructions as being
>> suitable for fixup from the machine check handler).  So it might not be generic
>> for much longer.
>>
>> http://marc.info/?l=linux-kernel&m=145187079504846&w=2
>>
>
> I suspect that means we will also need to go back to arch-specific
> sorting for x86.
>

AFAICT, Tony's patches are not incompatible with mine. The fixup
address is offset with a large constant, but this does not affect the
sort order (since that is based on the other member), and the swap
operation that adds/subtracts the delta should not care about the
class bits. (I don't see any changes to sort_extable() in Tony's
patch)

@Tony: any comments? And do you have any objections to the ia64 patch
in this series?

I agree that it makes sense to define a macro to emit the extable
entries in this patch, but I am not sure how that extrapolates to the
other architectures, and testing those is going to be cumbersome for
me, so I'd prefer to keep that a local change for arm64 for now.

Thanks,
Ard.
