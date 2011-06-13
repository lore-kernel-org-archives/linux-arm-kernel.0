From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Jun 2011 19:01:49 +0100
Subject: [Linaro-mm-sig] [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <BANLkTikkCV=rWM_Pq6t6EyVRHcWeoMPUqw@mail.gmail.com>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<BANLkTi=HtrFETnjk1Zu0v9wqa==r0OALvA@mail.gmail.com>
	<201106131707.49217.arnd@arndb.de>
	<BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
	<20110613154033.GA29185@1n450.cable.virginmedia.net>
	<BANLkTikkCV=rWM_Pq6t6EyVRHcWeoMPUqw@mail.gmail.com>
Message-ID: <20110613180149.GG13499@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 05:00:16PM +0100, KyongHo Cho wrote:
> > FWIW, on ARMv6 and later hardware, the dma_alloc_coherent() provides
> > writecombine memory (i.e. Normal Noncacheable), so no need for
> > dma_alloc_writecombine(). On earlier architectures it is creating
> > Strongly Ordered mappings (no writecombine).
>
> Do you mean that dma_alloc_coherent() and dma_alloc_writecombine() are
> not different
> except some additional features of dma_alloc_coherent() in ARM?
 
When CONFIG_DMA_MEM_BUFFERABLE is enabled (by default on ARMv7 and ARMv6
with some exceptions because of hardware issues), the resulting mapping
for both coherent and writecombine is the same. In both cases the
mapping is done as L_PTE_MT_BUFFERABLE which is what you want with
writecombine. You can check the pgprot_writecombine() and
pgprot_dmacoherent() macros in asm/pgtable.h

-- 
Catalin
