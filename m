From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Thu, 26 Mar 2015 12:51:23 +0100
Subject: [RFC 1/6] atmel: add atmel_io.h
In-Reply-To: <1427370354-21247-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150326115123.GA16148@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Thu 26 Mar 2015 11:45:49 +0000 or thereabout, Ben Dooks wrote:
> The AVR32 and ARM (AT91) architectures share a number of drivers which
> need to access the on chip peripherals. The current drivers work with
> the default endian configuration, however it is possilbe to run some of
> the ATMEL ARM architectures in big endian mode.
> 
> If we change the drivers from __raw to _relaxed IO accesors then the ARM
> side works but the AVR32 will not. The _relaxed assume the bus is little
> endian and the __raw are native. The AVR32 is native big endian so these
> are not the right functions.
> 
> To sort this out, and avoid a number of drivers having #ifdef for the
> AVR32 case we add <linux/atmel_io.h> to provide some AT91/AVR32 independant
> IO accessor functions.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> --
> CC: Haavard Skinnemoen <hskinnemoen@gmail.com>
> CC: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> CC: Andrew Victor <linux@maxim.org.za>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: linux-arm-kernel at lists.infradead.org
> ---
>  include/linux/atmel_io.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 include/linux/atmel_io.h
> 
> diff --git a/include/linux/atmel_io.h b/include/linux/atmel_io.h
> new file mode 100644
> index 0000000..1234e88
> --- /dev/null
> +++ b/include/linux/atmel_io.h
> @@ -0,0 +1,25 @@
> +/* Atmel AT91/AVR32 independant IO
> + *
> + * Copyright 2015 Codethink Ltd.
> + * Ben Dooks <ben.dooks@codethink.co.uk>
> + *
> + * Provide architecture indendant, endian-safe IO accessor functions
> + */
> +
> +#ifdef CONFIG_AVR32
> +/* For AVR32 the readl and writel relaxed will do an extra byte reverse
> + * as the peripherals are already in the same endian-ness as the CPU and
> + * readl/writel assume little endian where the CPU is big endian
> + */
> +#define atmel_oc_readl	__raw_readl
> +#define atmel_oc_writel	__raw_writel
> +
> +#define atmel_oc_readw	__raw_readw
> +#define atmel_oc_writew	__raw_writew
> +#else
> +#define atmel_oc_readl	readl_relaxed
> +#define atmel_oc_writel	writel_relaxed
> +
> +#define atmel_oc_readw	readw_relaxed
> +#define atmel_oc_writew	writew_relaxed
> +#endif
-- 
mvh
Hans-Christian Egtvedt
