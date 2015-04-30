From: mwelling@ieee.org (Michael Welling)
Date: Thu, 30 Apr 2015 13:30:43 -0500
Subject: [PATCH 3/4] clk: si5351: Do not pass struct clk in platform_data
In-Reply-To: <CAOMZO5BYnE2epGrWbnNnaqEt1r6+xoPYWKtjc8w-Ze22aitgXA@mail.gmail.com>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1430415954-29517-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <CAOMZO5BYnE2epGrWbnNnaqEt1r6+xoPYWKtjc8w-Ze22aitgXA@mail.gmail.com>
Message-ID: <20150430183043.GA21890@deathray>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 03:20:38PM -0300, Fabio Estevam wrote:
> On Thu, Apr 30, 2015 at 2:45 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
> 
> >          * property silabs,pll-source : <num src>, [<..>]
> >          * allow to selectively set pll source
> > @@ -1328,8 +1321,17 @@ static int si5351_i2c_probe(struct i2c_client *client,
> >         i2c_set_clientdata(client, drvdata);
> >         drvdata->client = client;
> >         drvdata->variant = variant;
> > -       drvdata->pxtal = pdata->clk_xtal;
> > -       drvdata->pclkin = pdata->clk_clkin;
> > +       drvdata->pxtal = devm_clk_get(&client->dev, "xtal");
> > +       drvdata->pclkin = devm_clk_get(&client->dev, "clkin");
> > +
> > +       if (PTR_ERR(drvdata->pxtal) == -EPROBE_DEFER ||
> > +           PTR_ERR(drvdata->pclkin) == -EPROBE_DEFER)
> > +               return -EPROBE_DEFER;
> > +
> > +       if (IS_ERR(drvdata->pxtal) && IS_ERR(drvdata->pclkin)) {
> 
> Don't you want || instead?

I doubt it. He is checking if both are not available.

The driver could work with only one of them.

If you use || then you assume to need both.
