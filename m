From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Sep 2017 20:33:37 +0100
Subject: [PATCH v2 26/29] ARM: decompressor: add KASLR support
In-Reply-To: <nycvar.YSQ.7.76.1709041449041.8603@knanqh.ubzr>
References: <20170903120757.14968-1-ard.biesheuvel@linaro.org>
 <20170903120757.14968-27-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1709041449041.8603@knanqh.ubzr>
Message-ID: <CAKv+Gu8uyuENoUgr4vMggQ=vYUQmV6zKMb=0DE_DjW62=Lfefg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 September 2017 at 19:53, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sun, 3 Sep 2017, Ard Biesheuvel wrote:
>
>> Add support to the decompressor to load the kernel at a randomized
>> offset, and invoke the kernel proper while passing on the information
>> about the offset at which the kernel was loaded.
>>
>> This implementation will extract some pseudo-randomness from the low
>> bits of the generic timer (if available), and use CRC-16 to combine
>> it with the build ID string and the device tree binary (which ideally
>> has a /chosen/kaslr-seed property, but may also have other properties
>> that differ between boots). This seed is used to select one of the
>> candidate offsets in the lowmem region that don't overlap the zImage
>> itself, the DTB, the initrd and /memreserve/s and/or /reserved-memory
>> nodes that should be left alone.
>>
>> When booting via the UEFI stub, it is left up to the firmware to supply
>> a suitable seed and select an offset.
>
> Why did you remove the entropy contribution from general regs upon
> entry? That was an easy way to enable KASLR on those platforms not using
> DT as they would simply have to put some random value in any of the
> regs.
>

I simply did not consider non-DTB, to be honest. I implemented the
suggestion to stir the entropy using some build time data and the DTB
contents, and given that the kaslr entry code parses the command line
and other DTB structures (/memreserve/, /reserved-memory,
/chosen/initrd-xxx) to decide where to uncompress the kernel, the
thought never crossed my mind to add support for !DTB as well. And to
be perfectly honest, I'd rather rely on the ATAG to DTB compat code so
I don't have to implement an ATAGS version of kaslr_early_init()

Of course, that still does not rule out eor'ing all the register
together instead of only r3, so I will add that back.
