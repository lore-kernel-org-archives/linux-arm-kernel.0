From: john.garry@huawei.com (John Garry)
Date: Mon, 17 Sep 2018 15:42:32 +0100
Subject: [PATCH] asm-generic: io: Fix ioport_map() for
 !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
In-Reply-To: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
References: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
Message-ID: <464e07ab-797e-971a-0839-5fd55e3e2ad3@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- dead e-mail addresses (Zhichang, Gabriele)

On 13/09/2018 13:48, Andrew Murray wrote:

Hi Andrew,

> The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
> prevent users from making I/O accesses outside the expected I/O range -
> however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
> contradictory to its other users.
>
> The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
> amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
> mangling the given port rather than capping it.
>
> We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
> implementation of ioport_map by using the comparison operator and
> returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
> we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
> we don't break existing buggy drivers that somehow rely on this masking.

I wouldn't say any drivers rely on this - for the only device driver 
which uses the "Indirect" IO space region above MMIO_UPPER_LIMIT 
(HiSilicon LPC), no child device driver for that host uses ioport_map() 
[those being ipmi si and 8250 generic+of drivers].

Regardless of that, it seems better to return NULL when the port is 
out-of-range, rather than masking it.

Cheers

>
> Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>  include/asm-generic/io.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 66d1d45..d356f80 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1026,7 +1026,8 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
>  #define ioport_map ioport_map
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
> -	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
> +	port &= IO_SPACE_LIMIT;
> +	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>  }
>  #endif
>
>
