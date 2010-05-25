From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 25 May 2010 21:21:13 +0800
Subject: [PATCH 01/20] mtd: pxa3xx_nand: refuse the flash definition get
	from platform
In-Reply-To: <AANLkTimOGbp6m2v4574ZR-74zbUA-dSAZl3BhlkOBqr3@mail.gmail.com>
References: <AANLkTinVBXhT77Zd-LNpufgJAl7WZdic0oxDFwvNkvJg@mail.gmail.com>
	<4BFA2B5B.4080105@compulab.co.il>
	<AANLkTilLYFVPcel-rE8RbuTWEir4RJOBqmyxirb6Vozn@mail.gmail.com>
	<4BFA5C58.7050109@compulab.co.il>
	<AANLkTimYwQa5aJ2wuuBvPQ6O6hgYKaQcCcb3jwTcgFcD@mail.gmail.com>
	<4BFA7D60.6020703@compulab.co.il>
	<AANLkTil1mq5FBePSexz80DyT80DGqshqyJEi6Pfp0kV7@mail.gmail.com>
	<4BFBA4BA.9020502@compulab.co.il>
	<AANLkTimOGbp6m2v4574ZR-74zbUA-dSAZl3BhlkOBqr3@mail.gmail.com>
Message-ID: <AANLkTilCjPI194k6ROoVIjw9r9cKO5HtSyl2KtsDPqPz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 9:01 PM, Lei Wen <adrian.wenl@gmail.com> wrote:
> On Tue, May 25, 2010 at 6:21 PM, Mike Rapoport <mike@compulab.co.il> wrote:
>> Lei Wen wrote:
>>>
>>> On Mon, May 24, 2010 at 9:21 PM, Mike Rapoport <mike@compulab.co.il>
>>> wrote:
>>>>
>>>> Lei Wen wrote:
>>>>>
>>>>> Hi Mike,
>>>>>
>>>>> On Mon, May 24, 2010 at 7:00 PM, Mike Rapoport <mike@compulab.co.il>
>>>>> wrote:
>>>>>>
>>>>>> Hi Lei,
>>>>>>
>>>>>> Lei Wen wrote:
>>>>>>>
>>>>>>> Hi Mike,
>>>>>>>
>>>>>> 2) I don't like hadrcoding of NAND parameters into the driver. You
>>>>>> remove
>>>>>> *deprecetad* CONFIG_MTD_NAND_PXA3xx_BUILTIN configuration option and
>>>>>> instead
>>>>>> you enforce use of built-in definitions. The driver in its current
>>>>>> state
>>>>>> is
>>>>>> robust enough to allow platforms to define optimized NAND timings
>>>>>> either
>>>>>> in
>>>>>> the bootloader or in the kernel. If you don't like that multiple
>>>>>> platforms
>>>>>> define the same flash chip create an enumeration of built-in types and
>>>>>> let
>>>>>> platforms to use this enumeration to select the NAND chip. But, anyway,
>>>>>> there should be a fallback mode that will support NAND chips that are
>>>>>> not
>>>>>> defined in the driver, probably with suboptimal timings.
>>>>>
>>>>> Original driver also use hardcoding. And in bootloader, this timing
>>>>> parameter is also hard coding.
>>>>> We cannot deduce a parameter set only from the nand id, that is why we
>>>>> need a table to preset it.
>>>>> If one nand chip is not listed in that table, the chip id would still
>>>>> be printed out, so that we can do something for that.
>>>>> If we encourage people to continue on this, we would not able to
>>>>> really "driver" that nand.
>>>>
>>>> Currently pxa3xx-nand has three operational modes:
>>>> - use NAND parameters supplied by the platform
>>>> - use presets configured by the bootloader chain
>>>> - use built-in NAND parameters, marked as deprecated in favor of the
>>>> first
>>>> two
>>>> You remove the first two modes completely and require that each and every
>>>> NAND chip used on pxa3xx based platform will be added to the driver. This
>>>> way you make the driver less robust and harder to use for platform
>>>> developers, not mentioning you're breaking the existing platforms.
>>>> In my opinion, the driver *may* support built-in definitions for certain
>>>> NAND flashes and *must* support configuration of the NAND parameters by
>>>> the
>>>> platform code and bootloader.
>>>>
>>>
>>> Hi Mike,
>>>
>>> Well... I would submit another patch set which would reserve a way
>>> that platform could pass its parameter setting.
>>> Like specify the certain type of nand chip parameter for each chip
>>> select. Is that ok for you?
>>>
>>> For bootloader pass parameter method, I think this way should be
>>> dropped... For there is attributed which we could not tell from
>>> registers...
>>> What do you think of this?
>>
>> Can you please elaborate what are the attributes that cannot be detected?
>
> The attributes comes from two new features that would be included into
> pxa3xx_nand: BCH support and 8bit per 512bytes ECC.
> Originally, our pxa3xx_nand only support Hamming ECC way. So no doubt
> just read the timing register, and just set use ecc bit in NDCR is
> enough.
> But for now there is two type of ECC type. For distinguish, we
> introduce a new register called NDECCCTRL. NDECCCTRL_BCH_EN in the bit
> 0 of that register control whether use the BCH ECC.
> You may ask me why not just read from NDECCCTRL to know the ECC type.
> It is right, but not always to be true. It the last command executed
> for nand before kernel take control is not read or write operation,
> the bootloader has no reason to set the NDECCCTRL register. So our
> kernel also unable to detect whether to use BCH or HAMMING ECC.
>
> This two type of ecc has different character, if use hamming ecc for
> reading while that page is written by BCH, it would instant report of
> DB error...
> This is not the worst case., for we may ask the bootloader to always
> set the NDECCCTRL. (There is no reason to apply ECC when do command
> except the read and write although)
>
> The worst would comes at the supporting of 8bit per 512 bytes ECC. Our
> BCH engine only support 16bit corroction per 2k data, aka 4bit per
> 512bytes.
> If we need to support 8bit per 512bytes feature, which is needed by a
> lot of newest flash which require such high ecc strength.
> Then we have to apply the BCH to 1k data instead of 2k. The layout of
> content on flash would change.
> Original BCH apply to 2k nand, the layout may like: | 2k data | + | 30
> bytes ECC |
> Now after apply BCH to 1k range, the layout would be like: | 1k data |
> + | 30 bytes ECC| + | 1k data| + |30 bytes ECC|.
> Even as I said let the bootloader to always set the NDECCCTRL. The
> kernel would still cannot distinguish the two use case of 4bit per
> 512bytes and 8bit per 512 bytes ECC strength requirement.
> For they both use BCH, the only difference could be told on the nand
> layout, not by register reading.
>
> Those two new feature would lead different nand content layout. So if
> not distinguish properly, nand would not be able to work functional.
> And obviously, the two features cannot get from register reading, and
> that is the reason why I suggest drop the feature.
>

Then would it be possible to just drop the feature for pxa168 and onward?
I guess there might be some existing usages out there for pxa3xx already,
so not to affect existing systems.

Actually, it's now quite easy for a single driver to distinguish this, through
platform_device_id table please, see drivers/i2c/busses/i2c-pxa.c for an
example. I'd like to call the device pxa168-nand or something.
