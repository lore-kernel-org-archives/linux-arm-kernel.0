From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 14 Jan 2011 17:35:41 -0800
Subject: [PATCH 27/48] ARM: PL08x: avoid duplicating registers in txd and
	phychan structures
In-Reply-To: <E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
	<E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTi=GsMaDQDSuR=Z4AT4Vk4GThx6O_0Le=pjsu9gj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 3, 2011 at 2:39 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> As we now have all the code accessing the phychan {csrc,cdst,clli,cctl,
> ccfg} members in one function, there's no point storing the data into
> the struct. ?Get rid of the struct members. ?Re-order the register dump
> in the dev_dbg() to reflect the order we write the registers to the DMA
> device.
>
> The txd {csrc,cdst,clli,cctl} values are duplicates of the lli[0]
> values, so there's no point duplicating these either. ?Program the DMAC
> registers directly from the lli[0] values.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This one caused:
drivers/dma/amba-pl08x.c: In function 'pl08x_start_txd':
drivers/dma/amba-pl08x.c:205: warning: dereferencing 'void *' pointer

So I appended the following:
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 933b4ed..5b87b6a 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -118,7 +118,7 @@ struct pl08x_txd {
        dma_addr_t dst_addr;
        size_t len;
        dma_addr_t llis_bus;
-       void *llis_va;
+       struct pl08x_lli *llis_va;
        bool active;
        /* Default cctl value for LLIs */
        u32 cctl;

--
Dan
