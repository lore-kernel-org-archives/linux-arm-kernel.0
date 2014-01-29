From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 29 Jan 2014 11:42:11 +0100
Subject: [PATCH 2/9] ARM: dts: imx6sl: remove the use of pingrp macros
In-Reply-To: <20140128112047.GC20583@S2101-09.ap.freescale.net>
References: <1390668191-20289-1-git-send-email-shawn.guo@linaro.org>
 <5923680.sl3G3EgCsY@phil> <20140128112047.GC20583@S2101-09.ap.freescale.net>
Message-ID: <8644666.oTYOihNRNU@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, 28. January 2014 19:20:49 Shawn Guo wrote:
> On Tue, Jan 28, 2014 at 11:17:22AM +0100, Heiko St?bner wrote:
> > [... and so on for the other groups ... ]
> > 
> > I'm confused now :-) . Current linux-next [0] shows the pin-settings as
> > part of imx6sl.dtsi - a way a lot of other architectures organize their
> > pingroups too, with the board file only referencing the relevant
> > pingroups from the predefined ones of the soc.
> > 
> > So I guess your move to the pingrp-header moved them out of the
> > imx6sl.dtsi to the .h and is not part of linux-next;
> 
> Yes, my for-next branch was excluded from linux-next temporarily for
> some reason.  I will ask Stephen to add it back once v3.14-rc1 is out.
> That said, you can see nothing we developed in this cycle on linux-next
> for now.
> 
> > but this patch (and the others in this
> > series) now moves the definitions into the individual board files. Can't
> > you just move them back to the soc-dtsi files to prevent each board
> > duplicating them?
> 
> No.  That will bring back the problem we try to solve from the
> beginning [1].
>
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/275912/

Thanks for the pointer, I think I understand the issue now :-) .

So for the short term, I should probably also define the pingroups in my board-
dts then.


But as an insane idea that I just had, because the issue will probably affect 
more architectures at some point when their pingroups or other common-nodes 
grow, how about introducing something like a "/delete-if-unreferenced/" prefix 
in dtc?

As I could see in [0], adding something to dtc is not as far off as I thought.

In essence one would add the pingroups to the soc dtsi, like

		ecspi1 {
			/delete-if-unreferenced/ pinctrl_ecspi1_1: ecspi1grp-1 {
				fsl,pins = <
					MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO 0x100b1
					MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI 0x100b1
					MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK 0x100b1
				>;
			};
		};

and dtc would then be tasked with checking if the node gets referenced in a 
phandle somewhere in the dts and if not removing it.

I don't know if this is at all sane to think about or doable in dtc.


Heiko

[0] http://www.spinics.net/lists/arm-kernel/msg300936.html
