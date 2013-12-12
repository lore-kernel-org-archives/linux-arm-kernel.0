From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Thu, 12 Dec 2013 15:12:50 -0500
Subject: [PATCH v2] ARM: dts: vf610: make pinctrl nodes board specific
In-Reply-To: <87mwk5eugj.fsf@nbsps.com> (Bill Pringlemeir's message of "Thu,
 12 Dec 2013 14:32:28 -0500")
References: <1386571837-16299-1-git-send-email-shawn.guo@linaro.org>
 <1386686213-13801-1-git-send-email-shawn.guo@linaro.org>
 <87mwk5eugj.fsf@nbsps.com>
Message-ID: <87haadesl9.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 Dec 2013, bpringlemeir at nbsps.com wrote:

> On 10 Dec 2013, shawn.guo at linaro.org wrote:
>
>> Currently, all pinctrl setting nodes are defined in <soc>.dtsi, so that
>> boards that share the same pinctrl setting do not have to define it time
>> and time again in <board>.dts.  However, along with the devices and use
>> cases being added continuously, the pinctrl setting nodes under iomuxc
>> becomes more than expected.  This bloats device tree blob for particular
>> board unnecessarily since only a small subset of those pinctrl setting
>> nodes will be used by the board.  It impacts not only the DTB file size
>> but also the run-time device tree lookup efficiency.

>> arch/arm/boot/dts/vf610-pingrp.h   |  127 ++++++++++++++++++++++++++

> Thanks for including this file.  I was looking a NAND flash and the
> common configuration are 8/16 bit.  This solution is better as,

Actually, this is a generic file but we have,

+#define VF610_SAI2_PINGRP1 \
+	VF610_PAD_PTA16__SAI2_TX_BCLK		0x02ed \
+	VF610_PAD_PTA18__SAI2_TX_DATA		0x02ee \
+	VF610_PAD_PTA19__SAI2_TX_SYNC		0x02ed \
+	VF610_PAD_PTA21__SAI2_RX_BCLK		0x02ed \
+	VF610_PAD_PTA22__SAI2_RX_DATA		0x02ed \
+	VF610_PAD_PTA23__SAI2_RX_SYNC		0x02ed \
+	VF610_PAD_PTB18__EXT_AUDIO_MCLK		0x02ed

The SAI might not use 'VF610_PAD_PTB18__EXT_AUDIO_MCLK' nor either
'VF610_PAD_PTA16__SAI2_TX_BCLK' or 'VF610_PAD_PTA21__SAI2_RX_BCLK'.
There are some pins that are absolutely needed for a module to function
and then there are some optional pins.

That said, this is nothing that you have changed.  It was like this to
begin with in the generic 'vf610.dtsi' file.

For instance some designs may have NAND flash CS0 and CS1 and other may
only include one (or they have no NAND at all).  Anything that uses the
NAND flash driver needs at least,

	VF610_PAD_PTD23__NF_IO7		0x28df
	VF610_PAD_PTD22__NF_IO6		0x28df
	VF610_PAD_PTD21__NF_IO5		0x28df
	VF610_PAD_PTD20__NF_IO4		0x28df
	VF610_PAD_PTD19__NF_IO3		0x28df
	VF610_PAD_PTD18__NF_IO2		0x28df
	VF610_PAD_PTD17__NF_IO1		0x28df
	VF610_PAD_PTD16__NF_IO0		0x28df
	VF610_PAD_PTB24__NF_WE_B	0x28c2
	VF610_PAD_PTB27__NF_RE_B	0x28c2
	VF610_PAD_PTC26__NF_RB_B	0x280d
	VF610_PAD_PTC27__NF_ALE		0x28c2
	VF610_PAD_PTC28__NF_CLE		0x28c2

and one of,

	VF610_PAD_PTB25__NF_CE0_B	0x28c2
        VF610_PAD_PTB26__NF_CE1_B	0x28c2

For the SAI, I am pretty sure that there are multiple master clocks
possible and that for synchronous modes, only one TX or RX clk is needed
and possibly the SYNC as well (I am thinking I2S).  If these are generic
definitions for any board, then maybe they should be separated more or
the group should be 'VF610_TWR_SAI2_PINGRP1'; Ie, particular to the
machine.

Anyways, this is a pre-existing issue.

Fwiw,
Bill Pringlemeir.
