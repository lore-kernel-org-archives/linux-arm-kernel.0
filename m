From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Jun 2015 10:08:43 +0200
Subject: [PATCH 00/34] pinctrl: mvebu: numerous fixes, cleanups and
 improvements
In-Reply-To: <20150609213615.GA32336@lunn.ch>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150609170153.GC16778@lunn.ch>
 <20150609212211.625964e2@free-electrons.com>
 <20150609194705.GE16778@lunn.ch>
 <20150609223456.0f569869@free-electrons.com>
 <20150609213615.GA32336@lunn.ch>
Message-ID: <20150610100843.1153368d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 9 Jun 2015 23:36:15 +0200, Andrew Lunn wrote:

> > This can only work if the function number is not actually used. For
> > example, in the very first patch "pinctrl: mvebu: armada-38x: fix PCIe
> > functions" :
> > 
> > -		 MPP_VAR_FUNCTION(4, "pcie1", "rstout",     V_88F6820_PLUS),
> > +		 MPP_VAR_FUNCTION(4, "ge0",   "txerr",      V_88F6810_PLUS),
> >
> > So the function 4 used to be pcie1, which you would like to still be
> > supported, but it's now actually used for ge0.
> 
> Isn't 4 a function of the hardware?

I don't understand your question here. Of course '4' is
hardware-related.

> So this never worked. It is a
> bug. So the DT file must also have a bug if this actually affects
> anybody. So i would say, no backwards compatibility is required here.

How is this different from the NAND case you highlighted for patch
03/34 ? If you have a .dts or .dtsi that does:

	marvell,pins = "mpp12";
	marvell,function = "pcie1";

then this will now generate an error, because there is no longer a
"pcie1" function on mpp12. Just like with PATCH 03/34 there is no
longer a "nf" function on pins mpp9 and mpp10.

> > To be honest, I actually prefer that people updating their kernel and
> > using an old DT get an error about pin muxing, rather than having the
> > driver silently ignore and have people never update their Device Tree.
> 
> I also think many people will be keeping there DT file in step with
> the kernel. Both get read from /boot by u-boot, or are appended to the
> kernel, etc. I doubt there are many Marvell systems which a chunk of
> FLASH dedicated to holding the DT blob.

Agreed.

> > It's also about long term maintainability. Do we want to keep old crap
> > around forever in all device drivers?
> > 
> > > For spi -> spi0 it seems messier. So i would leave it as spi with a
> > > comment, and add spi1.
> > 
> > I'm fine with that.
> > 
> > What about tdm2c -> tdm renaming on Armada 38x, and tdm-1 -> tdm for one
> > single TDM pin on Armada XP ?
> 
> Is there an in-kernel use of TDM? I don't think so. So i would just
> change them.

No, there is no in-kernel use of TDM in the mainline kernel.

> For true bugs, i say no, we fix it. Renames for which there is no
> in-kernel user, just do it. But where there are in-kernel users, which
> are not Marvell development boards, we should at least see if there is
> a simple and not too ugly way to keep backwards compatibility, and
> issue a strong warning it is time to upgrade.

So, what do you propose to do precisely? Here are the patches that are
removing/changing the main name of certain MPP functions:

 * [PATCH 01/34] pinctrl: mvebu: armada-38x: fix PCIe functions
 * [PATCH 02/34] pinctrl: mvebu: armada-370: fix spi0 pin description
 * [PATCH 03/34] pinctrl: mvebu: armada-375: remove non-existing NAND
   re/we pins
 * [PATCH 04/34] pinctrl: mvebu: armada-xp: remove non-existing NAND
   pins
 * [PATCH 05/34] pinctrl: mvebu: armada-xp: remove non-existing VDD
   cpu_pd functions
 * [PATCH 06/34] pinctrl: mvebu: armada-xp: fix functions of MPP48
 * [PATCH 07/34] pinctrl: mvebu: armada-375: remove incorrect space in
   pin description
 * [PATCH 11/34] pinctrl: mvebu: armada-{38x,39x,xp}: normalize naming
   of DRAM functions
 * [PATCH 13/34] pinctrl: mvebu: armada-39x: normalize SDIO pin naming
 * [PATCH 15/34] pinctrl: mvebu: armada-39x: align NAND pin naming
 * [PATCH 16/34] pinctrl: mvebu: armada-{370,375,38x,39x,xp}: normalize
   TDM pins
 * [PATCH 21/34] pinctrl: mvebu: armada-370: align VDD cpu-pd pin
   naming with datasheet
 * [PATCH 23/34] pinctrl: mvebu: armada-xp: rename spi to spi0

What do we do for each of them?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
