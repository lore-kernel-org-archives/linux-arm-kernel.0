From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 2 Oct 2017 20:39:30 +0200
Subject: [PATCH] ARM: dts: meson8b: add reserved memory zone to fix silent
 freezes
In-Reply-To: <20171002155903.19511-1-linus.luessing@c0d3.blue>
References: <20171002155903.19511-1-linus.luessing@c0d3.blue>
Message-ID: <CAFBinCCde249b0o9aKMErEbKznM7UQrg1FzhLQ2whej0x_XLAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 2, 2017 at 5:59 PM, Linus L?ssing <linus.luessing@c0d3.blue> wrote:
> So far, the stress-ng tool for instance quickly resulted in a silent
> freeze of the system with no prior notice on a serial console when
> running its filesystem or memory stressor classes.
>
> Even with a panic-on-OOM and reboot-on-panic (vm.panic_on_oom=1,
> kernel.panic=10) configured, the system would neither reboot nor
> would the OOM killer get any chance to otherwise do its job.
>
> The Amlogic reference source code uses a 2MB PHYS_OFFSET. With these 2MB
> reserved via DT, stress-ng was able to run on an Odroid C1+ just fine for
> several hours, the OOM killer was able to kill processes again and if
> configured would successfully trigger a reboot of the system.
>
> Fixes: 4a69fcd3a108 ("ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards")
> Signed-off-by: Linus L?ssing <linus.luessing@c0d3.blue>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

>
> ---
> The following stress-ng command worked fine now:
> $ stress-ng -v --sequential 0 -t 120s --exclude sysfs,opcode --metrics
> (5 hours runtime, tested on an Odroid C1+ with an 4.14-rc1 kernel + SMP
> + USB DTS patches)
> ---
>  arch/arm/boot/dts/meson8b.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index bc278da..d75a5b5 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -83,6 +83,18 @@
>                 };
>         };
>
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               /* 2 MiB reserved for Hardware ROM Firmware? */
> +               hwrom at 0 {
> +                       reg = <0x0 0x200000>;
> +                       no-map;
> +               };
> +       };
> +
>         scu at c4300000 {
>                 compatible = "arm,cortex-a5-scu";
>                 reg = <0xc4300000 0x100>;
> --
> 2.1.4
>
