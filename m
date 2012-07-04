From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2012 15:23:03 -0300
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CAOMZO5CLV6TuQUTzYUSvoi6apNUtSLhkbh8Jj3onAnc99TWxWg@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
 <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
 <CACKLOr1oeci84Fs7HTRD2Myie8zjKExA15mxM3z7dkq8QfvDmg@mail.gmail.com>
 <CAOMZO5Bdpe43wSAS-D34LzVA9gAKwGTjsw_1f3iPizVsWJW7kw@mail.gmail.com>
 <CACKLOr1OYmoWXCU=Q_0O1H5jYcAGXO11ji6d_j7SjyaLZuygAA@mail.gmail.com>
 <CAOMZO5CLV6TuQUTzYUSvoi6apNUtSLhkbh8Jj3onAnc99TWxWg@mail.gmail.com>
Message-ID: <CAOMZO5A0YXcZOB+ov+dD0MVJr0XSr=Ufg5snGDLvZ9=GyK=xMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 8:41 AM, Fabio Estevam <festevam@gmail.com> wrote:

> So the original mx2_camera patch i sent you plus the clk-imx27.c
> changes (calling clk_register_clkdev again with the
> second name) fixes the issue for you?

Ok, I have tested the mx2_camera patch I sent you plus the one below:

--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -250,8 +250,10 @@ int __init mx27_clocks_init(unsigned long fref)
        clk_register_clkdev(clk[i2c2_ipg_gate], NULL, "imx-i2c.1");
        clk_register_clkdev(clk[owire_ipg_gate], NULL, "mxc_w1.0");
        clk_register_clkdev(clk[kpp_ipg_gate], NULL, "imx-keypad");
-       clk_register_clkdev(clk[emma_ahb_gate], "ahb", "imx-emma");
-       clk_register_clkdev(clk[emma_ipg_gate], "ipg", "imx-emma");
+       clk_register_clkdev(clk[emma_ahb_gate], "ahb", "mx2-camera.0");
+       clk_register_clkdev(clk[emma_ipg_gate], "ipg", "mx2-camera.0");
+       clk_register_clkdev(clk[emma_ahb_gate], "ahb", "m2m-emmaprp.0");
+       clk_register_clkdev(clk[emma_ipg_gate], "ipg", "m2m-emmaprp.0");
        clk_register_clkdev(clk[iim_ipg_gate], "iim", NULL);
        clk_register_clkdev(clk[gpio_ipg_gate], "gpio", NULL);
        clk_register_clkdev(clk[brom_ahb_gate], "brom", NULL);

,and I get the following on probe:

soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
mx2-camera mx2-camera.0: Camera driver attached to camera 0
ov2640 0-0030: Product ID error fb:fb
mx2-camera mx2-camera.0: Camera driver detached from camera 0
mx2-camera mx2-camera.0: MX2 Camera (CSI) driver probed, clock frequency: 665000

Looks like an i2c error when trying to read the ov2640 ID.

Is your camera connected to i2c? Do you get it probed correctly?

Any suggestions are welcome.

Thanks,

Fabio Estevam
