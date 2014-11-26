From: dianders@chromium.org (Doug Anderson)
Date: Wed, 26 Nov 2014 08:14:05 -0800
Subject: [PATCH v4] clocksource: arch_timer: Allow the device tree to
 specify uninitialized timer registers
In-Reply-To: <1417012893.12707.12.camel@mtksdaap41>
References: <1412753627-28287-1-git-send-email-sonnyrao@chromium.org>
 <1417012893.12707.12.camel@mtksdaap41>
Message-ID: <CAD=FV=XFcWEp=nZ3=8QEausKzpBbPCzFUSHY-g0K5y+VPpU3Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yingjoe,

On Wed, Nov 26, 2014 at 6:41 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> Sorry for the (very) late reply.
> I just realize today MT8135 need this and the other patch [1] to boot
> SMP correctly. I've applied both patches and they works fine. Thanks :)

Excellent.  It's helpful to include a Tested-by: tag in your email.
You'd have a line with just "Tested-by: Yingjoe Chen
<yingjoe.chen@mediatek.com>"


> However, I'm not sure if we really need to add new property.
> arm_arch_timer driver will only use virtual timer when virtual PPI
> interrupt is provided, so the following patch to timer dtsi will also
> works. I think if the firmware doesn't support virtual timer, it make
> sense to not supply virtual interrupt.
>
>         timer {
>                 compatible = "arm,armv7-timer";
>                 interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> -                            <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> -                            <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> -                            <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +                            <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>;
>                 clock-frequency = <13000000>;
>         };

Once you have Sonny's patch then I believe that the above would work.
However we rejected something like this because device tree is
supposed to describe the hardware.  The hardware really does provide
the virtual timer interrupts and they really are at PPI 11 and PPI 10.
It's just that firmware doesn't handle things properly so they can't
be used.

NOTE: If we add the "arm,cpu-registers-not-fw-configured" to the
device tree and firmware actually works out how to configure things
(like if somehow has firmware that has a hypervisor) then it can
easily remove this device tree property before calling through to the
kernel.  It would be much harder for the firmware to add back in the
"PPI 11" and "PPI 10" entries to the timer.

-Doug
