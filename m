From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 2 Apr 2010 16:41:23 +0800
Subject: PXA168 suspend/resume issue and set_wake
In-Reply-To: <y2s45a44e481004020100m32ecd3dv6931f2aca3267656@mail.gmail.com>
References: <y2s45a44e481004020100m32ecd3dv6931f2aca3267656@mail.gmail.com>
Message-ID: <p2mf17812d71004020141heb9b88a4xfcfdd297c5150be0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 2, 2010 at 4:00 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> Hi Arm friends,
>
> A quick question for you. I am experimenting with a PXA168 device and
> noticed some odd behaviour with resume. The device can suspend and can
> then be resumed, at least to serial console level after a gpio button
> press. But then as part of the resume, I see some messages about
> unbalanced IRQ wake disable. Then after that, button presses no longer
> generate any interrupts. The irq count remains what it was at the
> point of suspend. I took a quick scan at the PXA168 source code and
> noticed:
>
> pxa168.c:
> pxa_init_gpio(IRQ_PXA168_GPIOX, 0, 127, NULL);
>
> So no set_wake function, which I think explains the unbalanced IRQ
> wake messages since gpio-keys would have tried to enable_irq_wake on
> suspend which would do nothing since above has no set_wake and then on
> resume gpio-keys would try to disable_irq_wake and cause the
> unbalanced IRQ wake disable.

Mmm... set_irq_wake_real() will return -ENXIO when no ".set_wake" is
available for the IRQ chip, and depending on this result the wake_depth
will be unbalanced during resume.

So I'm seeing two options:

1. with ".set_wake" being unavailable, the wake_depth should be
made balanced (since no real set wake operation is being taken)

2. or mark those GPIO buttons being not able to wakeup

> But I haven't quite understood why the
> buttons fail to cause any interrupts after that. Has anyone
> encountered anything similar and if so any patches I could look at?
>
> Thanks,
> jaya
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
