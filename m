From: vdumpa@nvidia.com (Krishna Reddy)
Date: Tue, 11 Oct 2011 18:34:55 -0700
Subject: [Linaro-mm-sig] [PATCH 1/2] ARM: initial proof-of-concept IOMMU
	mapper for DMA-mapping
In-Reply-To: <401E54CE964CD94BAE1EB4A729C7087E3722519A1F@HQMAIL04.nvidia.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-2-git-send-email-m.szyprowski@samsung.com>
	<594816116217195c28de13accaf1f9f2.squirrel@www.codeaurora.org>
	<001f01cc786d$d55222c0$7ff66840$%szyprowski@samsung.com>
	<401E54CE964CD94BAE1EB4A729C7087E37225197F8@HQMAIL04.nvidia.com>
	<00b101cc87ee$8976c410$9c644c30$%szyprowski@samsung.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519A1F@HQMAIL04.nvidia.com>
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E3722519BF4@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>It looks that You have simplified arm_iommu_map_sg() function too much. 
>>The main advantage of the iommu is to map scattered memory pages into 
>>contiguous dma address space. DMA-mapping is allowed to merge consecutive
>>entries in the scatter list if hardware supports that.
>>http://article.gmane.org/gmane.linux.kernel/1128416
>I would update arm_iommu_map_sg() back to coalesce the sg list.
>>MMC drivers seem to be aware of coalescing the SG entries together as they are using dma_sg_len().

I have updated the arm_iommu_map_sg() back to coalesce and fixed the issues with it. During testing, I found out that mmc host driver doesn't support buffers bigger than 64K. To get the device working, I had to break the sg entries coalesce when dma_length is about to go beyond 64KB. Looks like Mmc host driver(sdhci.c) need to be fixed to handle buffers bigger than 64KB. Should the clients be forced to handle bigger buffers or is there any better way to handle these kind of issues?

--
nvpublic
