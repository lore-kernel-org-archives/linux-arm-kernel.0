From: robherring2@gmail.com (Rob Herring)
Date: Tue, 5 May 2015 11:34:26 -0500
Subject: [PATCH v3 1/6] ARM: l2c: Add DT support for Shared Override
In-Reply-To: <20150505142211.GH22384@e104818-lin.cambridge.arm.com>
References: <1430753072-17145-1-git-send-email-geert+renesas@glider.be>
 <1430753072-17145-2-git-send-email-geert+renesas@glider.be>
 <20150505112145.GG22384@e104818-lin.cambridge.arm.com>
 <CAMuHMdWE3HjGk73gCN3P-bBVEGrMbgfJ=FqvcTtGecs15R=A_g@mail.gmail.com>
 <20150505142211.GH22384@e104818-lin.cambridge.arm.com>
Message-ID: <CAL_JsqJvRGFUzd8zo990Qz1EQmpAhgy7OC=9tXcDavD5zk5tdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 5, 2015 at 9:22 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, May 05, 2015 at 01:42:21PM +0200, Geert Uytterhoeven wrote:
>> On Tue, May 5, 2015 at 1:21 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Mon, May 04, 2015 at 05:24:27PM +0200, Geert Uytterhoeven wrote:
>> >> "CoreLink Level 2 Cache Controller L2C-310", p. 2-15, section 2.3.2
>> >> Shareable attribute" states:
>> >>
>> >>     "The default behavior of the cache controller with respect to the
>> >>      shareable attribute is to transform Normal Memory Non-cacheable
>> >>      transactions into:
>> >>         - cacheable no allocate for reads
>> >>         - write through no write allocate for writes."
>> >>
>> >> Depending on the system architecture, this may cause memory corruption
>> >> in the presence of bus mastering devices (e.g. OHCI). To avoid such
>> >> corruption, the default behavior can be disabled by setting the Shared
>> >> Override bit in the Auxiliary Control register.
>> >>
>> >> Currently the Shared Override bit can be set only using C code:
>> >>   - by calling l2x0_init() directly, which is deprecated,
>> >>   - by setting/clearing the bit in the machine_desc.l2c_aux_val/mask
>> >>     fields, but using values differing from 0/~0 is also deprecated.
>> >
>> > Or you can set it in firmware/boot-loader before Linux starts.
>>
>> ... together with all other additional settings cache-l2x0.c does?
>>
>> I'm afraid this is not going to happen...
>
> It's not that bad but, well, it requires changes elsewhere (U-Boot
> already does this for some SoCs).
>
>> >> Hence add support for an "arm,shared-override" device tree property for
>> >> the l2c device node. By specifying this property, affected systems can
>> >> indicate that non-cacheable transactions must not be transformed.
>> >>
>> >> If specified, the actual behavior of the kernel depends on whether CMA
>> >> is available or not:
>> >>   - If CMA is available, nothing needs to be done, as there won't be a
>> >>     kernel linear mappings and cacheable aliases for the DMA buffers,
>> >
>> > I don't think this is true. See this thread:
>> >
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/329492.html
>>
>> Doh, and I had hoped to please Russell...
>>
>> To bad, will drop this.
>
> You should only drop the "if (dev_get_cma_area(NULL))" check.
>
>> >>   - If CMA is not available, the "shared attribute override enable" bit
>> >>     will be set.
>> >
>> > IMO, this should always be done, independent of any DT or kernel
>> > configuration. I stated it several times already that I don't see why we
>> > would ever need such bit cleared:
>> >
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330573.html
>> >
>> > Personally I don't think this configuration belongs to the DT,
>> > especially as it may depend on how the OS is configured. But since
>>
>> That's why I worded the bindings like "[...] this property must be specified to
>> indicate that such transforms are precluded.", not "[...] this property must be
>> specified if the Shared Override bit must be set by the OS.".
>> It's still up to the OS to decide (e.g. if CMA will get fixed).
>
> We are kind of stretching this definition if the CMA check is removed.
> The check could added back if DMA allocations are ever fixed to avoid
> memory attributes aliases (right now they still exist, even though
> temporarily). A situation where this bit probably does not need to be
> set (though it's harmless) is I/O coherent systems ("arm,io-coherent").

IIRC, it still had to be set on highbank even when we had coherent i/o.

> My view is that we should always set this bit without any additional DT
> properties but if it's easier to get it accepted this way, I'm fine as
> well.

+1

> BTW, your patch mentions r2p0. My reading of the PL310 TRM shows this
> bit as default from r0p0.

I believe the change in behavior was from the L2x0 to PL310.

Rob
