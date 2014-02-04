From: amurray@embedded-bits.co.uk (Andrew Murray)
Date: Tue, 4 Feb 2014 13:23:17 +0000
Subject: [PATCH] arm64: Add architecture support for PCI
In-Reply-To: <20140204122951.GC27975@e106497-lin.cambridge.arm.com>
References: <1391453028-23191-1-git-send-email-Liviu.Dudau@arm.com>
 <1391453028-23191-2-git-send-email-Liviu.Dudau@arm.com>
 <CAPcvp5EF_=G=VwWLfbw6mwczErTHeq4AbVALYpuAzb3c5eb2rA@mail.gmail.com>
 <20140204122951.GC27975@e106497-lin.cambridge.arm.com>
Message-ID: <CAPcvp5HN4pBysOdS5_ep_3Lp7GDDKw4YrgmKjYzBet7PtaOLUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2014 12:29, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Mon, Feb 03, 2014 at 10:34:40PM +0000, Andrew Murray wrote:
>> On 3 February 2014 18:43, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> > diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>> > index 4cc813e..ce5bad2 100644
>> > --- a/arch/arm64/include/asm/io.h
>> > +++ b/arch/arm64/include/asm/io.h
>> > @@ -120,9 +120,13 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>> >  /*
>> >   *  I/O port access primitives.
>> >   */
>> > +#define arch_has_dev_port()    (0)
>> >  #define IO_SPACE_LIMIT         0xffff
>> >  #define PCI_IOBASE             ((void __iomem *)(MODULES_VADDR - SZ_2M))
>> >
>> > +#define ioport_map(port, nr)   (PCI_IOBASE + ((port) & IO_SPACE_LIMIT))
>> > +#define ioport_unmap(addr)
>>
>> I'm not sure that this will work. The in[bwl], out[bwl] macros in
>> arch/arm64/include/asm/io.h already add the PCI_IOBASE offset.
>>
>> Instead of these two #defines, why not just enforce that
>> GENERIC_PCI_IOMAP is enabled? Or at least wrap these defines with 'if
>> (!config_enabled(CONFIG_GENERIC_PCI_IOMAP))' or similar.
>
> GENERIC_PCI_IOMAP *is* enabled for AArch64. We have select GENERIC_IOMAP in
> arch/arm64/Kconfig which in turn selects GENERIC_PCI_IOMAP in lib/Kconfig.

Sorry, it was intent to suggest using the ioport_[map|unmap] functions
in lib/iomap.c instead of defining something similar here. I guess you
will also need to also define CONFIG_HAS_IOPORT for this to happen.

Andrew Murray

>
> Best regards,
> Liviu
>
>>
>> > +
>> >  static inline u8 inb(unsigned long addr)
>> >  {
>> >         return readb(addr + PCI_IOBASE);
>>
>>
>> Andrew Murray
>>
>
> --
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ?\_(?)_/?
>
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
>
> ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
> ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
>
