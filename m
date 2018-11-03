From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Nov 2018 20:05:24 +0100
Subject: [PATCH 1/2] DT: marvell,mmp2: fix TWSI2
In-Reply-To: <20180917113947.12626-2-lkundrak@v3.sk>
References: <20180917113947.12626-1-lkundrak@v3.sk>
 <20180917113947.12626-2-lkundrak@v3.sk>
Message-ID: <20181103190524.GC31179@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-09-17 13:39:46, Lubomir Rintel wrote:
> Marvell keeps their MMP2 datasheet secret, but there are good clues
> that TWSI2 is not on 0xd4025000 on that platform, not does it use
> IRQ 58. In fact, the IRQ 58 on MMP2 seems to be a signal processor:
> 
>    arch/arm/mach-mmp/irqs.h:#define IRQ_MMP2_MSP  58
> 
> I'm taking a somewhat educated guess that is probably a copy & paste
> error from PXA168 or PXA910 and that the real controller in fact hides
> at address 0xd4031000 and uses an interrupt line multiplexed via IRQ 17.
> 
> I'm also copying some properties from TWSI1 that were missing or
> incorrect.
> 
> Tested on a OLPC XO 1.75 machine, where the RTC is on TWSI2.
> 
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

>  				status = "disabled";
>  			};
>  
> -			twsi2: i2c at d4025000 {
> +			twsi2: i2c at d4031000 {
>  				compatible = "mrvl,mmp-twsi";
> -				reg = <0xd4025000 0x1000>;
> -				interrupts = <58>;
> +				reg = <0xd4031000 0x1000>;
> +				interrupt-parent = <&intcmux17>;
> +				interrupts = <0>;
>  				clocks = <&soc_clocks MMP2_CLK_TWSI1>;
>  				resets = <&soc_clocks MMP2_CLK_TWSI1>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
>  				status = "disabled";
>  			};
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181103/3e8c8958/attachment.sig>
