From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 9 Mar 2017 11:19:56 +0000
Subject: [Question] devm_kmalloc() for DMA ?
In-Reply-To: <CAK7LNAQ3FbicgoV1Q70T2gZQS0j1Z8LffXquSM=v6DYcHP_m4Q@mail.gmail.com>
References: <CAK7LNARbD262isY7yOgQKAcbWQHV+3dsoRjtu6S+qUpPr98qSQ@mail.gmail.com>
 <b7dd01e6-ddcd-a34a-c26c-05ce6ae4015a@arm.com>
 <CAK7LNAQ3FbicgoV1Q70T2gZQS0j1Z8LffXquSM=v6DYcHP_m4Q@mail.gmail.com>
Message-ID: <894e8867-57b5-39ab-4dbd-3761d485cb62@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/17 18:06, Masahiro Yamada wrote:
> Hi Robin,
> 
> 
> 2017-03-08 20:15 GMT+09:00 Robin Murphy <robin.murphy@arm.com>:
>> On 08/03/17 10:59, Masahiro Yamada wrote:
>>> Hi experts,
>>>
>>> I have a question about
>>> how to allocate DMA-safe buffer.
>>>
>>>
>>> In my understanding, kmalloc() returns
>>> memory with DMA safe alignment
>>> in order to avoid cache-sharing problem when used for DMA.
>>>
>>> The alignment is decided by ARCH_DMA_MINALIGN.
>>> For example, on modern ARM 32bit boards, this value is typically 64.
>>> So, memory returned by kmalloc() has
>>> at least 64 byte alignment.
>>>
>>>
>>> On the other hand, devm_kmalloc() does not return
>>> enough-aligned memory.
>>
>> How so? If anything returned by kmalloc() is guaranteed to occupy some
>> multiple of ARCH_DMA_MINALIGN bytes in order to avoid two allocations
>> falling into the same cache line, I don't see how stealing the first 16
>> bytes *of a single allocation* could make it start sharing cache lines
>> with another? :/
> 
> I just thought of traverse of the linked list of devres_node
> on a different thread, but it should not happen.
> 
> Please forget my stupid question.

On the contrary, my apologies for overlooking the subtlety here and
speaking too soon. It's not strictly the alignment of the allocation
that's at issue, it's more that the streaming DMA notion of "ownership"
of that particular allocation can be unwittingly violated by other agents.

Another thread traversing the list isn't actually a problem, as it's
effectively no different from the cache itself doing a speculative
prefetch, which we have to accommodate anyway. However, there could in
theory be a potential data loss if the devres node is *modified* (e.g.
an adjacent entry is added or removed) whilst the buffer is mapped for
DMA_FROM_DEVICE.

Now, as Russell says, doing streaming DMA on a managed allocation tied
to the device's lifetime doesn't make a great deal of sense, and if
you're allocating or freeing device-lifetime resources *while DMA is
active* you're almost certainly doing something wrong, so thankfully I
don't think we should need to worry about this in practice.

Looking at the Denali driver specifically, it does indeed look a bit
bogus. At least it's not doing DMA with a uint8-aligned array in the
middle of a live structure as it apparently once did, but in terms of
how it's actually using that buffer I think something along the lines of
the below would be appropriate (if anyone wants to try spinning a proper
patch out of it, feel free - I have no way of testing and am not
familiar with MTD in general).

Robin.

----->8-----
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 73b9d4e2dca0..b2b4650a3923 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1046,8 +1046,6 @@ static int write_page(struct mtd_info *mtd, struct
nand_chip *chip,
 			mtd->oobsize);
 	}

-	dma_sync_single_for_device(denali->dev, addr, size, DMA_TO_DEVICE);
-
 	clear_interrupts(denali);
 	denali_enable_dma(denali, true);

@@ -1063,7 +1061,6 @@ static int write_page(struct mtd_info *mtd, struct
nand_chip *chip,
 	}

 	denali_enable_dma(denali, false);
-	dma_sync_single_for_cpu(denali->dev, addr, size, DMA_TO_DEVICE);

 	return 0;
 }
@@ -1139,7 +1136,6 @@ static int denali_read_page(struct mtd_info *mtd,
struct nand_chip *chip,
 	setup_ecc_for_xfer(denali, true, false);

 	denali_enable_dma(denali, true);
-	dma_sync_single_for_device(denali->dev, addr, size, DMA_FROM_DEVICE);

 	clear_interrupts(denali);
 	denali_setup_dma(denali, DENALI_READ);
@@ -1147,8 +1143,6 @@ static int denali_read_page(struct mtd_info *mtd,
struct nand_chip *chip,
 	/* wait for operation to complete */
 	irq_status = wait_for_irq(denali, irq_mask);

-	dma_sync_single_for_cpu(denali->dev, addr, size, DMA_FROM_DEVICE);
-
 	memcpy(buf, denali->buf.buf, mtd->writesize);

 	check_erased_page = handle_ecc(denali, buf, irq_status, &max_bitflips);
@@ -1186,16 +1180,12 @@ static int denali_read_page_raw(struct mtd_info
*mtd, struct nand_chip *chip,
 	setup_ecc_for_xfer(denali, false, true);
 	denali_enable_dma(denali, true);

-	dma_sync_single_for_device(denali->dev, addr, size, DMA_FROM_DEVICE);
-
 	clear_interrupts(denali);
 	denali_setup_dma(denali, DENALI_READ);

 	/* wait for operation to complete */
 	wait_for_irq(denali, irq_mask);

-	dma_sync_single_for_cpu(denali->dev, addr, size, DMA_FROM_DEVICE);
-
 	denali_enable_dma(denali, false);

 	memcpy(buf, denali->buf.buf, mtd->writesize);
@@ -1466,16 +1456,6 @@ int denali_init(struct denali_nand_info *denali)
 	if (ret)
 		goto failed_req_irq;

-	/* allocate the right size buffer now */
-	devm_kfree(denali->dev, denali->buf.buf);
-	denali->buf.buf = devm_kzalloc(denali->dev,
-			     mtd->writesize + mtd->oobsize,
-			     GFP_KERNEL);
-	if (!denali->buf.buf) {
-		ret = -ENOMEM;
-		goto failed_req_irq;
-	}
-
 	/* Is 32-bit DMA supported? */
 	ret = dma_set_mask(denali->dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -1483,12 +1463,14 @@ int denali_init(struct denali_nand_info *denali)
 		goto failed_req_irq;
 	}

-	denali->buf.dma_buf = dma_map_single(denali->dev, denali->buf.buf,
-			     mtd->writesize + mtd->oobsize,
-			     DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(denali->dev, denali->buf.dma_buf)) {
-		dev_err(denali->dev, "Failed to map DMA buffer\n");
-		ret = -EIO;
+	/* allocate the right size buffer now */
+	devm_kfree(denali->dev, denali->buf.buf);
+	denali->buf.buf = dmam_alloc_coherent(denali->dev,
+					      mtd->writesize + mtd->oobsize,
+					      &denali->buf.dma_buf,
+					      GFP_KERNEL);
+	if (!denali->buf.buf) {
+		ret = -ENOMEM;
 		goto failed_req_irq;
 	}

@@ -1598,7 +1580,5 @@ void denali_remove(struct denali_nand_info *denali)

 	nand_release(mtd);
 	denali_irq_cleanup(denali->irq, denali);
-	dma_unmap_single(denali->dev, denali->buf.dma_buf, bufsize,
-			 DMA_BIDIRECTIONAL);
 }
 EXPORT_SYMBOL(denali_remove);
