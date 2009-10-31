From: rkiyerpersonal@gmail.com (Rajanikanth H.V)
Date: Sat, 31 Oct 2009 18:43:19 +0530
Subject: DMA Cache coherency issue on A9 SMP System
Message-ID: <d82162470910310613mff28897k68d8794b6fb5b469@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Catalin,

I comeacross to see DMA cache coherency problem which is similar to
what you have stated in one of your previous mails,
"esp., dma cache coherency issue in the case of DMA_FROM_DEVICE.

my Current Setup:
	- A9 SMP
	- Kernel version 2.6.29
	- EHCI Host with DMA
	- Application use case:
		[USB Disk is connected to A9 Target Board]
		> Read a 200M File and apply md5sum
			OR
		> Copy a 200M+ file to a new file.

Problem:
	> MD5sum fails
	> The copied file will have corrupt data 		

Debugging further i have the following observation:
1. Pages pointed in each entry of Scatter-Gather list will be
Cache 'CLEAN+Invalidate'ed   before EHCI-DMA Happens for
DMA_FROM_DEVICE (BULK IN Request) .
Ref: dma_map_page()-> map_page();

Note:
	arm_arm / cortex-a9 document suggests to 'CLEAN+INVALIDATE'
	which is happening on the DMA'able page.

2. After the DMA i do not see the expected pattern,  instead,
	> One Cacheline length or 32 Bytes will have stale data
		on some pages
Note: I have created a 200M File having predefined pattern

3. As a Workaround, I applied 'dma_sync_single_for_device' on the
	DMA'ed pages after the DMA, this seems to have solved the
	issue, since i do not see any stale entry.

what could be the root cause?.


thanks in advance,
regards,

Rajanikanth
