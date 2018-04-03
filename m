From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2018 09:21:18 +0200
Subject: [PATCH v2] MIPS: io: add a barrier after register read in readX()
In-Reply-To: <1522692821-27706-1-git-send-email-okaya@codeaurora.org>
References: <1522692821-27706-1-git-send-email-okaya@codeaurora.org>
Message-ID: <CAK8P3a0WwhDoTdQNoxnpBVDZu8a7oKdB2tSjVRTRf3rrecEKMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2018 at 8:13 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> While a barrier is present in writeX() function before the register write,
> a similar barrier is missing in the readX() function after the register
> read. This could allow memory accesses following readX() to observe
> stale data.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 0cbf3af..7f9068d 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)        \
>                 BUG();                                                  \
>         }                                                               \
>                                                                         \
> +       war_io_reorder_wmb();                                           \
>         return pfx##ioswab##bwlq(__mem, __val);                         \
>  }

I'm not sure if this is the right barrier: what we want here is a read
barrier to
prevent any following memory access from being prefetched ahead of the readl(),
so I would have expected a kind of rmb() rather than wmb().

The barrier you used here is defined as

#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
#define war_io_reorder_wmb()            wmb()
#else
#define war_io_reorder_wmb()            do { } while (0)
#endif

which appears to list the particular CPUs that have a reordering
write buffer. That may not be the same set of CPUs that have the
capability to do out-of-order loads.

       Arnd
