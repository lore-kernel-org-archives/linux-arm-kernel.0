From: adrian.wenl@gmail.com (Lei Wen)
Date: Mon, 24 May 2010 21:40:57 +0800
Subject: [PATCH 01/20] mtd: pxa3xx_nand: refuse the flash definition get
	from platform
In-Reply-To: <4BFA7D60.6020703@compulab.co.il>
References: <AANLkTinVBXhT77Zd-LNpufgJAl7WZdic0oxDFwvNkvJg@mail.gmail.com>
	<4BFA2B5B.4080105@compulab.co.il>
	<AANLkTilLYFVPcel-rE8RbuTWEir4RJOBqmyxirb6Vozn@mail.gmail.com>
	<4BFA5C58.7050109@compulab.co.il>
	<AANLkTimYwQa5aJ2wuuBvPQ6O6hgYKaQcCcb3jwTcgFcD@mail.gmail.com>
	<4BFA7D60.6020703@compulab.co.il>
Message-ID: <AANLkTil1mq5FBePSexz80DyT80DGqshqyJEi6Pfp0kV7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 9:21 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> Lei Wen wrote:
>>
>> Hi Mike,
>>
>> On Mon, May 24, 2010 at 7:00 PM, Mike Rapoport <mike@compulab.co.il>
>> wrote:
>>>
>>> Hi Lei,
>>>
>>> Lei Wen wrote:
>>>>
>>>> Hi Mike,
>>>>
>>> 2) I don't like hadrcoding of NAND parameters into the driver. You remove
>>> *deprecetad* CONFIG_MTD_NAND_PXA3xx_BUILTIN configuration option and
>>> instead
>>> you enforce use of built-in definitions. The driver in its current state
>>> is
>>> robust enough to allow platforms to define optimized NAND timings either
>>> in
>>> the bootloader or in the kernel. If you don't like that multiple
>>> platforms
>>> define the same flash chip create an enumeration of built-in types and
>>> let
>>> platforms to use this enumeration to select the NAND chip. But, anyway,
>>> there should be a fallback mode that will support NAND chips that are not
>>> defined in the driver, probably with suboptimal timings.
>>
>> Original driver also use hardcoding. And in bootloader, this timing
>> parameter is also hard coding.
>> We cannot deduce a parameter set only from the nand id, that is why we
>> need a table to preset it.
>> If one nand chip is not listed in that table, the chip id would still
>> be printed out, so that we can do something for that.
>> If we encourage people to continue on this, we would not able to
>> really "driver" that nand.
>
> Currently pxa3xx-nand has three operational modes:
> - use NAND parameters supplied by the platform
> - use presets configured by the bootloader chain
> - use built-in NAND parameters, marked as deprecated in favor of the first
> two
> You remove the first two modes completely and require that each and every
> NAND chip used on pxa3xx based platform will be added to the driver. This
> way you make the driver less robust and harder to use for platform
> developers, not mentioning you're breaking the existing platforms.
> In my opinion, the driver *may* support built-in definitions for certain
> NAND flashes and *must* support configuration of the NAND parameters by the
> platform code and bootloader.
>

Hi Mike,

Well... I would submit another patch set which would reserve a way
that platform could pass its parameter setting.
Like specify the certain type of nand chip parameter for each chip
select. Is that ok for you?

For bootloader pass parameter method, I think this way should be
dropped... For there is attributed which we could not tell from
registers...
What do you think of this?

Thanks,
Lei
