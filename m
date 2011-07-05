From: parkch98@gmail.com (Chanho Park)
Date: Tue, 5 Jul 2011 15:33:49 +0900
Subject: [PATCH 3/7] DMA: PL330: Add DMA capabilities
In-Reply-To: <1309781915-31549-4-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAPTzV15Y7JFDKsec8x-M0C1AFLOMp39QvHpRCsO=E001P_tH9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene.kim <at> samsung.com> writes:

(snip)

> +             if (slave_config->direction == DMA_TO_DEVICE) {
> +                     if (slave_config->dst_addr)
> +                             peri->fifo_addr = slave_config->dst_addr;
> +                     if (slave_config->dst_addr_width) {
> +                             i = 0;
> +                             while (slave_config->dst_addr_width != (1 <<
i))
> +                                     i++;
> +                             peri->burst_sz = i;
> +                     }
> +             } else if (slave_config->direction == DMA_FROM_DEVICE) {
> +                     if (slave_config->src_addr)
> +                             peri->fifo_addr = slave_config->src_addr;
> +                     if (slave_config->src_addr_width) {
> +                             i = 0;
> +                             while (slave_config->src_addr_width != (1 <<
i))
> +                                     i++;
> +                             peri->burst_sz = i;

Re-send including cc and mailing lists
--
pl330 dmac only supports 1/2/4/8/16 bytes burst size.
If some bad D/D doesn't use powers of 2 width,
dmaengine is going to infinite loop.
You'd better check it instead of running loop.
