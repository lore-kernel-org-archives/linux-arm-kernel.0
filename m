From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sun, 6 Apr 2014 22:04:05 +0200
Subject: [PATCH] arm/igep0020: fix IGEPv2 boot
In-Reply-To: <1396801938-24788-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1396801938-24788-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <CABxcv=k3nrhVtMPw1BqO6Cz07VEtGA9ZBMvkXBJuLrcCSoXpwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Giles,

On Sun, Apr 6, 2014 at 6:32 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Booting Linux 3.14 compiled with omap2plus_defconfig on IGEPv2 board
> currrently results in the same issue as reported here:
>
> https://www.mail-archive.com/linux-media at vger.kernel.org/msg69556.html
>
> The following change avoids this.
>
> Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> ---
>  arch/arm/boot/dts/omap3-igep.dtsi |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index c1700932..c15c3ef 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -207,6 +207,10 @@
>         pinctrl-0 = <&uart3_pins>;
>  };
>
> +&uart4 {
> +       status = "disabled";
> +};
> +
>  &twl_gpio {
>         ti,use-leds;
>  };
> --
> 1.7.10.4
>

It looks suspiciously similar to an issue we had due some DT clock
changes were the IGEPv2 (or any board that used the "ti,omap3"
compatible string) were initialized as omap3430 instead of omap3630
thus using omap3430 clock data which left the UART4 uninitialized.

I fixed that particular issue on commit fb0cfec ("ARM: dts:
omap3-igep: fix boot fail due wrong compatible match") which was
merged on v3.14-rc6 so it should be on your v3.14 kernel so maybe is a
different issue.

I wonder why you are having this issue though since I didn't have that
problem with 3.14 as far as I can remember.

Can you provide me the exact commit id of your HEAD? or is just the
tagged v3.14 commit?

Thanks a lot and best regards,
Javier
