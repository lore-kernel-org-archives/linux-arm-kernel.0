From: M.Mann@arkona-technologies.de (Matthias Mann)
Date: Sat, 07 Dec 2013 23:02:48 +0100
Subject: [PATCH v2] ARM: asm: add readq/writeq methods
In-Reply-To: <yw1xd2l8l4oc.fsf@unicorn.mansr.com>
References: <52A3472C.4010203@arkona-technologies.de>
 <CAFEAcA9iHdEvr5f7Cv4NB+5Js7BU3gL8Tfh1WhyM0T6Dh7LKWw@mail.gmail.com>
 <yw1xd2l8l4oc.fsf@unicorn.mansr.com>
Message-ID: <52A39B08.8090205@arkona-technologies.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

M?ns Rullg?rd wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 7 December 2013 16:05, Matthias Mann <M.Mann@arkona-technologies.de> wrote:
>>> Add readq/writeq methods for 32 bit ARM to allow transfering 64 bit words over
>>> PCIe as a single transfer.
>>> +#if __LINUX_ARM_ARCH__ >= 5
>>> +static inline u64 __raw_readq(const volatile void __iomem *addr)
>>> +{
>>> +       u64 val;
>>> +#if __LITTLE_ENDIAN
>>> +       asm volatile("ldrd %Q1, %R1, %0"
>>> +                    : "+Q" (*(volatile u64 __force *)addr),
>>> +                      "=r" (val));
>>> +#else
>>> +       asm volatile("ldrd %R1, %Q1, %0"
>>> +                    : "+Q" (*(volatile u64 __force *)addr),
>>> +                      "=r" (val));
>>> +#endif
>>> +       return val;
>>> +}
>> Given that ldrd/strd accesses are only a single 64 bit access
>> on CPUs with LPAE (on non-LPAE CPUs they may be
>> implemented as just a pair of 32 bit accesses) should the
>> condition be stricter than just __LINUX_ARM_ARCH__ >= 5 ?
> What do actual CPUs, e.g. the A9, do?
>
I've tested that on an Freescale i.MX6D which is a Cortex-A9 with an Altera Arria V GZ FPGA connected via PCIe. Using strd / ldrd I see a 64 bit TLP (length = 2) on the PCIe interface (this is on an uncachable 32 bit BAR).
