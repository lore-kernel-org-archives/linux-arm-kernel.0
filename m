From: adrian.wenl@gmail.com (Lei Wen)
Date: Wed, 26 May 2010 21:42:28 +0800
Subject: [PATCH 01/20] mtd: pxa3xx_nand: refuse the flash definition get
	from platform
In-Reply-To: <4BFCF06E.5010809@compulab.co.il>
References: <AANLkTinVBXhT77Zd-LNpufgJAl7WZdic0oxDFwvNkvJg@mail.gmail.com>
	<4BFA2B5B.4080105@compulab.co.il>
	<AANLkTilLYFVPcel-rE8RbuTWEir4RJOBqmyxirb6Vozn@mail.gmail.com>
	<4BFA5C58.7050109@compulab.co.il>
	<AANLkTimYwQa5aJ2wuuBvPQ6O6hgYKaQcCcb3jwTcgFcD@mail.gmail.com>
	<4BFA7D60.6020703@compulab.co.il>
	<AANLkTil1mq5FBePSexz80DyT80DGqshqyJEi6Pfp0kV7@mail.gmail.com>
	<4BFBA4BA.9020502@compulab.co.il>
	<AANLkTimOGbp6m2v4574ZR-74zbUA-dSAZl3BhlkOBqr3@mail.gmail.com>
	<4BFCF06E.5010809@compulab.co.il>
Message-ID: <AANLkTinaQdD7z2JWrh-LVKbviFsHHDMA4iCXawonlocy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 5:57 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> Lei Wen wrote:
>>
>> On Tue, May 25, 2010 at 6:21 PM, Mike Rapoport <mike@compulab.co.il>
>> wrote:
>
>>> Can you please elaborate what are the attributes that cannot be detected?
>>
>> The attributes comes from two new features that would be included into
>> pxa3xx_nand: BCH support and 8bit per 512bytes ECC.
>> Originally, our pxa3xx_nand only support Hamming ECC way. So no doubt
>> just read the timing register, and just set use ecc bit in NDCR is
>> enough.
>> But for now there is two type of ECC type. For distinguish, we
>> introduce a new register called NDECCCTRL. NDECCCTRL_BCH_EN in the bit
>> 0 of that register control whether use the BCH ECC.
>> You may ask me why not just read from NDECCCTRL to know the ECC type.
>> It is right, but not always to be true. It the last command executed
>> for nand before kernel take control is not read or write operation,
>> the bootloader has no reason to set the NDECCCTRL register. So our
>> kernel also unable to detect whether to use BCH or HAMMING ECC.
>>
>> This two type of ecc has different character, if use hamming ecc for
>> reading while that page is written by BCH, it would instant report of
>> DB error...
>> This is not the worst case., for we may ask the bootloader to always
>> set the NDECCCTRL. (There is no reason to apply ECC when do command
>> except the read and write although)
>>
>> The worst would comes at the supporting of 8bit per 512 bytes ECC. Our
>> BCH engine only support 16bit corroction per 2k data, aka 4bit per
>> 512bytes.
>> If we need to support 8bit per 512bytes feature, which is needed by a
>> lot of newest flash which require such high ecc strength.
>> Then we have to apply the BCH to 1k data instead of 2k. The layout of
>> content on flash would change.
>> Original BCH apply to 2k nand, the layout may like: | 2k data | + | 30
>> bytes ECC |
>> Now after apply BCH to 1k range, the layout would be like: | 1k data |
>> + | 30 bytes ECC| + | 1k data| + |30 bytes ECC|.
>> Even as I said let the bootloader to always set the NDECCCTRL. The
>> kernel would still cannot distinguish the two use case of 4bit per
>> 512bytes and 8bit per 512 bytes ECC strength requirement.
>> For they both use BCH, the only difference could be told on the nand
>> layout, not by register reading.
>>
>> Those two new feature would lead different nand content layout. So if
>> not distinguish properly, nand would not be able to work functional.
>> And obviously, the two features cannot get from register reading, and
>> that is the reason why I suggest drop the feature.
>
> Why not make the ECC type and strength part of the
> pxa3xx_nand_platform_data? This way you can ensure NAND layout consistency
> for particular platform without reduction in the driver robustness.
>

The reason why we need define different ecc type and ecc strength is
for those different kind of ecc strength could give different
performance cost. For data safe consideration, the higher of ecc
strength would be safer. But you must notice that the higher ecc
strength would bring to us more performance downgrade. For flash that
only need 1bit correction per 512 bytes, we certainly don't
need the 8bit ECC, or we would suffer from the performance.

One table with the ECC strength description would solve all the
problem we have, and also no risk in the driver robustness.

Thanks,
Lei
