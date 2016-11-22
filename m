From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 22:04:12 +0100
Subject: [PATCH net-next 1/4] net: mvneta: Convert to be 64 bits compatible
In-Reply-To: <20161122164844.19566-2-gregory.clement@free-electrons.com>
References: <20161122164844.19566-1-gregory.clement@free-electrons.com>
 <20161122164844.19566-2-gregory.clement@free-electrons.com>
Message-ID: <2948812.F3se4ieqO6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 5:48:41 PM CET Gregory CLEMENT wrote:
> +#ifdef CONFIG_64BIT
> +       void *data_tmp;
> +
> +       /* In Neta HW only 32 bits data is supported, so in order to
> +        * obtain whole 64 bits address from RX descriptor, we store
> +        * the upper 32 bits when allocating buffer, and put it back
> +        * when using buffer cookie for accessing packet in memory.
> +        * Frags should be allocated from single 'memory' region,
> +        * hence common upper address half should be sufficient.
> +        */
> +       data_tmp = mvneta_frag_alloc(pp->frag_size);
> +       if (data_tmp) {
> +               pp->data_high = (u64)upper_32_bits((u64)data_tmp) << 32;
> +               mvneta_frag_free(pp->frag_size, data_tmp);
> +       }
> 

How does this work when the region spans a n*4GB address boundary?

	Arnd
