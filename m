From: moore@free.fr (Chris Moore)
Date: Tue, 3 Oct 2017 06:48:25 +0200
Subject: [PATCH 3/4] nvmem: add a driver for the Amlogic
 Meson6/Meson8/Meson8b SoCs
In-Reply-To: <20171001125700.1520-4-martin.blumenstingl@googlemail.com>
References: <20171001125700.1520-1-martin.blumenstingl@googlemail.com>
 <20171001125700.1520-4-martin.blumenstingl@googlemail.com>
Message-ID: <cd1e7f9c-5aff-8f4c-82b0-c58c2de4c253@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry in advance if I am being extremely stupid here.

Le 01/10/2017 ? 14:56, Martin Blumenstingl a ?crit?:

[snip]

> +static int meson_mx_efuse_read(void *context, unsigned int offset,
> +			       void *buf, size_t bytes)
> +{
> +	struct meson_mx_efuse *efuse = context;
> +	u32 tmp;
> +	int err, i, addr;
> +
> +	err = meson_mx_efuse_hw_enable(efuse);
> +	if (err)
> +		return err;
> +
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_AUTO_RD_ENABLE,
> +				 MESON_MX_EFUSE_CNTL1_AUTO_RD_ENABLE);
> +
> +	for (i = offset; i < offset + bytes; i += efuse->config.word_size) {
> +		addr = i / efuse->config.word_size;
> +
> +		err = meson_mx_efuse_read_addr(efuse, addr, &tmp);
> +		if (err)
> +			break;
> +
> +		memcpy(buf + i, &tmp, efuse->config.word_size);
> +	}

This will not give the expected result if offset is not a multiple of 
efuse->config.word_size.
This will cause buffer overflow if bytes is not a multiple of 
efuse->config.word_size.
Shouldn't there at least be some sort of test on offset and bytes?

Also this doesn't look endian-safe, but maybe it is.

Old-timer remarks:
- I try to avoid divisions where possible but I suppose they are very 
low-cost on recent hardware.
- I don't like arithmetic on void pointers but I know it is supported by 
gcc (and possibly by recent C standards too).

Sorry again for the noise if I am being stupid.

Cheers,
Chris
