From: federico.vaga@gmail.com (Federico Vaga)
Date: Thu, 10 Jan 2013 13:46:48 +0100
Subject: [PATCH v5 1/3] videobuf2-dma-contig: user can specify GFP flags
In-Reply-To: <1357822010-30419-1-git-send-email-federico.vaga@gmail.com>
References: <1357822010-30419-1-git-send-email-federico.vaga@gmail.com>
Message-ID: <1357822010-30419-2-git-send-email-federico.vaga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is useful when you need to specify specific GFP flags during memory
allocation (e.g. GFP_DMA).

Signed-off-by: Federico Vaga <federico.vaga@gmail.com>
---
 drivers/media/platform/blackfin/bfin_capture.c           | 2 +-
 drivers/media/platform/coda.c                            | 2 +-
 drivers/media/platform/davinci/vpbe_display.c            | 2 +-
 drivers/media/platform/davinci/vpif_capture.c            | 4 ++--
 drivers/media/platform/davinci/vpif_display.c            | 2 +-
 drivers/media/platform/exynos-gsc/gsc-core.c             | 2 +-
 drivers/media/platform/m2m-deinterlace.c                 | 2 +-
 drivers/media/platform/marvell-ccic/mcam-core.c          | 2 +-
 drivers/media/platform/mx2_emmaprp.c                     | 2 +-
 drivers/media/platform/s3c-camif/camif-core.c            | 2 +-
 drivers/media/platform/s5p-fimc/fimc-core.c              | 2 +-
 drivers/media/platform/s5p-fimc/fimc-lite.c              | 2 +-
 drivers/media/platform/s5p-g2d/g2d.c                     | 2 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.c              | 2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c                 | 4 ++--
 drivers/media/platform/s5p-tv/mixer_video.c              | 2 +-
 drivers/media/platform/sh_veu.c                          | 2 +-
 drivers/media/platform/soc_camera/atmel-isi.c            | 2 +-
 drivers/media/platform/soc_camera/mx2_camera.c           | 2 +-
 drivers/media/platform/soc_camera/mx3_camera.c           | 2 +-
 drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c | 2 +-
 drivers/media/v4l2-core/videobuf2-dma-contig.c           | 7 +++++--
 drivers/staging/media/davinci_vpfe/vpfe_video.c          | 2 +-
 drivers/staging/media/dt3155v4l/dt3155v4l.c              | 2 +-
 include/media/videobuf2-dma-contig.h                     | 2 +-
 25 file modificati, 31 inserzioni(+), 28 rimozioni(-)

diff --git a/drivers/media/platform/blackfin/bfin_capture.c b/drivers/media/platform/blackfin/bfin_capture.c
index aa9f846..57e911f 100644
--- a/drivers/media/platform/blackfin/bfin_capture.c
+++ b/drivers/media/platform/blackfin/bfin_capture.c
@@ -978,7 +978,7 @@ static int __devinit bcap_probe(struct platform_device *pdev)
 	}
 	bcap_dev->ppi->priv = bcap_dev;
 
-	bcap_dev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	bcap_dev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(bcap_dev->alloc_ctx)) {
 		ret = PTR_ERR(bcap_dev->alloc_ctx);
 		goto err_free_ppi;
diff --git a/drivers/media/platform/coda.c b/drivers/media/platform/coda.c
index 2721f83..abe547d 100644
--- a/drivers/media/platform/coda.c
+++ b/drivers/media/platform/coda.c
@@ -1846,7 +1846,7 @@ static void coda_fw_callback(const struct firmware *fw, void *context)
 	snprintf(dev->vfd.name, sizeof(dev->vfd.name), "%s", CODA_NAME);
 	video_set_drvdata(&dev->vfd, dev);
 
-	dev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	dev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(dev->alloc_ctx)) {
 		v4l2_err(&dev->v4l2_dev, "Failed to alloc vb2 context\n");
 		return;
diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
index d078738..362a7bc 100644
--- a/drivers/media/platform/davinci/vpbe_display.c
+++ b/drivers/media/platform/davinci/vpbe_display.c
@@ -1391,7 +1391,7 @@ static int vpbe_display_reqbufs(struct file *file, void *priv,
 		return -EBUSY;
 	}
 	/* Initialize videobuf queue as per the buffer type */
-	layer->alloc_ctx = vb2_dma_contig_init_ctx(vpbe_dev->pdev);
+	layer->alloc_ctx = vb2_dma_contig_init_ctx(vpbe_dev->pdev, GFP_KERNEL);
 	if (IS_ERR(layer->alloc_ctx)) {
 		v4l2_err(&vpbe_dev->v4l2_dev, "Failed to get the context\n");
 		return PTR_ERR(layer->alloc_ctx);
diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index 5892d2b..9d80d24 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1023,7 +1023,7 @@ static int vpif_reqbufs(struct file *file, void *priv,
 		return -EBUSY;
 
 	/* Initialize videobuf2 queue as per the buffer type */
-	common->alloc_ctx = vb2_dma_contig_init_ctx(vpif_dev);
+	common->alloc_ctx = vb2_dma_contig_init_ctx(vpif_dev, GFP_KERNEL);
 	if (IS_ERR(common->alloc_ctx)) {
 		vpif_err("Failed to get the context\n");
 		return PTR_ERR(common->alloc_ctx);
@@ -1039,7 +1039,7 @@ static int vpif_reqbufs(struct file *file, void *priv,
 	ret = vb2_queue_init(q);
 	if (ret) {
 		vpif_err("vpif_capture: vb2_queue_init() failed\n");
-		vb2_dma_contig_cleanup_ctx(common->alloc_ctx);
+		vb2_dma_contig_cleanup_ctx(common->alloc_ctx, GFP_KERNEL);
 		return ret;
 	}
 	/* Set io allowed member of file handle to TRUE */
diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
index dd249c9..f63f81e 100644
--- a/drivers/media/platform/davinci/vpif_display.c
+++ b/drivers/media/platform/davinci/vpif_display.c
@@ -989,7 +989,7 @@ static int vpif_reqbufs(struct file *file, void *priv,
 		field = V4L2_VBI_INTERLACED;
 	}
 	/* Initialize videobuf2 queue as per the buffer type */
-	common->alloc_ctx = vb2_dma_contig_init_ctx(vpif_dev);
+	common->alloc_ctx = vb2_dma_contig_init_ctx(vpif_dev, GFP_KERNEL);
 	if (IS_ERR(common->alloc_ctx)) {
 		vpif_err("Failed to get the context\n");
 		return PTR_ERR(common->alloc_ctx);
diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index ae885c7..4f2961a 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1133,7 +1133,7 @@ static int gsc_probe(struct platform_device *pdev)
 		goto err_m2m;
 
 	/* Initialize continious memory allocator */
-	gsc->alloc_ctx = vb2_dma_contig_init_ctx(dev);
+	gsc->alloc_ctx = vb2_dma_contig_init_ctx(dev, GFP_KERNEL);
 	if (IS_ERR(gsc->alloc_ctx)) {
 		ret = PTR_ERR(gsc->alloc_ctx);
 		goto err_pm;
diff --git a/drivers/media/platform/m2m-deinterlace.c b/drivers/media/platform/m2m-deinterlace.c
index 6c4db9b..e065be5 100644
--- a/drivers/media/platform/m2m-deinterlace.c
+++ b/drivers/media/platform/m2m-deinterlace.c
@@ -1043,7 +1043,7 @@ static int deinterlace_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcdev);
 
-	pcdev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	pcdev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(pcdev->alloc_ctx)) {
 		v4l2_err(&pcdev->v4l2_dev, "Failed to alloc vb2 context\n");
 		ret = PTR_ERR(pcdev->alloc_ctx);
diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/media/platform/marvell-ccic/mcam-core.c
index 7012913f..c79c3e6 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.c
+++ b/drivers/media/platform/marvell-ccic/mcam-core.c
@@ -1104,7 +1104,7 @@ static int mcam_setup_vb2(struct mcam_camera *cam)
 #ifdef MCAM_MODE_DMA_CONTIG
 		vq->ops = &mcam_vb2_ops;
 		vq->mem_ops = &vb2_dma_contig_memops;
-		cam->vb_alloc_ctx = vb2_dma_contig_init_ctx(cam->dev);
+		cam->vb_alloc_ctx = vb2_dma_contig_init_ctx(cam->dev, GFP_KERNEL);
 		vq->io_modes = VB2_MMAP | VB2_USERPTR;
 		cam->dma_setup = mcam_ctlr_dma_contig;
 		cam->frame_complete = mcam_dma_contig_done;
diff --git a/drivers/media/platform/mx2_emmaprp.c b/drivers/media/platform/mx2_emmaprp.c
index 6b155d7..eeb7898 100644
--- a/drivers/media/platform/mx2_emmaprp.c
+++ b/drivers/media/platform/mx2_emmaprp.c
@@ -956,7 +956,7 @@ static int emmaprp_probe(struct platform_device *pdev)
 		goto rel_vdev;
 	}
 
-	pcdev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	pcdev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(pcdev->alloc_ctx)) {
 		v4l2_err(&pcdev->v4l2_dev, "Failed to alloc vb2 context\n");
 		ret = PTR_ERR(pcdev->alloc_ctx);
diff --git a/drivers/media/platform/s3c-camif/camif-core.c b/drivers/media/platform/s3c-camif/camif-core.c
index 37c9b6f..d39986d 100644
--- a/drivers/media/platform/s3c-camif/camif-core.c
+++ b/drivers/media/platform/s3c-camif/camif-core.c
@@ -476,7 +476,7 @@ static int s3c_camif_probe(struct platform_device *pdev)
 		goto err_pm;
 
 	/* Initialize contiguous memory allocator */
-	camif->alloc_ctx = vb2_dma_contig_init_ctx(dev);
+	camif->alloc_ctx = vb2_dma_contig_init_ctx(dev, GFP_KERNEL);
 	if (IS_ERR(camif->alloc_ctx)) {
 		ret = PTR_ERR(camif->alloc_ctx);
 		goto err_alloc;
diff --git a/drivers/media/platform/s5p-fimc/fimc-core.c b/drivers/media/platform/s5p-fimc/fimc-core.c
index 2a1558a..9b80388 100644
--- a/drivers/media/platform/s5p-fimc/fimc-core.c
+++ b/drivers/media/platform/s5p-fimc/fimc-core.c
@@ -944,7 +944,7 @@ static int fimc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_sd;
 	/* Initialize contiguous memory allocator */
-	fimc->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	fimc->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(fimc->alloc_ctx)) {
 		ret = PTR_ERR(fimc->alloc_ctx);
 		goto err_pm;
diff --git a/drivers/media/platform/s5p-fimc/fimc-lite.c b/drivers/media/platform/s5p-fimc/fimc-lite.c
index 765b8e4..4d7f562 100644
--- a/drivers/media/platform/s5p-fimc/fimc-lite.c
+++ b/drivers/media/platform/s5p-fimc/fimc-lite.c
@@ -1542,7 +1542,7 @@ static int __devinit fimc_lite_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_sd;
 
-	fimc->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	fimc->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(fimc->alloc_ctx)) {
 		ret = PTR_ERR(fimc->alloc_ctx);
 		goto err_pm;
diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/s5p-g2d/g2d.c
index 1bfbc32..57bbd76 100644
--- a/drivers/media/platform/s5p-g2d/g2d.c
+++ b/drivers/media/platform/s5p-g2d/g2d.c
@@ -755,7 +755,7 @@ static int g2d_probe(struct platform_device *pdev)
 		goto put_clk_gate;
 	}
 
-	dev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	dev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(dev->alloc_ctx)) {
 		ret = PTR_ERR(dev->alloc_ctx);
 		goto unprep_clk_gate;
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index 17983c4..5e07a50 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -1370,7 +1370,7 @@ static int s5p_jpeg_probe(struct platform_device *pdev)
 		goto device_register_rollback;
 	}
 
-	jpeg->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	jpeg->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(jpeg->alloc_ctx)) {
 		v4l2_err(&jpeg->v4l2_dev, "Failed to init memory allocator\n");
 		ret = PTR_ERR(jpeg->alloc_ctx);
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 3afe879..dc7cb91 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1097,12 +1097,12 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	dev->alloc_ctx[0] = vb2_dma_contig_init_ctx(dev->mem_dev_l);
+	dev->alloc_ctx[0] = vb2_dma_contig_init_ctx(dev->mem_dev_l, GFP_KERNEL);
 	if (IS_ERR_OR_NULL(dev->alloc_ctx[0])) {
 		ret = PTR_ERR(dev->alloc_ctx[0]);
 		goto err_res;
 	}
-	dev->alloc_ctx[1] = vb2_dma_contig_init_ctx(dev->mem_dev_r);
+	dev->alloc_ctx[1] = vb2_dma_contig_init_ctx(dev->mem_dev_r, GFP_KERNEL);
 	if (IS_ERR_OR_NULL(dev->alloc_ctx[1])) {
 		ret = PTR_ERR(dev->alloc_ctx[1]);
 		goto err_mem_init_ctx_1;
diff --git a/drivers/media/platform/s5p-tv/mixer_video.c b/drivers/media/platform/s5p-tv/mixer_video.c
index 7379e77..3ac2929 100644
--- a/drivers/media/platform/s5p-tv/mixer_video.c
+++ b/drivers/media/platform/s5p-tv/mixer_video.c
@@ -79,7 +79,7 @@ int __devinit mxr_acquire_video(struct mxr_device *mdev,
 		goto fail;
 	}
 
-	mdev->alloc_ctx = vb2_dma_contig_init_ctx(mdev->dev);
+	mdev->alloc_ctx = vb2_dma_contig_init_ctx(mdev->dev, GFP_KERNEL);
 	if (IS_ERR_OR_NULL(mdev->alloc_ctx)) {
 		mxr_err(mdev, "could not acquire vb2 allocator\n");
 		goto fail_v4l2_dev;
diff --git a/drivers/media/platform/sh_veu.c b/drivers/media/platform/sh_veu.c
index a018676..f293706 100644
--- a/drivers/media/platform/sh_veu.c
+++ b/drivers/media/platform/sh_veu.c
@@ -1181,7 +1181,7 @@ static int __devinit sh_veu_probe(struct platform_device *pdev)
 
 	vdev = &veu->vdev;
 
-	veu->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	veu->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(veu->alloc_ctx)) {
 		ret = PTR_ERR(veu->alloc_ctx);
 		goto einitctx;
diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index c8d748a..62843e4 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -1000,7 +1000,7 @@ static int __devinit atmel_isi_probe(struct platform_device *pdev)
 		list_add(&isi->dma_desc[i].list, &isi->dma_desc_head);
 	}
 
-	isi->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	isi->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(isi->alloc_ctx)) {
 		ret = PTR_ERR(isi->alloc_ctx);
 		goto err_alloc_ctx;
diff --git a/drivers/media/platform/soc_camera/mx2_camera.c b/drivers/media/platform/soc_camera/mx2_camera.c
index 28d5c84..5a58c89 100644
--- a/drivers/media/platform/soc_camera/mx2_camera.c
+++ b/drivers/media/platform/soc_camera/mx2_camera.c
@@ -1866,7 +1866,7 @@ static int __devinit mx2_camera_probe(struct platform_device *pdev)
 	if (is_imx25_camera(pcdev))
 		pcdev->soc_host.capabilities = SOCAM_HOST_CAP_STRIDE;
 
-	pcdev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	pcdev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(pcdev->alloc_ctx)) {
 		err = PTR_ERR(pcdev->alloc_ctx);
 		goto eallocctx;
diff --git a/drivers/media/platform/soc_camera/mx3_camera.c b/drivers/media/platform/soc_camera/mx3_camera.c
index 574d125..b0d19f1 100644
--- a/drivers/media/platform/soc_camera/mx3_camera.c
+++ b/drivers/media/platform/soc_camera/mx3_camera.c
@@ -1218,7 +1218,7 @@ static int __devinit mx3_camera_probe(struct platform_device *pdev)
 	soc_host->v4l2_dev.dev	= &pdev->dev;
 	soc_host->nr		= pdev->id;
 
-	mx3_cam->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	mx3_cam->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(mx3_cam->alloc_ctx)) {
 		err = PTR_ERR(mx3_cam->alloc_ctx);
 		goto eallocctx;
diff --git a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
index 9f02104..73243ca 100644
--- a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
+++ b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
@@ -2154,7 +2154,7 @@ static int __devinit sh_mobile_ceu_probe(struct platform_device *pdev)
 	pcdev->ici.ops = &sh_mobile_ceu_host_ops;
 	pcdev->ici.capabilities = SOCAM_HOST_CAP_STRIDE;
 
-	pcdev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	pcdev->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev, GFP_KERNEL);
 	if (IS_ERR(pcdev->alloc_ctx)) {
 		err = PTR_ERR(pcdev->alloc_ctx);
 		goto exit_free_clk;
diff --git a/drivers/media/v4l2-core/videobuf2-dma-contig.c b/drivers/media/v4l2-core/videobuf2-dma-contig.c
index 10beaee..00f1b85 100644
--- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
+++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
@@ -23,6 +23,7 @@
 
 struct vb2_dc_conf {
 	struct device		*dev;
+	gfp_t				mem_flags;
 };
 
 struct vb2_dc_buf {
@@ -165,7 +166,8 @@ static void *vb2_dc_alloc(void *alloc_ctx, unsigned long size)
 	/* align image size to PAGE_SIZE */
 	size = PAGE_ALIGN(size);
 
-	buf->vaddr = dma_alloc_coherent(dev, size, &buf->dma_addr, GFP_KERNEL);
+	buf->vaddr = dma_alloc_coherent(dev, size, &buf->dma_addr,
+									GFP_KERNEL | conf->mem_flags);
 	if (!buf->vaddr) {
 		dev_err(dev, "dma_alloc_coherent of size %ld failed\n", size);
 		kfree(buf);
@@ -751,7 +753,7 @@ const struct vb2_mem_ops vb2_dma_contig_memops = {
 };
 EXPORT_SYMBOL_GPL(vb2_dma_contig_memops);
 
-void *vb2_dma_contig_init_ctx(struct device *dev)
+void *vb2_dma_contig_init_ctx(struct device *dev, gfp_t mem_flags)
 {
 	struct vb2_dc_conf *conf;
 
@@ -760,6 +762,7 @@ void *vb2_dma_contig_init_ctx(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 
 	conf->dev = dev;
+	conf->mem_flags = mem_flags;
 
 	return conf;
 }
diff --git a/drivers/staging/media/davinci_vpfe/vpfe_video.c b/drivers/staging/media/davinci_vpfe/vpfe_video.c
index 99ccbeb..4ab10ce 100644
--- a/drivers/staging/media/davinci_vpfe/vpfe_video.c
+++ b/drivers/staging/media/davinci_vpfe/vpfe_video.c
@@ -1315,7 +1315,7 @@ static int vpfe_reqbufs(struct file *file, void *priv,
 	video->memory = req_buf->memory;
 
 	/* Initialize videobuf2 queue as per the buffer type */
-	video->alloc_ctx = vb2_dma_contig_init_ctx(vpfe_dev->pdev);
+	video->alloc_ctx = vb2_dma_contig_init_ctx(vpfe_dev->pdev, GFP_KERNEL);
 	if (IS_ERR(video->alloc_ctx)) {
 		v4l2_err(&vpfe_dev->v4l2_dev, "Failed to get the context\n");
 		return PTR_ERR(video->alloc_ctx);
diff --git a/drivers/staging/media/dt3155v4l/dt3155v4l.c b/drivers/staging/media/dt3155v4l/dt3155v4l.c
index e33b7f5..4907f39 100644
--- a/drivers/staging/media/dt3155v4l/dt3155v4l.c
+++ b/drivers/staging/media/dt3155v4l/dt3155v4l.c
@@ -232,7 +232,7 @@ dt3155_queue_setup(struct vb2_queue *q, const struct v4l2_format *fmt,
 	sizes[0] = img_width * img_height;
 	if (pd->q->alloc_ctx[0])
 		return 0;
-	ret = vb2_dma_contig_init_ctx(&pd->pdev->dev);
+	ret = vb2_dma_contig_init_ctx(&pd->pdev->dev, GFP_KERNEL);
 	if (IS_ERR(ret))
 		return PTR_ERR(ret);
 	pd->q->alloc_ctx[0] = ret;
diff --git a/include/media/videobuf2-dma-contig.h b/include/media/videobuf2-dma-contig.h
index 8197f87..8d5a5a3 100644
--- a/include/media/videobuf2-dma-contig.h
+++ b/include/media/videobuf2-dma-contig.h
@@ -24,7 +24,7 @@ vb2_dma_contig_plane_dma_addr(struct vb2_buffer *vb, unsigned int plane_no)
 	return *addr;
 }
 
-void *vb2_dma_contig_init_ctx(struct device *dev);
+void *vb2_dma_contig_init_ctx(struct device *dev, gfp_t mem_flags);
 void vb2_dma_contig_cleanup_ctx(void *alloc_ctx);
 
 extern const struct vb2_mem_ops vb2_dma_contig_memops;
-- 
1.7.11.7
