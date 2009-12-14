From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 14 Dec 2009 11:14:07 +0100
Subject: [PATCH 1/4] mfd: mc13783: Take care of semantic inversion
	between read and write value of two bits in POWER_MISCELLANEUS
	register.
In-Reply-To: <20091213195606.GA14024@pengutronix.de>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<20091213195606.GA14024@pengutronix.de>
Message-ID: <1260785647.2022.28.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe..

Il giorno dom, 13/12/2009 alle 20.56 +0100, Uwe Kleine-K?nig ha scritto:
> On Sat, Dec 12, 2009 at 05:48:43PM +0100, Alberto Panizzo wrote:
> > MC13783_REGCTRL_PWGTnSPIEN controls the states of the corresponding
> > PWGTn_DRV output.
> > Reading 1 on the corresponding bit mean that the output is enabled
> > Writing 1 on the corresponding bit disable that output!
> > 
> > So, if not asked directly to modify those bits, write the inverted
> > value.
> Hmm, I'm not sure this completely right.  The Spec has:
> 
>         Bit PWGTxSPIEN | Pin PWGTxEN | PWGTxDRV |  Read Back
>           0 = default  |             |          | PWGTxSPIEN
>         ---------------+-------------+----------+------------
>               1        |      x      |   Low    |     0
>               0        |      0      |   High   |     1
>               0        |      1      |   Low    |     0
> 
> So it looks a bit harder than just inverting the read bit.
> 
> Best regards
> Uwe
> 

Yes, it is a bit harder, and because we don't have the complete 
information (we cannot check via software the state of Pin PWGTxEN)
the problem have no complete solution: if the read back value is 0 what I
choose is to assign to the software the master part.

We have to decide what to do, the other option is to write always 0 
(that's what the freescale code do) to let the hardware control itself.
This one for my board work as well, but it is the same, it is not a
complete solution.

Maybe we can trace via software the state of those two bits, starting
from an initial value, 0? (maybe the bootloader wrote 1 on those..)

Alberto.
