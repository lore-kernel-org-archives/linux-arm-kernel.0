From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 7 May 2015 14:07:25 +0200
Subject: [PATCH] arm/mm/dma-mapping.c: Add arm_coherent_dma_mmap
In-Reply-To: <1431000019-7483-1-git-send-email-mike.looijmans@topic.nl>
References: <1431000019-7483-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <554B557D.10005@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Oops, "arch/arm/boot/dts/topic-dyplo.dtsi" should not have been in there. Will 
send a v2 patch to correct that.

On 07-05-15 14:00, Mike Looijmans wrote:
> When dma-coherent transfers are enabled, the mmap call must
> not change the pg_prot flags in the vma struct.
>
> Split the arm_dma_mmap into a common and specific parts,
> and add a "arm_coherent_dma_mmap" implementation that does
> not alter the page protection flags.
>
> Tested on a topic-miami board (Zynq) using the ACP port
> to transfer data between FPGA and CPU using the Dyplo
> framework. Without this patch, byte-wise access to mmapped
> coherent DMA memory was about 20x slower because of the
> memory being marked as non-cacheable, and transfer speeds
> would not exceed 240MB/s.
>
> After this patch, the mapped memory is cacheable and the
> transfer speed is again 600MB/s (limited by the FPGA) when
> the data is in the L2 cache, while data integrity is being
> maintained.
>
> The patch has no effect on non-coherent DMA.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>   arch/arm/boot/dts/topic-dyplo.dtsi |  1 +
>   arch/arm/mm/dma-mapping.c          | 32 +++++++++++++++++++++++++-------
>   2 files changed, 26 insertions(+), 7 deletions(-)



Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
