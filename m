From: robdclark@gmail.com (Rob Clark)
Date: Sat, 12 Jul 2014 14:37:16 -0400
Subject: [RESEND PATCH v3 05/11] drm: add Atmel HLCDC Display Controller
 support
In-Reply-To: <20140712201654.565472d8@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140712201654.565472d8@bbrezillon>
Message-ID: <CAF6AEGv=irY0B-Cg6No7voadnShYQTwSLpZjk19xxX5qGcZeMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 12, 2014 at 2:16 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
> Hello,
>
> On Mon,  7 Jul 2014 18:42:58 +0200
> Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:
>
>
>> +int atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer)
>> +{
>> +     struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
>> +     unsigned long flags;
>> +     int i;
>> +
>> +     spin_lock_irqsave(&dma->lock, flags);
>> +     for (i = 0; i < layer->max_planes; i++) {
>> +             if (!dma->cur[i])
>> +                     break;
>> +
>> +             dma->cur[i]->ctrl = 0;
>> +     }
>> +     spin_unlock_irqrestore(&dma->lock, flags);
>> +
>> +     return 0;
>> +}
>
>
> I'm trying to simplify the hlcdc_layer code and in order to do that I
> need to know what's expected when a user calls plane_disable (or more
> exactly DRM_IOCTL_MODE_SETPLANE ioctl call with the frame buffer ID set
> to 0).
>
> The HLCDC Display Controller support two types of disable:
>
> 1) The plane is disabled at the end of the current frame (the is the
> solution I'm using)
>
> 2) The plane is disabled right away (I haven't tested it, but I think
> this solution could generate some sort of artifacts for a short period
> of time, because the framebuffer might be partially displayed)
>
> If solution 1 is chosen, should I wait for the plane to be actually
> disabled before returning ?

for cursor in particular, if you block, it is going to be a massive
slowdown for some apps.  I remember at least older gdm would rapidly
flash a spinning cursor.  As a result, if you wait for vsync each
time, it would take a couple minutes to login!

if #2 works, I'd recommend it.  Otherwise you may have to do some of
the same hijinks that I have to do in mdp4_crtc for the cursor.

BR,
-R

> A the moment, I'm not: I'm just asking for the plane to be disabled and
> then return. And this is where some of my complicated code come from,
> because I must handle the case where a user disable the plane then re
> enable it right away (modetest cursor test is doing a lot of cursor
> enable/disable in a short period of time, and this is how I tested all
> this weird use cases).
>
> Best Regards,
>
> Boris
>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
