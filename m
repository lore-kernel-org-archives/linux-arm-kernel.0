From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 22 Oct 2014 21:10:27 +0200
Subject: [PATCH] ARM: supplementing IO accessors with 64 bit capability
In-Reply-To: <20141022164454.GI15370@e104818-lin.cambridge.arm.com>
References: <1413993983-17310-1-git-send-email-mathieu.poirier@linaro.org>
 <20141022164454.GI15370@e104818-lin.cambridge.arm.com>
Message-ID: <CANLsYkx08dw=YYBoRJ47QC+iL578HxPoMFcRDw6aKsvyqaqtkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 October 2014 18:44, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Oct 22, 2014 at 05:06:23PM +0100, mathieu.poirier at linaro.org wrote:
>> +#if __LINUX_ARM_ARCH__ >= 5
>
> My old ARMv5 book does not list LDRD/STRD. It looks like they only come
> with ARMv5TE. Are there any processors prior to this supported by the
> kernel?
>
>> +static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
>> +{
>> +     asm volatile("strd %1, %0"
>> +                  : "+Qo" (*(volatile u64 __force *)addr)
>> +                  : "r" (val));
>> +}
>> +
>> +static inline u64 __raw_readq(const volatile void __iomem *addr)
>> +{
>> +     u64 val;
>> +     asm volatile("ldrd %1, %0"
>> +                  : "+Qo" (*(volatile u64 __force *)addr),
>> +                    "=r" (val));
>> +     return val;
>> +}
>> +#endif
>
> I'm curious why you need these. Do you have a device that needs a 64-bit
> single access or you are trying to read two consecutive registers?

The fundamental data size of Coresight STM32 for ARMv7 is
implementation defined and can be 32 or 64bit.  As such stimulus ports
can support transaction sizes of up to 64 bit.

Mathieu

>
> --
> Catalin
