From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Tue, 29 Jul 2014 14:56:41 -0400
Subject: [PATCHv2 2/3] ARM: dts: vf610-twr: Add PWM0's pinctrl node
In-Reply-To: <1395627736-5338-3-git-send-email-Li.Xiubo@freescale.com> (Xiubo
 Li's message of "Mon, 24 Mar 2014 10:22:15 +0800")
References: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
 <1395627736-5338-3-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <8738dkuh7a.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 Mar 2014, Li.Xiubo at freescale.com wrote:

> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
> arch/arm/boot/dts/vf610-twr.dts | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/vf610-twr.dts
> b/arch/arm/boot/dts/vf610-twr.dts index f3af8ea..3fabdb5 100644 ---
> a/arch/arm/boot/dts/vf610-twr.dts +++
> b/arch/arm/boot/dts/vf610-twr.dts @@ -213,6 +213,17 @@
> 			>;
> 		};
>
> + pinctrl_pwm0: pwm0grp { + fsl,pins = < + VF610_PAD_PTB0__FTM0_CH0

Hi Xiubo,

I think you added this for the tower audio board?  Maybe the beeper?
Are these lines needed?

+	VF610_PAD_PTB6__FTM0_CH6		0x1582
+	VF610_PAD_PTB7__FTM0_CH7		0x1582

According to my tower schematics, PTB6 routes to the Primary B35/GPIO4,
and B40/FTM0CH6/PWM4 and to the jumpers J23.  PTB7 routes to
B39/FTM0CH7/PWM5, EIRQ3/B55/B56, and jumper J24.  I think that most
people have some tower serial card which can also route these lines
and/or they are sent to the OpenSDA chip which does a ttyACM (USB
serial) on all Tower main boards.

Did you just add all FTM channels 0-7 in the DTS?  Or are each and every
one mapped to a pin on the expansion/riser boards.  Could we remove the
two lines above and use,

	pinctrl_uart2: uart2grp {
		fsl,pins = <
                        VF610_PAD_PTB6__UART2_TX                0x21a2
                        VF610_PAD_PTB7__UART2_RX                0x21a1
		>;
	};

So that the PTB6/7 map to UART2?  Or are these indeed a conflict with
some audio board (or other)?  I think it might be valuable to add the
'ttyLP2' to the vf610-twr.  An MMC image could echo 'wrong serial port,
set J23/24' for instance to tell people that the serial console was not
connected properly (or something else).  People may also wish to use a
serial interface for other peripherals or as a 2nd debug port.

Thanks,
Bill Pringlemeir.
