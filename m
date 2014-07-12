From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Sat, 12 Jul 2014 20:16:54 +0200
Subject: [RESEND PATCH v3 05/11] drm: add Atmel HLCDC Display Controller
 support
In-Reply-To: <1404751384-5077-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140712201654.565472d8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon,  7 Jul 2014 18:42:58 +0200
Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:


> +int atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer)
> +{
> +	struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(&dma->lock, flags);
> +	for (i = 0; i < layer->max_planes; i++) {
> +		if (!dma->cur[i])
> +			break;
> +
> +		dma->cur[i]->ctrl = 0;
> +	}
> +	spin_unlock_irqrestore(&dma->lock, flags);
> +
> +	return 0;
> +}


I'm trying to simplify the hlcdc_layer code and in order to do that I
need to know what's expected when a user calls plane_disable (or more
exactly DRM_IOCTL_MODE_SETPLANE ioctl call with the frame buffer ID set
to 0).

The HLCDC Display Controller support two types of disable:

1) The plane is disabled at the end of the current frame (the is the
solution I'm using)

2) The plane is disabled right away (I haven't tested it, but I think
this solution could generate some sort of artifacts for a short period
of time, because the framebuffer might be partially displayed)

If solution 1 is chosen, should I wait for the plane to be actually
disabled before returning ?
A the moment, I'm not: I'm just asking for the plane to be disabled and
then return. And this is where some of my complicated code come from,
because I must handle the case where a user disable the plane then re
enable it right away (modetest cursor test is doing a lot of cursor
enable/disable in a short period of time, and this is how I tested all
this weird use cases).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
