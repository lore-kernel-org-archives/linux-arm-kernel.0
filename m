From: robh@kernel.org (Rob Herring)
Date: Tue, 16 Oct 2018 09:44:25 -0500
Subject: [PATCH 08/14] ARM64: dts: hisilicon: Add tsensor interrupt name
In-Reply-To: <d2cb2fa0-b579-205c-1777-308da075b3fd@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
 <20181015162835.GA20955@bogus>
 <d2cb2fa0-b579-205c-1777-308da075b3fd@linaro.org>
Message-ID: <CAL_JsqJCJbOxP_ODJ_JTRCvrFpSCSxa-X1LCr+1-pY_ApTz_1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 1:01 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rob,
>
> thanks for the review.
>
> On 15/10/2018 18:28, Rob Herring wrote:
> > On Tue, Sep 25, 2018 at 11:03:06AM +0200, Daniel Lezcano wrote:
> >> Add the interrupt names for the sensors, so the code can rely on them
> >> instead of dealing with index which are prone to error.

[...]

> >> +            interrupt-names = "tsensor_intr";
> >
> > That name seems pretty pointless.
> >
> >>              clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
> >>              clock-names = "thermal_clk";
> >>              #thermal-sensor-cells = <1>;
> >> @@ -28,5 +30,6 @@ for Hi3660:
> >>              compatible = "hisilicon,hi3660-tsensor";
> >>              reg = <0x0 0xfff30000 0x0 0x1000>;
> >>              interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> >> +            interrupt-names = "tsensor_a73";
> >
> > Just 'a73' is sufficient.
>
> This is the name defined in the board documentation to give a name to
> the interrupt when requesting it. This one appears in /proc/interrupts.
>
> I can replace the 'tsensor_intr' by 'tsensor', but if 'tsensor_a73' is
> replaced by 'a73' that may looks odd in /proc/interrupts to see an
> interrupts line with the 'a73' name.

Sounds like a Linux problem, not DT...

The thing is that any *-names property is supposed to be a local to
block name. For example, a UART may have a TX irq. It's local name is
just "TX IRQ", but then upstream at the interrupt controller it may be
"UART1 TX IRQ". If you have multiple instances, the local names are
the same.

If we lose the node name from /proc/interrupts when interrupt-names is
used, then we should fix that.

>
> However this is the preparation for the multiple sensors support so we
> will have more interrupt names.
>
> Is it possible to keep these names ?
>
>  - tsensor
>  - tsensor_a73
>  - tsensor_a57
>  - tsensor_gpu
>
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
