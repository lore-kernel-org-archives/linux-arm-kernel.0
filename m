From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 May 2014 15:29:26 +0200
Subject: [PATCH v3 4/7] of: configure the platform device dma parameters
In-Reply-To: <CACRpkdZjEVYgq7tKEfmZC0Fu4n=JuUues=pAAtquLahkex=pkA@mail.gmail.com>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <5840140.8yGnd4Ycx3@wuerfel>
 <CACRpkdZjEVYgq7tKEfmZC0Fu4n=JuUues=pAAtquLahkex=pkA@mail.gmail.com>
Message-ID: <4960549.viM91iY2g2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 May 2014 10:23:09 Linus Walleij wrote:
> diff --git a/arch/arm/boot/dts/integratorap.dts
> b/arch/arm/boot/dts/integratorap.dts
> index b10e6351da53..f0c397fd45c5 100644
> --- a/arch/arm/boot/dts/integratorap.dts
> +++ b/arch/arm/boot/dts/integratorap.dts
> @@ -8,6 +8,7 @@
>  / {
>         model = "ARM Integrator/AP";
>         compatible = "arm,integrator-ap";
> +       dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
> 
>         aliases {
>                 arm,timer-primary = &timer2;
> 

It looks like you accidentally copied the ranges from keystone, even
though that has a 64-bit root bus and you only have 32-bit.

I suspect what you want is

	dma-ranges = <0x80000000 0 0x80000000>;

to translate dma_addr_t 0x80000000-0xffffffff to phys_addr_t 0x0-0x7fffffff
rather than phys_addr_t 0x800000000-0x87fffffff.

	Arnd
