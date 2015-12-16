From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Dec 2015 08:11:20 -0200
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <20151216041058.GC23482@shlinux2>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
 <CAOMZO5CfBKuJ584jwbg98s9tn+0Z7W0nOaZnUkm4cJUSvNGTZw@mail.gmail.com>
 <20151215062821.GA11241@shlinux2>
 <CAOMZO5DiRzfy5dULh0C7qU2KUM-i8fBh6W5rS9zOTHJJK6fqwg@mail.gmail.com>
 <20151216041058.GC23482@shlinux2>
Message-ID: <CAOMZO5An3CK-a3NQtOF3nnPc8vzu2+SKnfJ=iOuAhjCBvZwToQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Wed, Dec 16, 2015 at 2:11 AM, Peter Chen <peter.chen@freescale.com> wrote:

> Thanks, Fabio, but I am curious how things like that? The USBOH3 clock
> is not opened, the usb driver will hang when it tries to access
> registers. If this clock is always on, then, why the system will
> hang later?

I found the issue with your patch. You missed to add the pinctrl node.

With the change below USB is functional in Udoo:

--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -22,6 +22,8 @@

        usb_hub1 {
                compatible = "generic-onboard-hub";
+               pinctrl-names = "default";
+               pinctrl-0 = <&pinctrl_usbh>;
                clocks = <&clks IMX6QDL_CLK_CKO>;
                reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
                reset-duration-us = <2>;
