From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Jun 2015 15:17:08 +0200
Subject: [PATCH 03/34] pinctrl: mvebu: armada-375: remove non-existing
 NAND re/we pins
In-Reply-To: <20150609165843.GB16778@lunn.ch>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150609165843.GB16778@lunn.ch>
Message-ID: <20150616151708.7f07228d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 9 Jun 2015 18:58:43 +0200, Andrew Lunn wrote:

> From armada-375.dtsi:
> 
>                                 nand_pins: nand-pins {
>                                         marvell,pins = "mpp0", "mpp1", "mpp2",
>                                                 "mpp3", "mpp4", "mpp5",
>                                                 "mpp6", "mpp7", "mpp8",
>                                                 "mpp9", "mpp10", "mpp11",
>                                                 "mpp12", "mpp13";
>                                         marvell,function = "nand";
>                                 };
> 
> Don't you also need to remove mpp9 and mpp10 from here? What does
> pinctrl do when you ask for pins which are not a member of the
> function?

In fact, no. Look at the patch:

 	MPP_MODE(9,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x1, "nf", "wen"),
 		 MPP_FUNCTION(0x2, "spi0", "sck"),
 		 MPP_FUNCTION(0x3, "spi1", "sck"),
 		 MPP_FUNCTION(0x5, "nand", "we")),
 	MPP_MODE(10,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x1, "nf", "ren"),
 		 MPP_FUNCTION(0x2, "dram", "vttctrl"),
 		 MPP_FUNCTION(0x3, "led", "c1"),
 		 MPP_FUNCTION(0x5, "nand", "re"),

See how both pins had a "nf" function (0x1) and a "nand" function
(0x5). I didn't even notice that when doing the patch, so my commit log
was slightly confusing.

The "nf" functions were incorrect. The "nand" functions were correct,
and already used by armada-375.dtsi. I have just tested NAND on Armada
375 DB with all the pinctrl patches applied, and it works fine (created
a UBI device, with a volume, etc.).

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
