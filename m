From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Jul 2015 16:27:40 -0700
Subject: [PATCH] Input: pmic8xxx-pwrkey - Support shutdown
In-Reply-To: <20150713231326.GG15178@usrtlx11787.corpusers.net>
References: <1436231329-17997-1-git-send-email-sboyd@codeaurora.org>
 <20150713231326.GG15178@usrtlx11787.corpusers.net>
Message-ID: <20150713232740.GJ30412@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13, Bjorn Andersson wrote:
> On Mon 06 Jul 18:08 PDT 2015, Stephen Boyd wrote:
> 
> > On pm8xxx PMICs, shutdown and restart are signaled to the PMIC
> > via a pin called PS_HOLD. When this pin goes low, the PMIC
> > performs a configurable power sequence. Add a .shutdown hook so
> > that we can properly configure this power sequence for shutdown
> > or restart depending on the system state.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/input/misc/pmic8xxx-pwrkey.c | 287 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 280 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
> 
> [..]
> 
> >  
> >  /**
> >   * struct pmic8xxx_pwrkey - pmic8xxx pwrkey information
> >   * @key_press_irq: key press irq number
> > + * @regmap: device regmap
> 
> Please also document the shutdown_fn.

Sure.

> 
> >   */
> >  struct pmic8xxx_pwrkey {
> >  	int key_press_irq;
> > +	struct regmap *regmap;
> > +	int (*shutdown_fn)(struct pmic8xxx_pwrkey *, bool);
> > +};
> > +
> > +struct pm8xxx_nbs {
> > +	int (*shutdown_fn)(struct pmic8xxx_pwrkey *, bool);
> >  };
> 
> This struct is unused.

Thanks. I switched the approach half-way through and forgot to
delete this struct.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
