From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Dec 2012 17:12:32 +1100
Subject: linux-next: manual merge of the arm-soc tree with the slave_dma and
 tree
Message-ID: <20121203171232.04772e84d18948bbbcafdeef@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/dma/mv_xor.c between commit d51e88b99533 ("dma: Convert dev_printk
(KERN_<LEVEL> to dev_<level>(") from the slave-dma tree, commits
a7d6e3ec28bb ("dma: remove use of __devexit_p") and 463a1f8b3cee ("dma:
remove use of __devinit") from the driver-core tree and various commits
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/dma/mv_xor.c
index 3ef4095,9659e58..0000000
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@@ -206,8 -209,8 +209,8 @@@ static void mv_set_mode(struct mv_xor_c
  		op_mode = XOR_OPERATION_MODE_MEMSET;
  		break;
  	default:
- 		dev_err(chan->device->common.dev,
+ 		dev_err(mv_chan_to_devp(chan),
 -			"error: unsupported operation %d.\n",
 +			"error: unsupported operation %d\n",
  			type);
  		BUG();
  		return;
@@@ -828,22 -828,28 +828,28 @@@ static void mv_dump_xor_regs(struct mv_
  	u32 val;
  
  	val = __raw_readl(XOR_CONFIG(chan));
- 	dev_err(chan->device->common.dev, "config       0x%08x\n", val);
+ 	dev_err(mv_chan_to_devp(chan),
 -		"config       0x%08x.\n", val);
++		"config       0x%08x\n", val);
  
  	val = __raw_readl(XOR_ACTIVATION(chan));
- 	dev_err(chan->device->common.dev, "activation   0x%08x\n", val);
+ 	dev_err(mv_chan_to_devp(chan),
 -		"activation   0x%08x.\n", val);
++		"activation   0x%08x\n", val);
  
  	val = __raw_readl(XOR_INTR_CAUSE(chan));
- 	dev_err(chan->device->common.dev, "intr cause   0x%08x\n", val);
+ 	dev_err(mv_chan_to_devp(chan),
 -		"intr cause   0x%08x.\n", val);
++		"intr cause   0x%08x\n", val);
  
  	val = __raw_readl(XOR_INTR_MASK(chan));
- 	dev_err(chan->device->common.dev, "intr mask    0x%08x\n", val);
+ 	dev_err(mv_chan_to_devp(chan),
 -		"intr mask    0x%08x.\n", val);
++		"intr mask    0x%08x\n", val);
  
  	val = __raw_readl(XOR_ERROR_CAUSE(chan));
- 	dev_err(chan->device->common.dev, "error cause  0x%08x\n", val);
+ 	dev_err(mv_chan_to_devp(chan),
 -		"error cause  0x%08x.\n", val);
++		"error cause  0x%08x\n", val);
  
  	val = __raw_readl(XOR_ERROR_ADDR(chan));
- 	dev_err(chan->device->common.dev, "error addr   0x%08x\n", val);
+ 	dev_err(mv_chan_to_devp(chan),
 -		"error addr   0x%08x.\n", val);
++		"error addr   0x%08x\n", val);
  }
  
  static void mv_xor_err_interrupt_handler(struct mv_xor_chan *chan,
@@@ -855,8 -861,8 +861,8 @@@
  	     return;
  	}
  
- 	dev_err(chan->device->common.dev,
+ 	dev_err(mv_chan_to_devp(chan),
 -		"error on chan %d. intr cause 0x%08x.\n",
 +		"error on chan %d. intr cause 0x%08x\n",
  		chan->idx, intr_cause);
  
  	mv_dump_xor_regs(chan);
@@@ -895,7 -901,7 +901,7 @@@ static void mv_xor_issue_pending(struc
   */
  #define MV_XOR_TEST_SIZE 2000
  
- static int mv_xor_memcpy_self_test(struct mv_xor_device *device)
 -static int __devinit mv_xor_memcpy_self_test(struct mv_xor_chan *mv_chan)
++static int mv_xor_memcpy_self_test(struct mv_xor_chan *mv_chan)
  {
  	int i;
  	void *src, *dest;
@@@ -969,8 -970,8 +970,8 @@@ out
  }
  
  #define MV_XOR_NUM_SRC_TEST 4 /* must be <= 15 */
 -static int __devinit
 +static int
- mv_xor_xor_self_test(struct mv_xor_device *device)
+ mv_xor_xor_self_test(struct mv_xor_chan *mv_chan)
  {
  	int i, src_idx;
  	struct page *dest;
@@@ -1199,26 -1188,28 +1187,27 @@@ mv_xor_channel_add(struct mv_xor_devic
  	}
  
  	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
- 		ret = mv_xor_xor_self_test(adev);
+ 		ret = mv_xor_xor_self_test(mv_chan);
  		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
  		if (ret)
- 			goto err_free_dma;
+ 			goto err_free_irq;
  	}
  
 -	dev_info(&pdev->dev, "Marvell XOR: "
 -	  "( %s%s%s%s)\n",
 -	  dma_has_cap(DMA_XOR, dma_dev->cap_mask) ? "xor " : "",
 -	  dma_has_cap(DMA_MEMSET, dma_dev->cap_mask)  ? "fill " : "",
 -	  dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask) ? "cpy " : "",
 -	  dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask) ? "intr " : "");
 +	dev_info(&pdev->dev, "Marvell XOR: ( %s%s%s%s)\n",
 +		 dma_has_cap(DMA_XOR, dma_dev->cap_mask) ? "xor " : "",
 +		 dma_has_cap(DMA_MEMSET, dma_dev->cap_mask)  ? "fill " : "",
 +		 dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask) ? "cpy " : "",
 +		 dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask) ? "intr " : "");
  
  	dma_async_device_register(dma_dev);
- 	goto out;
+ 	return mv_chan;
  
+ err_free_irq:
+ 	free_irq(mv_chan->irq, mv_chan);
   err_free_dma:
- 	dma_free_coherent(&adev->pdev->dev, plat_data->pool_size,
- 			adev->dma_desc_pool_virt, adev->dma_desc_pool);
-  out:
- 	return ret;
+ 	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
+ 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
+ 	return ERR_PTR(ret);
  }
  
  static void
@@@ -1250,27 -1241,22 +1239,22 @@@ mv_xor_conf_mbus_windows(struct mv_xor_
  
  	writel(win_enable, base + WINDOW_BAR_ENABLE(0));
  	writel(win_enable, base + WINDOW_BAR_ENABLE(1));
+ 	writel(0, base + WINDOW_OVERRIDE_CTRL(0));
+ 	writel(0, base + WINDOW_OVERRIDE_CTRL(1));
  }
  
- static struct platform_driver mv_xor_driver = {
- 	.probe		= mv_xor_probe,
- 	.remove		= mv_xor_remove,
- 	.driver		= {
- 		.owner	= THIS_MODULE,
- 		.name	= MV_XOR_NAME,
- 	},
- };
- 
- static int mv_xor_shared_probe(struct platform_device *pdev)
 -static int __devinit mv_xor_probe(struct platform_device *pdev)
++static int mv_xor_probe(struct platform_device *pdev)
  {
  	const struct mbus_dram_target_info *dram;
- 	struct mv_xor_shared_private *msp;
+ 	struct mv_xor_device *xordev;
+ 	struct mv_xor_platform_data *pdata = pdev->dev.platform_data;
  	struct resource *res;
+ 	int i, ret;
  
- 	dev_notice(&pdev->dev, "Marvell shared XOR driver\n");
+ 	dev_notice(&pdev->dev, "Marvell XOR driver\n");
  
- 	msp = devm_kzalloc(&pdev->dev, sizeof(*msp), GFP_KERNEL);
- 	if (!msp)
+ 	xordev = devm_kzalloc(&pdev->dev, sizeof(*xordev), GFP_KERNEL);
+ 	if (!xordev)
  		return -ENOMEM;
  
  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121203/33bc77f5/attachment.sig>
