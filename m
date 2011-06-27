From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 27 Jun 2011 13:34:48 +0300
Subject: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <20110621075319.GN26089@n2100.arm.linux.org.uk>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimnuEK_9RedmD1OgcunX3rPvd-O0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> +static inline void __dma_sync(void)
> +{
> + ? ? ? dsb();
> +}
> +
> ?/*
> ?* Return whether the given device DMA address mask can be supported
> ?* properly. ?For example, if your device can only drive the low 24-bits
> @@ -378,6 +383,7 @@ static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
> ? ? ? ?BUG_ON(!valid_dma_direction(dir));
>
> ? ? ? ?addr = __dma_map_single(dev, cpu_addr, size, dir);
> + ? ? ? __dma_sync();
Russell,
  I'm curious about the correctness of this patch for systems with
outer cache. shouldn't the dsb be issued before the outer cache
maintenance?
saeed
