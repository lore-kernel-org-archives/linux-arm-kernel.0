From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 23 May 2012 10:12:53 +0200
Subject: 
In-Reply-To: <4FBB9D71.5040906@metafoo.de>
References: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
 <4FBB9D71.5040906@metafoo.de>
Message-ID: <20120523081253.GQ30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 04:06:41PM +0200, Lars-Peter Clausen wrote:
> On 05/18/2012 02:27 PM, Sascha Hauer wrote:
> > Hi All,
> > 
> > The following adds a drm/kms driver for the Freescale i.MX LCDC
> > controller. Most notable change to the last SDRM based version is that
> > the SDRM layer has been removed and the driver now is purely i.MX
> > specific. I hope that this is more acceptable now.
> > 
> > Another change is that the probe is now devicetree based. For now I
> > took the easy way out and only put an edid blob into the devicetree.
> > I haven't documented the binding yet, I would add that when the rest
> > is considered ok.
> > 
> > Comments very welcome.
> > 
> 
> Hi,
> 
> I really liked the sdrm layer. At least some bits of it. I've been working
> on a "simple" DRM driver as well. The hardware has no fancy acceleration
> features, just a simple buffer and some scanout logic. I'm basically using
> the same gem buffer structure and the buffer is also allocated using
> dma_alloc_writecombine, which means we can probably share all of the GEM
> handling code and probably also most of the fbdev code. I also started with
> the Exynos GEM code as a template, but reworked it later to be more like the
> UDL code, which made it a bit more compact. I think it would be a good idea
> to put at least the GEM handling in some common code as I expect that we'll
> see more similar "simple" DRM drivers pop up.

I totally agree. Having to track other drivers for bug fixes to apply
them on the own driver is not very convenient. As answered to Rob I do
not really have a clue how to accomplish this.

> 
> The code in question can be found at
> https://github.com/lclausen-adi/linux-2.6/commit/87a8fd6b98eeee317c7a486846cc8405d0bd68d8
> 
> Btw. the imx-drm.h is missing in your patch.

Oops, here it is for reference, will include it in the next round.


#ifndef _IMX_DRM_H_
#define _IMX_DRM_H_

/**
 * User-desired buffer creation information structure.
 *
 * @size: requested size for the object.
 *	- this size value would be page-aligned internally.
 * @flags: user request for setting memory type or cache attributes.
 * @handle: returned handle for the object.
 */
struct imx_drm_gem_create {
	unsigned int size;
	unsigned int flags;
	unsigned int handle;
};

struct imx_drm_device;
struct imx_drm_crtc;

struct imx_drm_crtc_helper_funcs {
	int (*enable_vblank)(struct drm_crtc *crtc);
	void (*disable_vblank)(struct drm_crtc *crtc);
};

int imx_drm_add_crtc(struct drm_crtc *crtc,
		struct imx_drm_crtc **new_crtc,
		const struct drm_crtc_funcs *crtc_funcs,
		const struct drm_crtc_helper_funcs *crtc_helper_funcs,
		const struct imx_drm_crtc_helper_funcs *ec_helper_funcs,
		struct module *owner);
int imx_drm_remove_crtc(struct imx_drm_crtc *);
int imx_drm_init_drm(struct platform_device *pdev,
		int preferred_bpp);
int imx_drm_exit_drm(void);

int imx_drm_crtc_vblank_get(struct imx_drm_crtc *imx_drm_crtc);
void imx_drm_crtc_vblank_put(struct imx_drm_crtc *imx_drm_crtc);
void imx_drm_handle_vblank(struct imx_drm_crtc *imx_drm_crtc);

/*
 * imx drm buffer entry structure.
 *
 * @paddr: physical address of allocated memory.
 * @vaddr: kernel virtual address of allocated memory.
 * @size: size of allocated memory.
 */
struct imx_drm_buf_entry {
	dma_addr_t paddr;
	void __iomem *vaddr;
	unsigned int size;
};

/* get physical memory information of a drm framebuffer. */
struct imx_drm_buf_entry *imx_drm_fb_get_buf(struct drm_framebuffer *fb);

struct imx_drm_encoder;
int imx_drm_add_encoder(struct drm_encoder *encoder,
		struct imx_drm_encoder **new_enc,
		struct module *owner);
int imx_drm_remove_encoder(struct imx_drm_encoder *);

struct imx_drm_connector;
int imx_drm_add_connector(struct drm_connector *connector,
		struct imx_drm_connector **new_con,
		struct module *owner);
int imx_drm_remove_connector(struct imx_drm_connector *);

void imx_drm_mode_config_init(struct drm_device *drm);

#define to_imx_drm_gem_obj(x)	container_of(x,\
			struct imx_drm_gem_obj, base)

struct imx_drm_gem_obj {
	struct drm_gem_object base;
	struct imx_drm_buf_entry *entry;
};

/* unmap a buffer from user space. */
int imx_drm_gem_munmap_ioctl(struct drm_device *drm, void *data,
		struct drm_file *file_priv);

/* initialize gem object. */
int imx_drm_gem_init_object(struct drm_gem_object *obj);

/* free gem object. */
void imx_drm_gem_free_object(struct drm_gem_object *gem_obj);

/* create memory region for drm framebuffer. */
int imx_drm_gem_dumb_create(struct drm_file *file_priv,
		struct drm_device *drm, struct drm_mode_create_dumb *args);

/* map memory region for drm framebuffer to user space. */
int imx_drm_gem_dumb_map_offset(struct drm_file *file_priv,
		struct drm_device *drm, uint32_t handle, uint64_t *offset);

/* page fault handler and mmap fault address(virtual) to physical memory. */
int imx_drm_gem_fault(struct vm_area_struct *vma, struct vm_fault *vmf);

/* set vm_flags and we can change the vm attribute to other one at here. */
int imx_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);

/*
 * destroy memory region allocated.
 *	- a gem handle and physical memory region pointed by a gem object
 *	would be released by drm_gem_handle_delete().
 */
int imx_drm_gem_dumb_destroy(struct drm_file *file_priv,
		struct drm_device *drm, unsigned int handle);

/* allocate physical memory. */
struct imx_drm_buf_entry *imx_drm_buf_create(struct drm_device *drm,
		unsigned int size);

/* remove allocated physical memory. */
void imx_drm_buf_destroy(struct drm_device *drm, struct imx_drm_buf_entry *entry);

struct drm_device *imx_drm_device_get(void);
void imx_drm_device_put(void);

#endif /* _IMX_DRM_H_ */
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
