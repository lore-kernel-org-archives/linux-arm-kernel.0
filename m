From: peter.maydell@linaro.org (Peter Maydell)
Date: Sat, 7 Dec 2013 21:38:09 +0000
Subject: [PATCH v2] ARM: asm: add readq/writeq methods
In-Reply-To: <52A3472C.4010203@arkona-technologies.de>
References: <52A3472C.4010203@arkona-technologies.de>
Message-ID: <CAFEAcA9iHdEvr5f7Cv4NB+5Js7BU3gL8Tfh1WhyM0T6Dh7LKWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 December 2013 16:05, Matthias Mann <M.Mann@arkona-technologies.de> wrote:
> Add readq/writeq methods for 32 bit ARM to allow transfering 64 bit words over
> PCIe as a single transfer.

> +#if __LINUX_ARM_ARCH__ >= 5
> +static inline u64 __raw_readq(const volatile void __iomem *addr)
> +{
> +       u64 val;
> +#if __LITTLE_ENDIAN
> +       asm volatile("ldrd %Q1, %R1, %0"
> +                    : "+Q" (*(volatile u64 __force *)addr),
> +                      "=r" (val));
> +#else
> +       asm volatile("ldrd %R1, %Q1, %0"
> +                    : "+Q" (*(volatile u64 __force *)addr),
> +                      "=r" (val));
> +#endif
> +       return val;
> +}

Given that ldrd/strd accesses are only a single 64 bit access
on CPUs with LPAE (on non-LPAE CPUs they may be
implemented as just a pair of 32 bit accesses) should the
condition be stricter than just __LINUX_ARM_ARCH__ >= 5 ?

thanks
-- PMM
