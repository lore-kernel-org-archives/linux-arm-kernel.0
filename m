From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 28 Oct 2013 14:30:04 +0100
Subject: [PATCH RFC] ARM: dts: imx6qdl: make pinctrl nodes board specific
In-Reply-To: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
References: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <526E66DC.3090003@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 25.10.2013 05:42, Shawn Guo wrote:
> Currently, all pinctrl setting nodes are defined in <soc>.dtsi, so that
> boards that share the same pinctrl setting do not have to define it time
> and time again in <board>.dts.  However, along with the devices and use
> cases being added continuously, the pinctrl setting nodes under iomuxc
> becomes more than expected.  This bloats device tree blob for particular
> board unnecessarily since only a small subset of those pinctrl setting
> nodes will be used by the board.  It impacts not only the DTB file size
> but also the run-time device tree lookup efficiency.
>
> The patch proposes a solution to avoid this device tree bloating problem
> while still keeping boards share the common pinctrl setting data by
> using DTC macro support.  It creates imx6qdl-pingrp.h and move all those
> pinctrl setting data into there as macro definitions.  The <board>.dts
> will instead define the pinctrl setting nodes that are necessary for the
> board by referring to the macros in imx6qdl-pingrp.h, so that only the
> pinctrl setting data that will be used by the board will get compiled
> into the DTB for the board.
>
> With the changes, the pinctrl setting nodes becomes local to particular
> board, and it makes no sense to continue numbering the setting for
> given peripheral.  Thus, all the pinctrl phandler name gets updated to
> have only peripheral name in there.
>
> Using imx6q-sabresd.dtb today as example, the change shrinks the file
> from 37KiB to 26KiB.

We have a similar problem, some boards need no pin mux at all (it's 
already done by the boot loader), some boards need some pin mux. Doing 
it the way it's done at the moment, we have ~10k dead pin mux stuff in 
the dtb for the boards without any pin mux. As you describe above.

While thinking about several options to solve this, we found

http://permalink.gmane.org/gmane.linux.drivers.devicetree/19694

Adding then something like

&iomuxc {
        status = "disabled";
};

to the dts which don't want any pin mux and then using the 
--strip-disabled option dramatically reduces the resulting dtb size.

There are several pros and cons to consider, though:

Pros:

* You remove additional unused parts, too. Not only the pin mux. I.e. 
the resulting dtb should be even smaller as with only removing the pin mux.

Cons:

* Non mainline dtc patch
* Not boot tested, yet. I have tried this only regarding the size of the 
resulting dtb. I haven't tested if the resulting dtb still boots, i.e. 
if everything essential isn't removed.

Best regards

Dirk
