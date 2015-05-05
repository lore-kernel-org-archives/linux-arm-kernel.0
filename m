From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 5 May 2015 13:42:21 +0200
Subject: [PATCH v3 1/6] ARM: l2c: Add DT support for Shared Override
In-Reply-To: <20150505112145.GG22384@e104818-lin.cambridge.arm.com>
References: <1430753072-17145-1-git-send-email-geert+renesas@glider.be>
 <1430753072-17145-2-git-send-email-geert+renesas@glider.be>
 <20150505112145.GG22384@e104818-lin.cambridge.arm.com>
Message-ID: <CAMuHMdWE3HjGk73gCN3P-bBVEGrMbgfJ=FqvcTtGecs15R=A_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, May 5, 2015 at 1:21 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, May 04, 2015 at 05:24:27PM +0200, Geert Uytterhoeven wrote:
>> "CoreLink Level 2 Cache Controller L2C-310", p. 2-15, section 2.3.2
>> Shareable attribute" states:
>>
>>     "The default behavior of the cache controller with respect to the
>>      shareable attribute is to transform Normal Memory Non-cacheable
>>      transactions into:
>>         - cacheable no allocate for reads
>>         - write through no write allocate for writes."
>>
>> Depending on the system architecture, this may cause memory corruption
>> in the presence of bus mastering devices (e.g. OHCI). To avoid such
>> corruption, the default behavior can be disabled by setting the Shared
>> Override bit in the Auxiliary Control register.
>>
>> Currently the Shared Override bit can be set only using C code:
>>   - by calling l2x0_init() directly, which is deprecated,
>>   - by setting/clearing the bit in the machine_desc.l2c_aux_val/mask
>>     fields, but using values differing from 0/~0 is also deprecated.
>
> Or you can set it in firmware/boot-loader before Linux starts.

... together with all other additional settings cache-l2x0.c does?

I'm afraid this is not going to happen...

>> Hence add support for an "arm,shared-override" device tree property for
>> the l2c device node. By specifying this property, affected systems can
>> indicate that non-cacheable transactions must not be transformed.
>>
>> If specified, the actual behavior of the kernel depends on whether CMA
>> is available or not:
>>   - If CMA is available, nothing needs to be done, as there won't be a
>>     kernel linear mappings and cacheable aliases for the DMA buffers,
>
> I don't think this is true. See this thread:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/329492.html

Doh, and I had hoped to please Russell...

To bad, will drop this.

>>   - If CMA is not available, the "shared attribute override enable" bit
>>     will be set.
>
> IMO, this should always be done, independent of any DT or kernel
> configuration. I stated it several times already that I don't see why we
> would ever need such bit cleared:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330573.html
>
> Personally I don't think this configuration belongs to the DT,
> especially as it may depend on how the OS is configured. But since

That's why I worded the bindings like "[...] this property must be specified to
indicate that such transforms are precluded.", not "[...] this property must be
specified if the Shared Override bit must be set by the OS.".
It's still up to the OS to decide (e.g. if CMA will get fixed).

> Russell has refused to take patches setting this bit by default (I have
> yet to see a valid argument), it's still better than nothing.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
