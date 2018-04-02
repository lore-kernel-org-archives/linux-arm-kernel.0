From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 2 Apr 2018 16:17:58 +0900
Subject: [Question] MFD driver that handles clocks/resets and populates child
 nodes
Message-ID: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


Some MFD drivers populate child nodes
after some basic hardware setups.


My question is, is it acceptable to upstream
a MFD driver that handles only clocks/resets,
then calls of_platform_populate.


The probe function will look like follows:


static int uniphier_usb3_glue_probe(struct platform_device *pdev)
{
        [get some clocks];

        [get some resets];

        [enable some clocks];

        [deassert some resets];

        return devm_of_platform_populate(dev);
}


With this driver, the child devices do not need
to handle clocks/resets.
But, I am not sure if it is the right thing to do.



Background of this question
---------------------------

Socionext is trying to upstream
the glue layer for DWC3 USB IP.

The original patch is this.
https://patchwork.kernel.org/patch/10180167/

This driver enables clocks, deassert resets,
and sets up some more registers,
then populates the DWC3 core node.

The maintainer of DWC3, Felipe Balbi, requested to
split the glue layer driver into small parts such as
reset, regulator, phy, etc.

So, the node will look like follows:

   usb-glue {
           reset {
                   ...
           };

           regulator {
                   ...
           };

           hs-phy {
                   ...
           };

           ss-phy {
                   ...
           };
   }

Here, one question popped up.
Where should the hardware resources be described?
The register, clocks, resets are shared among the sub-nodes.
This is the obvious result since it is a single hardware block
in the first place, and we are splitting it into small chunks.


If the MFD driver approach is acceptable,
clocks, resets will be handles in the parent node.
(Such a driver looks stupid, though)


   usb-glue {
           compatible = "socionext,uniphier-ld20-usb3-glue",
                        "syscon";
           reg = <0x65b00000 0x1000>;
           clocks = <sys_clk 14>;
           resets = <sys_clk 14>;

           reset {
                   ...
           };

           regulator {
                   ...
           };

           hs-phy {
                   ...
           };

           ss-phy {
                   ...
           };
   }


Of course, it is possible to use "simple-mfd"
and each driver can repeat the same clock/reset like follows.
(this also looks a bit clumsy...)

   usb-glue {
           compatible = "socionext,uniphier-ld20-usb3-glue",
                        "simple-mfd", "syscon";
           reg = <0x65b00000 0x1000>;

           reset {
                   clocks = <sys_clk 14>;
                   resets = <sys_clk 14>;
                   ...
           };

           regulator {
                   clocks = <sys_clk 14>;
                   resets = <sys_clk 14>;
                   ...
           };

           hs-phy {
                   clocks = <sys_clk 14>;
                   resets = <sys_clk 14>;
                   ...
           };

           ss-phy {
                   clocks = <sys_clk 14>;
                   resets = <sys_clk 14>;
                   ...
           };
   }


Which is better?
Or any other good idea?

Thanks.


-- 
Best Regards
Masahiro Yamada
