From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Jan 2017 15:08:56 +0000
Subject: [PATCH] arm: module: handle negative R_ARM_PREL31 addends
 correctly
In-Reply-To: <20170130123914.GQ27312@n2100.armlinux.org.uk>
References: <1484907663-32322-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170130123914.GQ27312@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu-0J0tVUUDhJ_f1P9n-1Etgk5A6ZTgUokKu7RKOCeaW4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 January 2017 at 12:39, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Fri, Jan 20, 2017 at 10:21:03AM +0000, Ard Biesheuvel wrote:
>> According to the spec 'ELF for the ARM Architecture' (IHI 0044E),
>> addends for R_ARM_PREL31 relocations are 31-bit signed quantities,
>> so we need to sign extend the value to 32 bits before it can be used
>> as an offset in the calculation of the relocated value.
>>
>> We have not been bitten by this because these relocations are usually
>> emitted against the start of a section, which means the addends never
>> assume negative values in practice. But it is a bug nonetheless, so fix
>> it.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> This is something I spotted while looking into adding support for
>> R_ARM_REL32 relocations. Feel free to ignore if it is guaranteed in some
>> way that these relocations can never be emitted with negative addends.
>
> I still think this is a good thing to have, even if we should never
> see them - it avoids updating the relocation with an incorrect value.
> Any relocations we perform should be guaranteed to be correct, or
> we should fail.
>

Agreed.

> Please put it in the patch system, thanks.
>

Actually, I think it may still be incorrect: it seems to me that we
should preserve bit 31 rather than clear it. From the EHABI

"""
Bit 31 of the relocated word does not participate in the relocation
and may be used as data.
"""
(IHI0038B page 13)

and

"""
... The landing pad word contains a prel31 offset to a landing pad,
with bit 31 set if the catch handler catches a reference type and bit
31 clear otherwise. ...
"""
(IHI0038B page 39)

which suggests to me that bit 31 could legally assume either truth
value, and should not be touched by the relocation machinery.
