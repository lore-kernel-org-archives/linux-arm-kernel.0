From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 8 Dec 2015 16:52:41 +0000
Subject: [PATCH v5 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <56670477.5000301@arm.com>
References: <1449490265-6752-1-git-send-email-Liviu.Dudau@arm.com>
 <1449490265-6752-3-git-send-email-Liviu.Dudau@arm.com>
 <56670477.5000301@arm.com>
Message-ID: <20151208165241.GN972@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 04:25:27PM +0000, Robin Murphy wrote:
> Hi Liviu,
> 
> On 07/12/15 12:11, Liviu Dudau wrote:
> >The HDLCD controller is a display controller that supports resolutions
> >up to 4096x4096 pixels. It is present on various development boards
> >produced by ARM Ltd and emulated by the latest Fast Models from the
> >company.
> >
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> 
> I've given this a spin on my Juno, and the first thing of note is this:
> 
> hdlcd 7ff60000.hdlcd: master bind failed: -517
> hdlcd 7ff50000.hdlcd: master bind failed: -517
> scpi_protocol scpi: SCP Protocol 1.0 Firmware 1.9.0 version
> [drm] found ARM HDLCD version r0p0
> tda998x 0-0070: Falling back to first CRTC
> usb 1-1: new high-speed USB device number 2 using ehci-platform
> tda998x 0-0070: found TDA19988
> hdlcd 7ff60000.hdlcd: bound 0-0070 (ops tda998x_ops)
> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [drm] No driver support for vblank timestamp query.
> ------------[ cut here ]------------
> WARNING: at drivers/gpu/drm/drm_atomic_helper.c:682
> Modules linked in:
> 
> CPU: 2 PID: 98 Comm: kworker/u12:3 Tainted: G        W       4.4.0-rc2+ #846
> Hardware name: ARM Juno development board (r1) (DT)
> Workqueue: deferwq deferred_probe_work_func
> task: fffffe007ecb3700 ti: fffffe09409c8000 task.ti: fffffe09409c8000
> PC is at drm_atomic_helper_update_legacy_modeset_state+0x1e8/0x1f0
> LR is at drm_atomic_helper_commit_modeset_disables+0x1a8/0x388
> pc : [<fffffe00004a4468>] lr : [<fffffe00004a59b8>] pstate: 20000045
> sp : fffffe09409cb560
> x29: fffffe09409cb560 x28: fffffe0940bf2800
> x27: fffffe0940070000 x26: 0000000000000001
> x25: fffffe0000be4b50 x24: fffffe00007ae820
> x23: fffffe0000be4b50 x22: fffffe0940bd1000
> x21: fffffe0940bd1000 x20: 0000000000000000
> x19: fffffe0940968000 x18: fffffe0940c8091c
> x17: 0000000000000007 x16: 0000000000000001
> x15: fffffe0940c8016f x14: 0000003c00000000
> x13: 0000000000000000 x12: 000004c9000004b4
> x11: 000004b1000004c9 x10: 000004b0000004b0
> x9 : 00000000000006f4 x8 : 000006a400000654
> x7 : 000006f400000640 x6 : fffffe0940966480
> x5 : fffffe0940968200 x4 : 0000000000000001
> x3 : fffffe0940966a80 x2 : 0000000000000000
> x1 : fffffe0940bd0900 x0 : fffffe0940bd0960
> 
> ---[ end trace bdb6af69b29bf7ea ]---
> Call trace:
> [<fffffe00004a4468>]
> drm_atomic_helper_update_legacy_modeset_state+0x1e8/0x1f0
> [<fffffe00004a59b8>] drm_atomic_helper_commit_modeset_disables+0x1a8/0x388
> [<fffffe00004a5c70>] drm_atomic_helper_commit+0xd8/0x140
> [<fffffe00004ccce0>] hdlcd_atomic_commit+0x10/0x18
> [<fffffe00004c9ef8>] drm_atomic_commit+0x40/0x70
> [<fffffe00004a69b0>] restore_fbdev_mode+0x270/0x2b0
> [<fffffe00004a8d64>] drm_fb_helper_restore_fbdev_mode_unlocked+0x34/0x90
> [<fffffe00004a8dec>] drm_fb_helper_set_par+0x2c/0x60
> [<fffffe000042f010>] fbcon_init+0x4d0/0x520
> [<fffffe000046ec9c>] visual_init+0xac/0x108
> [<fffffe000047060c>] do_bind_con_driver+0x1d4/0x3e8
> [<fffffe0000470c14>] do_take_over_console+0x174/0x1e8
> [<fffffe000042c38c>] do_fbcon_takeover+0x74/0x100
> [<fffffe00004313b4>] fbcon_event_notify+0x77c/0x7d8
> [<fffffe00000dc700>] notifier_call_chain+0x50/0x90
> [<fffffe00000dcadc>] __blocking_notifier_call_chain+0x4c/0x90
> [<fffffe00000dcb34>] blocking_notifier_call_chain+0x14/0x20
> [<fffffe0000435204>] fb_notifier_call_chain+0x1c/0x28
> [<fffffe0000437010>] register_framebuffer+0x1c0/0x2b8
> [<fffffe00004a90a4>] drm_fb_helper_initial_config+0x284/0x3e8
> [<fffffe00004a991c>] drm_fbdev_cma_init+0x94/0x148
> [<fffffe00004ccfc4>] hdlcd_drm_bind+0x1d4/0x418
> [<fffffe00004d15f0>] try_to_bring_up_master.part.2+0xc8/0x110
> [<fffffe00004d1820>] component_add+0x90/0x108
> [<fffffe00004ce6a8>] tda998x_probe+0x18/0x20
> [<fffffe00005a6d24>] i2c_device_probe+0x164/0x228
> [<fffffe00004d698c>] driver_probe_device+0x1ec/0x2f0
> [<fffffe00004d6bc0>] __device_attach_driver+0x90/0xd8
> [<fffffe00004d4b88>] bus_for_each_drv+0x58/0x98
> [<fffffe00004d66e4>] __device_attach+0xc4/0x148
> [<fffffe00004d6c58>] device_initial_probe+0x10/0x18
> [<fffffe00004d5b9c>] bus_probe_device+0x94/0xa0
> [<fffffe00004d6020>] deferred_probe_work_func+0x70/0xa8
> [<fffffe00000d5b70>] process_one_work+0x138/0x378
> [<fffffe00000d5ed4>] worker_thread+0x124/0x498
> [<fffffe00000dbb54>] kthread+0xdc/0xf0
> [<fffffe0000093980>] ret_from_fork+0x10/0x50
> Console: switching to colour frame buffer device 150x100
> 
> which for reference, is the first one in that function:
> 
> 	...
> 	/* clear out existing links and update dpms */
> 	for_each_connector_in_state(old_state, connector, old_conn_state, i) {
> 		if (connector->encoder) {
> 			WARN_ON(!connector->encoder->crtc);
> 			...
> 
> That's on 4.4-rc2 with this series plus the 3 tda998x patches from Russell's
> patch system applied. Is there something else I'm missing or does this need
> looking at (could it be related to that initial probe deferral)?

Yeah, you also need Thierry Reding's patch to not set the connector->encoder in
drivers.

http://lists.freedesktop.org/archives/dri-devel/2015-November/094576.html



> 
> >Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >---
> >  drivers/gpu/drm/Kconfig          |   2 +
> >  drivers/gpu/drm/Makefile         |   1 +
> >  drivers/gpu/drm/arm/Kconfig      |  29 ++
> >  drivers/gpu/drm/arm/Makefile     |   2 +
> >  drivers/gpu/drm/arm/hdlcd_crtc.c | 329 ++++++++++++++++++++++
> >  drivers/gpu/drm/arm/hdlcd_drv.c  | 580 +++++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/arm/hdlcd_drv.h  |  42 +++
> >  drivers/gpu/drm/arm/hdlcd_regs.h |  87 ++++++
> >  8 files changed, 1072 insertions(+)
> >  create mode 100644 drivers/gpu/drm/arm/Kconfig
> >  create mode 100644 drivers/gpu/drm/arm/Makefile
> >  create mode 100644 drivers/gpu/drm/arm/hdlcd_crtc.c
> >  create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.c
> >  create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.h
> >  create mode 100644 drivers/gpu/drm/arm/hdlcd_regs.h
> 
> [...]
> 
> >+static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
> >+{
> >+	unsigned int btpp, default_color = 0x00000000;
> >+	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
> >+	uint32_t pixel_format;
> >+	struct simplefb_format *format = NULL;
> >+	int i;
> >+
> >+#ifdef CONFIG_DRM_HDLCD_SHOW_UNDERRUN
> >+	default_color = 0x00ff0000;	/* show underruns in red */
> >+#endif
> >+
> >+	pixel_format = crtc->primary->state->fb->pixel_format;
> >+
> >+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
> >+		if (supported_formats[i].fourcc == pixel_format)
> >+			format = &supported_formats[i];
> >+	}
> >+
> >+	if (WARN_ON(!format)) {
> >+		return 0;
> >+	}
> 
> nit: unnecessary braces.
> 
> >+	/* HDLCD uses 'bytes per pixel', zero means 1 byte */
> >+	btpp = (format->bits_per_pixel + 7) / 8;
> >+	hdlcd_write(hdlcd, HDLCD_REG_PIXEL_FORMAT, (btpp - 1) << 3);
> >+
> >+	/*
> >+	 * The format of the HDLCD_REG_<color>_SELECT register is:
> >+	 *   - bits[23:16] - default value for that color component
> >+	 *   - bits[11:8]  - number of bits to extract for each color component
> >+	 *   - bits[4:0]   - index of the lowest bit to extract
> >+	 *
> >+	 * The default color value is used when bits[11:8] are zero, when the
> >+	 * pixel is outside the visible frame area or when there is a
> >+	 * buffer underrun.
> >+	 */
> >+	hdlcd_write(hdlcd, HDLCD_REG_RED_SELECT, default_color |
> >+		format->red.offset | (format->red.length & 0xf) << 8);
> >+	hdlcd_write(hdlcd, HDLCD_REG_GREEN_SELECT, default_color |
> >+		format->green.offset | (format->green.length & 0xf) << 8);
> >+	hdlcd_write(hdlcd, HDLCD_REG_BLUE_SELECT, default_color |
> >+		format->blue.offset | (format->blue.length & 0xf) << 8);
> 
> These would seem to be putting bits 23:16 from default_color into the
> default field of every register, and indeed underruns show up as a very
> white-looking shade of red for me ;)

Ooops, I better change that. Could you tell me how you trigger underruns
in your setup?

> 
> >+	return 0;
> >+}
> 
> [...]
> 
> >+static void hdlcd_fb_output_poll_changed(struct drm_device *drm)
> >+{
> >+	struct hdlcd_drm_private *hdlcd = drm->dev_private;
> >+
> >+	if (hdlcd->fbdev) {
> >+		drm_fbdev_cma_hotplug_event(hdlcd->fbdev);
> >+	}
> 
> nit: braces.
> 
> >+}
> 
> [...]
> 
> >+static irqreturn_t hdlcd_irq(int irq, void *arg)
> >+{
> >+	struct drm_device *drm = arg;
> >+	struct hdlcd_drm_private *hdlcd = drm->dev_private;
> >+	unsigned long irq_status;
> >+
> >+	irq_status = hdlcd_read(hdlcd, HDLCD_REG_INT_STATUS);
> >+
> >+#ifdef CONFIG_DEBUG_FS
> >+	if (irq_status & HDLCD_INTERRUPT_UNDERRUN) {
> >+		atomic_inc(&hdlcd->buffer_underrun_count);
> >+	}
> >+	if (irq_status & HDLCD_INTERRUPT_DMA_END) {
> >+		atomic_inc(&hdlcd->dma_end_count);
> >+	}
> >+	if (irq_status & HDLCD_INTERRUPT_BUS_ERROR) {
> >+		atomic_inc(&hdlcd->bus_error_count);
> >+	}
> >+	if (irq_status & HDLCD_INTERRUPT_VSYNC) {
> >+		atomic_inc(&hdlcd->vsync_count);
> >+	}
> 
> nit: braces again (it's only because I'm too lazy to remove the newbie
> checkpatch commit hook, and a manual merge of this into my SMMU dev tree
> made that throw a fit)
> 
> >+#endif
> >+	if (irq_status & HDLCD_INTERRUPT_VSYNC) {
> >+		bool events_sent = false;
> >+		unsigned long flags;
> >+		struct drm_pending_vblank_event	*e, *t;
> >+
> >+		drm_crtc_handle_vblank(&hdlcd->crtc);
> >+
> >+		spin_lock_irqsave(&drm->event_lock, flags);
> >+		list_for_each_entry_safe(e, t, &hdlcd->event_list, base.link) {
> >+			list_del(&e->base.link);
> >+			drm_crtc_send_vblank_event(&hdlcd->crtc, e);
> >+			events_sent = true;
> >+		}
> >+		if (events_sent)
> >+			drm_crtc_vblank_put(&hdlcd->crtc);
> >+		spin_unlock_irqrestore(&drm->event_lock, flags);
> >+	}
> >+
> >+	/* acknowledge interrupt(s) */
> >+	hdlcd_write(hdlcd, HDLCD_REG_INT_CLEAR, irq_status);
> >+
> >+	return IRQ_HANDLED;
> >+}
> 
> Other than that though, it seems to do the job. I get a usable framebuffer
> console and can boot to an X desktop with at least the ancient 1600x1200 DVI
> monitor I have handy - the 1920x1080 HDMI one seems to get recognised OK but
> the monitor itself doesn't like the signal and just locks up until I unplug
> it, although I know that's more of a clock driver/firmware issue.

I have a TV that does the same. Yes, the SCPI clock that was picked for this
resolution is a standard one, but I bet that these monitors are slightly out
of spec. At least my TV lists two options for 1080p: one with 145MHz pixel
clock and another with 145.382MHz. But Linux decides to go interlaced anyway,
so I can't test without a hack in tda998x_drv.c.

Thanks for testing this.

Best regards,
Liviu

> 
> Robin.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
