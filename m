From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 14 Dec 2013 13:41:00 +0800
Subject: [PATCH v2] ARM: dts: vf610: make pinctrl nodes board specific
In-Reply-To: <87mwk5eugj.fsf@nbsps.com>
References: <1386571837-16299-1-git-send-email-shawn.guo@linaro.org>
 <1386686213-13801-1-git-send-email-shawn.guo@linaro.org>
 <87mwk5eugj.fsf@nbsps.com>
Message-ID: <20131214054058.GA6903@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 02:32:28PM -0500, Bill Pringlemeir wrote:
> On 10 Dec 2013, shawn.guo at linaro.org wrote:
> 
> > Currently, all pinctrl setting nodes are defined in <soc>.dtsi, so that
> > boards that share the same pinctrl setting do not have to define it time
> > and time again in <board>.dts.  However, along with the devices and use
> > cases being added continuously, the pinctrl setting nodes under iomuxc
> > becomes more than expected.  This bloats device tree blob for particular
> > board unnecessarily since only a small subset of those pinctrl setting
> > nodes will be used by the board.  It impacts not only the DTB file size
> > but also the run-time device tree lookup efficiency.
> 
> > arch/arm/boot/dts/vf610-pingrp.h   |  127 ++++++++++++++++++++++++++
> 
> Thanks for including this file.  I was looking a NAND flash and the
> common configuration are 8/16 bit.  This solution is better as,
> 
>    #define VF610_NFC_PINGRP_8BIT \
>      ...
> 
>    #define VF610_NFC_PINGRP_16BIT \
>      VF610_NFC_PINGRP_8BIT        \
>      VF610_PAD_PTD31__NF_IO15	0x28df \
>      VF610_PAD_PTD30__NF_IO14	0x28df \
>      VF610_PAD_PTD29__NF_IO13	0x28df \
>      ...
> 
> It makes the board file look more straight forward,

Yes, I agree.

> 
>    &nfc {  /* 16 bit with group in group */
>            /* ... */
>            pinctrl-names = "default";
>            pinctrl-0 = <&pinctrl_nfc_16bit>;
>    };
> 
> Versus,
> 
>    &nfc {  /* old way _OR_ separate groups */
>            /* ... */
>            pinctrl-names = "default";
>            pinctrl-0 = <&pinctrl_nfc_8bit>; /* 8-bit */
>            pinctrl-1 = <&pinctrl_nfc_16_bit>; /* 16-bit extras */
>    };
> 
> Although for a 'multi-machine' configuration, the sharing maybe
> appropriate?  But I guess that is your point; it is not helpful.  
> 
> Is a group within a group appropriate in vf610-pingrp.h?  Maybe a
> comment?

Yes, it is.  We already have something like that for USDHC in
arch/arm/boot/dts/imx6qdl-pingrp.h if you're looking at my for-next
branch.

Shawn
