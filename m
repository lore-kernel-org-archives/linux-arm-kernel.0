From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 9 Jun 2015 23:36:15 +0200
Subject: [PATCH 00/34] pinctrl: mvebu: numerous fixes, cleanups and
 improvements
In-Reply-To: <20150609223456.0f569869@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150609170153.GC16778@lunn.ch>
 <20150609212211.625964e2@free-electrons.com>
 <20150609194705.GE16778@lunn.ch>
 <20150609223456.0f569869@free-electrons.com>
Message-ID: <20150609213615.GA32336@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > What does pinctrl do when you ask for a pin which is not a member of the
> > function? If it silently ignores it, not a problem. But i expect it
> > actually throws an error. I could be wrong here, but it looks like it
> > is the mvebu code which checks if a pin is a member of a function.  So
> > it might be possible to set the value of the val in the
> > mvebu_mpp_ctrl_setting to 0xff for the removed NAND pins, and when we
> > see such a value, print a warning about outdated DT, and "succeed"
> > rather than return an error.
> 
> This can only work if the function number is not actually used. For
> example, in the very first patch "pinctrl: mvebu: armada-38x: fix PCIe
> functions" :
> 
> -		 MPP_VAR_FUNCTION(4, "pcie1", "rstout",     V_88F6820_PLUS),
> +		 MPP_VAR_FUNCTION(4, "ge0",   "txerr",      V_88F6810_PLUS),
>
> So the function 4 used to be pcie1, which you would like to still be
> supported, but it's now actually used for ge0.

Isn't 4 a function of the hardware? So this never worked. It is a
bug. So the DT file must also have a bug if this actually affects
anybody. So i would say, no backwards compatibility is required here.
 
> To be honest, I actually prefer that people updating their kernel and
> using an old DT get an error about pin muxing, rather than having the
> driver silently ignore and have people never update their Device Tree.

I also think many people will be keeping there DT file in step with
the kernel. Both get read from /boot by u-boot, or are appended to the
kernel, etc. I doubt there are many Marvell systems which a chunk of
FLASH dedicated to holding the DT blob.
 
> It's also about long term maintainability. Do we want to keep old crap
> around forever in all device drivers?
> 
> > For spi -> spi0 it seems messier. So i would leave it as spi with a
> > comment, and add spi1.
> 
> I'm fine with that.
> 
> What about tdm2c -> tdm renaming on Armada 38x, and tdm-1 -> tdm for one
> single TDM pin on Armada XP ?

Is there an in-kernel use of TDM? I don't think so. So i would just
change them.
 
> I think we're hitting the limits of the DT backward compatibility: our
> description of the hardware had some bugs. What do we do? Continue to
> support bugs?

For true bugs, i say no, we fix it. Renames for which there is no
in-kernel user, just do it. But where there are in-kernel users, which
are not Marvell development boards, we should at least see if there is
a simple and not too ugly way to keep backwards compatibility, and
issue a strong warning it is time to upgrade.

  Andrew
