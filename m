From: lethal@linux-sh.org (Paul Mundt)
Date: Mon, 8 Nov 2010 13:17:21 +0900
Subject: [PATCH 6/6 v2] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <1289147348-31969-6-git-send-email-alchark@gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-6-git-send-email-alchark@gmail.com>
Message-ID: <20101108041721.GA11605@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 07, 2010 at 07:28:57PM +0300, Alexey Charkov wrote:
> +static int __devinit vt8500lcd_probe(struct platform_device *pdev)
> +{

...

> +	addr = fbi;
> +	addr = addr + sizeof(struct vt8500lcd_info);
> +	fbi->fb.pseudo_palette	= addr;
> +
...

> +	fbi->palette_size	= PAGE_ALIGN(512);
> +	fbi->palette_cpu	= dma_alloc_coherent(&pdev->dev,
> +						     fbi->palette_size,
> +						     &fbi->palette_phys,
> +						     GFP_KERNEL);
> +	if (fbi->fb.pseudo_palette == NULL) {
> +		dev_err(&pdev->dev, "Failed to allocate palette buffer\n");
> +		ret = -ENOMEM;
> +		goto failed_free_io;
> +	}
> +
This looks like a bogus test, you've already allocated enough space for
the pseudo_palette and will have bailed out on the kmalloc() failing well
before this. You also don't have any error handling for fbi->palette_cpu,
which is presumably what you intended to do here.

> +static int __devexit vt8500lcd_remove(struct platform_device *pdev)
> +{
> +	struct vt8500lcd_info *fbi = platform_get_drvdata(pdev);
> +	struct resource *res;
> +	int irq;
> +
> +	if (!fbi)
> +		return 0;
> +
> +	unregister_framebuffer(&fbi->fb);
> +
> +	writel(0, fbi->regbase);
> +
> +	if (fbi->fb.cmap.len)
> +		fb_dealloc_cmap(&fbi->fb.cmap);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	free_irq(irq, fbi);
> +
> +	iounmap(fbi->regbase);
> +

You're also missing a dma_free_coherent() here.

> +static int __devinit wm8505fb_probe(struct platform_device *pdev)
> +{
> +	fbi->fb.screen_base	= pdata->video_mem_virt;
> +	fbi->fb.screen_size	= pdata->video_mem_len;
> +
...

> +failed_free_mem:
> +	free_pages_exact(fbi->fb.screen_base, fbi->fb.screen_size);

...

What in the name of all that is holy are you doing here? If you need to
have your platform deal with virtual address allocation and freeing then
you should pass in callbacks for that and hide the instrumentation
details there. Presently this is tying you down to an alloc_pages_exact()
interface buried in the board setup, which isn't going to mesh well with
other platforms that may wish to go about this an alternate way (like
memblock reservations).

> diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
> new file mode 100644
> index 0000000..c71f97e
> --- /dev/null
> +++ b/drivers/video/wmt_ge_rops.c
> +void __iomem *regbase;
> +
Uhm, no. If this is only used in this driver then just make it static.
Given that you are using the driver model here though and could
theoretically support multiple rop engines, you're much better off making
this private data and burying it under the appropriate per-device data
structures.

> +int wmt_ge_sync(struct fb_info *p)
> +{
> +	while (readl(regbase + GE_STATUS_OFF) & 4)
> +		/* busy wait */;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(wmt_ge_sync);
> +
While I admire your optimism in your hardware, experience suggests you
really want a timeout here. You may also wish to insert a cpu_relax()
here.
