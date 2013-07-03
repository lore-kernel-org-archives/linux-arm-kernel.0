From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 04 Jul 2013 00:58:10 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130703222315.GK16785@1wt.eu> (Willy Tarreau's message of "Thu,
 4 Jul 2013 00:23:15 +0200")
References: <20130702153825.139a93a5@skate>
 <20130702134421.GC17110@titan.lakedaemon.net>
 <87obakho6d.fsf@natisbad.org>
 <20130702174111.GF17110@titan.lakedaemon.net>
 <87y59ows4n.fsf@natisbad.org> <20130702220936.GC10215@1wt.eu>
 <20130703202105.GE27003@titan.lakedaemon.net>
 <20130703203541.GI16785@1wt.eu>
 <20130703204451.GF27003@titan.lakedaemon.net>
 <20130703211450.GJ16785@1wt.eu> <20130703222315.GK16785@1wt.eu>
Message-ID: <8761wrp7y5.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy,

Willy Tarreau <w@1wt.eu> writes:

> The patch it too large (150kB), last time I received a warning from the ML
> because of its size.
>
> [snip]
>
> Feel free to host this driver anywhere if you like, I don't have the
> time to maintain it, and I don't want to see it merged into the kernel,
> we have enough crap and this one certainly qualifies as such.

;-)

> Oh last important point, I found it in the 2.6.35.9-LSP-1.0.2_gw patch.
> If someone finds a more recent one in a more recent kernel, it might be
> worth comparing them.

The version in Netgear kernel (a 3.0.56, 25/Apr/2012 KW40 LSP release
3.1.0-NQ) is almost identical to the one in mirabox 2.6.35 kernel
(24/Nov/2011, KW40 LSP release 1.0.2-NQ) if you remove the fixes for
trailing spaces and tabs: 


@@ -1618,7 +1618,9 @@
 		ret = -ENXIO;
 		goto fail_free_irq;
 	}
-	if (mtd_has_partitions()) {
+
+
+#ifdef CONFIG_MTD_CMDLINE_PARTS
 		if (mtd_has_cmdlinepart()) {
 			static const char *probes[] = { "cmdlinepart", NULL };
 			struct mtd_partition *parts;
@@ -1627,12 +1629,11 @@
 			nr_parts = parse_mtd_partitions(mtd, probes, &parts, 0);
 
 			if (nr_parts)
-				return add_mtd_partitions(mtd, parts, nr_parts);
+				return mtd_device_register(mtd, parts, nr_parts);
 		}
-		return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
-	}
-
-	return add_mtd_device(mtd) == 1 ? -ENODEV : 0;
+		return mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
+#endif
+		return (mtd_device_register(mtd, pdata->parts, pdata->nr_parts));
 
 fail_free_irq:
 	free_irq(IRQ_AURORA_NFC, info);
@@ -1661,10 +1662,6 @@
 
 	platform_set_drvdata(pdev, NULL);
 
-	del_mtd_device(mtd);
-#ifdef CONFIG_MTD_PARTITIONS
-	del_mtd_partitions(mtd);
-#endif
 	free_irq(IRQ_AURORA_NFC, info);
 	if (info->use_dma) {
 		dma_free_writecombine(&pdev->dev, info->data_buff_size,
@@ -1675,7 +1672,10 @@
 	clk_disable(info->clk);
 	clk_put(info->clk);
 #endif
-	kfree(mtd);
+	if (mtd) {
+		mtd_device_unregister(mtd);
+		kfree(mtd);
+	}
 	return 0;
 }
 
