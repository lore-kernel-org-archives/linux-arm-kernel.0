From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 15 Nov 2015 03:44:09 +0100
Subject: VF610 broken by pinctrl: freescale: imx: allow mux_reg offset zero
Message-ID: <20151115024409.GB2194@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adrian

Your patch

commit e7b37a522aa92da5f47106aa07b6c1fc58bfd922
Author: Adrian Alonso <aalonso@freescale.com>
Date:   Fri Sep 25 16:05:59 2015 -0500

    pinctrl: freescale: imx: allow mux_reg offset zero
    
    Allow mux_reg offset zero to be a valid pin_id, on imx7d
    mux_conf reg offset is zero for iomuxc-lspr controller

has broken VF610.

It looks like you partially reverted

commit 3dac1918a4912cea9375e76cb3916b751cef22db
Author: Stefan Agner <stefan@agner.ch>
Date:   Sat Sep 6 18:25:04 2014 +0200

    pinctrl: imx: detect uninitialized pins
    
    The pinctrl driver initialized the register offsets for the pins
    with 0. On Vybrid an offset of 0 is a valid offset for the pinctrl
    mux register. So far, this was solved using the ZERO_OFFSET_VALID
    flag which allowed offsets of 0. However, this does not allow to
    verify whether a pins struct imx_pmx_func was initialized or not.
    
    Use signed offset values for register offsets and initialize those
    with -1 in order to detect uninitialized offset values reliable.

and in the process you have broken VF610, which also uses offset 0.

What i don't yet understand is why you needed to make this change. If
VF610 can already use mux_reg, why cannot imx7d?

Anyway, it looks like -rc1 is going to be broken on VF610 for some
boards, because this pin is the Ethernet clock input/output. Please
can you get it fixed for -rc2?

Thanks
	Andrew
