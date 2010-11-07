From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Nov 2010 16:57:45 +0000
Subject: [PATCH 1/6 v2] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <1289147348-31969-1-git-send-email-alchark@gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
Message-ID: <20101107165745.GB1759@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 07, 2010 at 07:28:52PM +0300, Alexey Charkov wrote:
> +static inline void preallocate_fb(struct vt8500fb_platform_data *p,
> +				  unsigned long align) {
> +	p->video_mem_len = (p->xres_virtual * p->yres_virtual * 4) >>
> +			(p->bpp > 16 ? 0 : (p->bpp > 8 ? 1 :
> +					(8 / p->bpp) + 1));
> +	p->video_mem_phys = (unsigned long)memblock_alloc(p->video_mem_len,
> +							  align);
> +	p->video_mem_virt = phys_to_virt(p->video_mem_phys);
> +}
...
> +void __init vt8500_map_io(void)
> +{
> +	wmt_current_regs = &wmt_regmaps[VT8500_INDEX];
> +	wmt_current_irqs = &wmt_irqs[VT8500_INDEX];
> +	set_data();
> +#ifdef CONFIG_FB_VT8500
> +	panels[current_panel_idx].bpp = 16; /* Always use RGB565 */
> +	preallocate_fb(&panels[current_panel_idx], SZ_4M);
> +	vt8500_device_lcdc.dev.platform_data = &panels[current_panel_idx];
> +#endif
> +	iotable_init(vt8500_io_desc, ARRAY_SIZE(vt8500_io_desc));
> +}
...
> +void __init wm8505_map_io(void)
> +{
> +	wmt_current_regs = &wmt_regmaps[WM8505_INDEX];
> +	wmt_current_irqs = &wmt_irqs[WM8505_INDEX];
> +	set_data();
> +#ifdef CONFIG_FB_WM8505
> +	panels[current_panel_idx].bpp = 32; /* Always use RGB888 */
> +	preallocate_fb(&panels[current_panel_idx], 32);
> +	vt8500_device_wm8505_fb.dev.platform_data = &panels[current_panel_idx];
> +#endif
> +	iotable_init(vt8500_io_desc, ARRAY_SIZE(vt8500_io_desc));
> +}

I'd much prefer that the allocation of memblock memory is done via the
'reserve' machine callback, rather than trying to group it into the IO
mapping callback.  Is there a reason it can't be?
