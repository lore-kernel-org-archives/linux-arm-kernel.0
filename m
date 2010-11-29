From: fg@emlix.com (Fabian Godehardt)
Date: Mon, 29 Nov 2010 07:39:20 +0100
Subject: [PATCH] ARM: s3c2440: fix AC97 and camera clock registration
In-Reply-To: <00b501cb8c76$edb20e90$c9162bb0$%kim@samsung.com>
References: <1289989343-28816-1-git-send-email-fg@emlix.com>
	<00b501cb8c76$edb20e90$c9162bb0$%kim@samsung.com>
Message-ID: <201011290739.20460.fg@emlix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> How about following for fix usage field?
> 
> diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
> index 3dc2426..2f393cb 100644
> --- a/arch/arm/mach-s3c2440/clock.c
> +++ b/arch/arm/mach-s3c2440/clock.c
> @@ -108,11 +108,12 @@ static struct clk s3c2440_clk_ac97 = {
>         .name           = "ac97",
>         .id             = -1,
>         .enable         = s3c2410_clkcon_enable,
> -       .ctrlbit        = S3C2440_CLKCON_CAMERA,
> +       .ctrlbit        = S3C2440_CLKCON_AC97,
>  };
> 
>  static int s3c2440_clk_add(struct sys_device *sysdev)
>  {
> +       unsigned long clkcon  = __raw_readl(S3C2410_CLKCON);

Yes, you are right. The clocks should be checked :).

>         struct clk *clock_upll;
>         struct clk *clock_h;
>         struct clk *clock_p;
> @@ -130,6 +131,9 @@ static int s3c2440_clk_add(struct sys_device *sysdev)
>         s3c2440_clk_ac97.parent = clock_p;
>         s3c2440_clk_cam_upll.parent = clock_upll;
> 
> +       s3c2440_clk_cam.usage = clkcon & s3c2440_clk_cam.ctrlbit ? 1 : 0;
> +       s3c2440_clk_ac97.usage = clkcon & s3c2440_clk_ac97.ctrlbit ? 1 : 0;
> +
>         s3c24xx_register_clock(&s3c2440_clk_ac97);
>         s3c24xx_register_clock(&s3c2440_clk_cam);
>         s3c24xx_register_clock(&s3c2440_clk_cam_upll);
> 

But in the following lines the clocks are disabled again. So if the usage was 
set to '0' on the check above, we get '-1' again.
I would prefer to use your code and additionally do the check again before the 
clocks are disabled. Something like this:

-		clk_disable(&s3c2440_clk_ac97);
-		clk_disable(&s3c2440_clk_cam);
+		if (s3c2440_clk_ac97.usage)
+			clk_disable(&s3c2440_clk_ac97);
+
+		if (s3c2440_clk_cam.usage)
+			clk_disable(&s3c2440_clk_cam);


Mit freundlichen Gr??en/With kind regards

Fabian Godehardt

-- 
Dipl.-Ing. (FH) Fabian Godehardt, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G?ttingen, Germany
Sitz der Gesellschaft: G?ttingen, Amtsgericht G?ttingen HR B 3160
Gesch?ftsf?hrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
