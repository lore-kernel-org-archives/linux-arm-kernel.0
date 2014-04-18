From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 18 Apr 2014 03:47:22 +0000
Subject: [RFC][PATCH 3/3] clocksource: Add Freescale FlexTimer Module
 (FTM) timer support
In-Reply-To: <534FE3C1.4060509@linaro.org>
References: <1397614787-8300-1-git-send-email-Li.Xiubo@freescale.com>
 <1397614787-8300-4-git-send-email-Li.Xiubo@freescale.com>
 <534FE3C1.4060509@linaro.org>
Message-ID: <0604781786e540b5baa98a07d0809c92@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Here using the FTM0 as clock event device and the FTM1 as clock
> > source device.
> 
> As it is a new driver, please add a more elaborated description of the
> timer.
> 

Please see the next version.


> > +#include <linux/clk.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/sched_clock.h>
> 
> Could you check all these headers are effectively needed ?
> 

Yes, I will.



> > +#define FTM_OFFSET(n)	(0x1000 * n)
> > +
> > +#define FTM_SC		0x00
> > +#define FTM_SC_CLK_SHIFT	3
> > +#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
> > +#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
> > +#define FTM_SC_PS_MASK	0x7
> > +#define FTM_SC_TOIE	BIT(6)
> > +#define FTM_SC_TOF	BIT(7)
> > +
> > +#define FTM_CNT		0x04
> > +#define FTM_MOD		0x08
> > +
> > +#define FTM_CSC_BASE	0x0C
> > +#define FTM_CSC_MSB	BIT(5)
> > +#define FTM_CSC_MSA	BIT(4)
> > +#define FTM_CSC_ELSB	BIT(3)
> > +#define FTM_CSC_ELSA	BIT(2)
> > +
> > +#define FTM_CV_BASE	0x10
> > +#define FTM_CNTIN	0x4C
> > +#define FTM_STATUS	0x50
> > +
> > +#define FTM_MODE	0x54
> > +#define FTM_MODE_FTMEN	BIT(0)
> > +#define FTM_MODE_WPDIS	BIT(2)
> > +#define FTM_MODE_PWMSYNC	BIT(3)
> > +
> > +#define FTM_SYNC	0x58
> > +#define FTM_OUTINIT	0x5C
> > +#define FTM_OUTMASK	0x60
> > +#define FTM_COMBINE	0x64
> > +#define FTM_DEADTIME	0x68
> > +#define FTM_EXTTRIG	0x6C
> > +#define FTM_POL		0x70
> > +#define FTM_FMS		0x74
> > +#define FTM_FILTER	0x78
> > +#define FTM_FLTCTRL	0x7C
> > +#define FTM_QDCTRL	0x80
> > +#define FTM_CONF	0x84
> > +#define FTM_FLTPOL	0x88
> > +#define FTM_SYNCONF	0x8C
> > +#define FTM_INVCTRL	0x90
> > +#define FTM_SWOCTRL	0x94
> > +#define FTM_PWMLOAD	0x98
> 
> Please remove the unused macros.
> 

Okay.


> > +
> > +	freq = clk_get_rate(ftm_clk);
> > +
> > +	calc_closest_cound_cyc(freq);
> > +
> > +	BUG_ON(ftm_clocksource_init(freq));
> > +
> > +	BUG_ON(ftm_clockevent_init(freq, irq));
> > +}
> > +CLOCKSOURCE_OF_DECLARE(vf610, "fsl,vf610-ftm-timer", ftm_timer_init);
> 
> 
> I am not a big fan of those BUG_ON every line. Could you please replace
> it by dev_err().
> 
> That is also not in the logic of a single zImage.
> 

Yes, if so, I will revise this.


Thanks,

BRs
Xiubo
