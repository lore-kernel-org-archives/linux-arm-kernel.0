From: swboyd@chromium.org (Stephen Boyd)
Date: Wed, 21 Mar 2018 13:04:36 -0700
Subject: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <1521655629.23017.84.camel@linux.intel.com>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <1521655629.23017.84.camel@linux.intel.com>
Message-ID: <152166267662.91116.8188392814465278915@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Andy Shevchenko (2018-03-21 11:07:09)
> On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
> > +static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned
> > offset)
> > +{
> > +     struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> > +     struct gpio_chip *chip = &pctrl->chip;
> > +
> > +     if (gpiochip_line_is_valid(chip, offset))
> > +             return 0;
> > +
> > +     return -EINVAL;
> 
> Perhaps traditional pattern
> 
> if (!...)
>  return -EINVAL;
> 
> return 0;
> 

Or ternary?

  return gpiochip_line_is_valid(chip, offset) ? 0 : -EINVAL;

> 
> > +}
> 
> >       seq_printf(s, " %dmA", msm_regval_to_drive(drive));
> > -     seq_printf(s, " %s", pulls[pull]);
> > +     seq_printf(s, " %s\n", pulls[pull]);
> 
> I had commented this once, but you ignored by some reason.
> 
> I would rather just move 
>  seq_puts(s, "\n");
> here.
> 
> The rationale behind, besides making diff more neat, is to reduce
> possible burden in the future if someone would like to squeeze more data
> in between.

Sure.

> 
> > +             tmp = kmalloc_array(len, sizeof(tmp[0]), GFP_KERNEL);
> 
> sizeof(*tmp) ?
> 

Ok.
