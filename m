From: mattst88@gmail.com (Matt Turner)
Date: Thu, 5 Apr 2018 19:48:10 -0700
Subject: [PATCH] alpha: io: reorder barriers to guarantee writeX() and
 iowriteX() ordering
In-Reply-To: <3c28281e-de52-abbe-36bc-06f5527da921@codeaurora.org>
References: <1522691281-21593-1-git-send-email-okaya@codeaurora.org>
 <3c28281e-de52-abbe-36bc-06f5527da921@codeaurora.org>
Message-ID: <CAEdQ38G9UAj4SCPXcG_gVPnPg+ceWze71E3HaA9StgEybn-Ruw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2018 at 6:35 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/2/2018 1:48 PM, Sinan Kaya wrote:
>> memory-barriers.txt has been updated with the following requirement.
>>
>> "When using writel(), a prior wmb() is not needed to guarantee that the
>> cache coherent memory writes have completed before writing to the MMIO
>> region."
>>
>> Current writeX() and iowriteX() implementations on alpha are not
>> satisfying this requirement as the barrier is after the register write.
>>
>> Move mb() in writeX() and iowriteX() functions to guarantee that HW
>> observes memory changes before performing register operations.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/alpha/include/asm/io.h | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
>> index d123ff9..4c533fc 100644
>> --- a/arch/alpha/include/asm/io.h
>> +++ b/arch/alpha/include/asm/io.h
>> @@ -341,14 +341,14 @@ extern inline unsigned int ioread16(void __iomem *addr)
>>
>>  extern inline void iowrite8(u8 b, void __iomem *addr)
>>  {
>> -     IO_CONCAT(__IO_PREFIX,iowrite8)(b, addr);
>>       mb();
>> +     IO_CONCAT(__IO_PREFIX, iowrite8)(b, addr);
>>  }
>>
>>  extern inline void iowrite16(u16 b, void __iomem *addr)
>>  {
>> -     IO_CONCAT(__IO_PREFIX,iowrite16)(b, addr);
>>       mb();
>> +     IO_CONCAT(__IO_PREFIX, iowrite16)(b, addr);
>>  }
>>
>>  extern inline u8 inb(unsigned long port)
>> @@ -382,8 +382,8 @@ extern inline unsigned int ioread32(void __iomem *addr)
>>
>>  extern inline void iowrite32(u32 b, void __iomem *addr)
>>  {
>> -     IO_CONCAT(__IO_PREFIX,iowrite32)(b, addr);
>>       mb();
>> +     IO_CONCAT(__IO_PREFIX, iowrite32)(b, addr);
>>  }
>>
>>  extern inline u32 inl(unsigned long port)
>> @@ -434,14 +434,14 @@ extern inline u16 readw(const volatile void __iomem *addr)
>>
>>  extern inline void writeb(u8 b, volatile void __iomem *addr)
>>  {
>> -     __raw_writeb(b, addr);
>>       mb();
>> +     __raw_writeb(b, addr);
>>  }
>>
>>  extern inline void writew(u16 b, volatile void __iomem *addr)
>>  {
>> -     __raw_writew(b, addr);
>>       mb();
>> +     __raw_writew(b, addr);
>>  }
>>  #endif
>>
>> @@ -482,14 +482,14 @@ extern inline u64 readq(const volatile void __iomem *addr)
>>
>>  extern inline void writel(u32 b, volatile void __iomem *addr)
>>  {
>> -     __raw_writel(b, addr);
>>       mb();
>> +     __raw_writel(b, addr);
>>  }
>>
>>  extern inline void writeq(u64 b, volatile void __iomem *addr)
>>  {
>> -     __raw_writeq(b, addr);
>>       mb();
>> +     __raw_writeq(b, addr);
>>  }
>>  #endif
>>
>>
>
>
> Can we get these merged to 4.17?
>
> There was a consensus to fix the architectures having API violation issues.
> https://www.mail-archive.com/netdev at vger.kernel.org/msg225971.html

I expect so. Sorry I haven't had time to collect patches yet. I think
tomorrow or the next day I will.
