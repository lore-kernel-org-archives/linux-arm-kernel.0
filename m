From: ospite@studenti.unina.it (Antonio Ospite)
Date: Tue, 10 Nov 2009 10:29:50 +0100
Subject: [PATCH 1/3 v2] ezx: Add camera support for A780 and A910 EZX
	phones
In-Reply-To: <20091106182910.a3b48c41.ospite@studenti.unina.it>
References: <f17812d70911040119g6eb1f254pa78dd8519afef61d@mail.gmail.com>
	<1257367650-15056-1-git-send-email-ospite@studenti.unina.it>
	<Pine.LNX.4.64.0911050040160.4837@axis700.grange>
	<20091105234429.ef855e2d.ospite@studenti.unina.it>
	<Pine.LNX.4.64.0911061419220.4389@axis700.grange>
	<20091106182910.a3b48c41.ospite@studenti.unina.it>
Message-ID: <20091110102950.497af1fb.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

Guennadi, did you see the patch below? Or I should completely remove
the .init() callback like you said in another message?
As I said, my humble preference would be to keep GPIOs setup local to
the driver somehow, but you just tell me what to do :)

On Fri, 6 Nov 2009 18:29:10 +0100
Antonio Ospite <ospite@studenti.unina.it> wrote:

> On Fri, 6 Nov 2009 15:11:55 +0100 (CET)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > On Thu, 5 Nov 2009, Antonio Ospite wrote:
> > 
> > > See? It's power(), reset(), init().
> > > Maybe the problem is in soc_camera_probe()?
> > 
> > Sorry, you'd have to elaborate more on this. So, what's wrong with that 
> > sequence? it doesn't make sense to reset a powered down device or reset 
> > after init or whatever...
> >
> 
> I mean, when probing (or even opening) the device, pxacamera.init()
> is now called *after* the power ON and reset. If I kept disabled (high)
> nCAM_EN in init(), as it should've been, this would have overridden
> the previous power(1) call.
> 
> Isn't init() in pxacamera platform data meant to initialize the device
> before it can be powered ON? In fact I am requesting the gpios in
> a780_pxacamera_init, and if power() or reset() are called before it, then
> they will be invalid, because the gpios have not been requested yet.
> 
> Moreover, pxacamera.init() is called in pxa_camera_activate, which is
> called in pxa_camera_add_device, which in turn is invoked by
> soc_camera_open() every time.
> Shouldn't the init() method, where I request gpios, be called
> only on probe?
> 
> Let me be more schematic, when probing the camera we have:
> 
> soc_camera_probe()         /* same in soc_camera_open! */
> |-	icl->power(1)
> |-	icl->reset()
> |-	icd->ops->add()
> 	|-	pxacamera.init()  /* requesting gpios here! */
> |-	video_dev_create(icd)
> |-	...
> 
> Maybe we should have something like:
> 
> pxacamera.init()           /* request gpios only once! on probe. */
> soc_camera_probe()         /* same in soc_camera_open */
> |-	icl->power(1)
> |-	icl->reset()
> |-	icd->ops->add()
> |-	video_dev_create(icd)
> |-	...
> 
> Or, I'm missing what init() is supposed to do :)
> Does a patch like this make sense to you?
> (I've read the other mail about removing .init just before hitting Send,
> this can be an alternative to removing it, having GPIOs setup in the
> user driver seems clearer to me.)
> 
> diff --git a/drivers/media/video/pxa_camera.c b/drivers/media/video/pxa_camera.c
> index 6952e96..3101bcb 100644
> --- a/drivers/media/video/pxa_camera.c
> +++ b/drivers/media/video/pxa_camera.c
> @@ -881,18 +882,8 @@ static void recalculate_fifo_timeout(struct pxa_camera_dev *pcdev,
>  
>  static void pxa_camera_activate(struct pxa_camera_dev *pcdev)
>  {
> -	struct pxacamera_platform_data *pdata = pcdev->pdata;
> -	struct device *dev = pcdev->soc_host.v4l2_dev.dev;
>  	u32 cicr4 = 0;
>  
> -	dev_dbg(dev, "Registered platform device at %p data %p\n",
> -		pcdev, pdata);
> -
> -	if (pdata && pdata->init) {
> -		dev_dbg(dev, "%s: Init gpios\n", __func__);
> -		pdata->init(dev);
> -	}
> -
>  	/* disable all interrupts */
>  	__raw_writel(0x3ff, pcdev->base + CICR0);
>  
> @@ -1651,6 +1644,17 @@ static int __devinit pxa_camera_probe(struct platform_device *pdev)
>  	pcdev->res = res;
>  
>  	pcdev->pdata = pdev->dev.platform_data;
> +
> +	dev_dbg(&pdev->dev, "Registered platform device at %p data %p\n",
> +		pcdev, pcdev->pdata);
> +
> +	if (pcdev->pdata && pcdev->pdata->init) {
> +		dev_dbg(&pdev->dev, "%s: Init gpios\n", __func__);
> +		err = pcdev->pdata->init(&pdev->dev);
> +		if (err)
> +			goto exit_clk;
> +	}
> +
>  	pcdev->platform_flags = pcdev->pdata->flags;
>  	if (!(pcdev->platform_flags & (PXA_CAMERA_DATAWIDTH_8 |
>  			PXA_CAMERA_DATAWIDTH_9 | PXA_CAMERA_DATAWIDTH_10))) {

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091110/11001d25/attachment.sig>
