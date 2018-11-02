From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Fri, 2 Nov 2018 13:04:45 +0200
Subject: [PATCH v2 2/8] clk: clk-max77686: Clean clkdev lookup leak and
 use devm
In-Reply-To: <CAJKOXPd=E+S3j3XnpCVRs3JdStY2z+pHe0bh_HNzQTmJW_dH=Q@mail.gmail.com>
References: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
 <83e985f2f60a68f89fac777aa29c55b1edb8769f.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
 <CAJKOXPd=E+S3j3XnpCVRs3JdStY2z+pHe0bh_HNzQTmJW_dH=Q@mail.gmail.com>
Message-ID: <20181102110445.GC29664@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for taking the time and reviewing this!

On Fri, Nov 02, 2018 at 09:15:17AM +0100, Krzysztof Kozlowski wrote:
> On Thu, 1 Nov 2018 at 08:19, Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> >
> > clk-max77686 never clean clkdev lookup at remove. This can cause
> > oops if clk-max77686 is removed and inserted again. Fix leak by
> > using new devm clkdev lookup registration. Simplify also error
> > path by using new devm_of_clk_add_parent_hw_provider.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/clk/clk-max77686.c | 25 ++++---------------------
> >  1 file changed, 4 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
> > index 02551fe4b87c..b1920c1d9b76 100644
> > --- a/drivers/clk/clk-max77686.c
> > +++ b/drivers/clk/clk-max77686.c
> > @@ -235,7 +235,7 @@ static int max77686_clk_probe(struct platform_device *pdev)
> >                         return ret;
> >                 }
> >
> > -               ret = clk_hw_register_clkdev(&max_clk_data->hw,
> > +               ret = devm_clk_hw_register_clkdev(dev, &max_clk_data->hw,
> >                                              max_clk_data->clk_idata.name, NULL);
> 
> You need to re-align the next line.

I'll change this to
		ret = devm_clk_hw_register_clkdev(dev, &max_clk_data->hw,
						  max_clk_data->clk_idata.name,
						  NULL);
> >                 if (ret < 0) {
> >                         dev_err(dev, "Failed to clkdev register: %d\n", ret);
> > @@ -244,8 +244,8 @@ static int max77686_clk_probe(struct platform_device *pdev)
> >         }
> >
> >         if (parent->of_node) {
> > -               ret = of_clk_add_hw_provider(parent->of_node, of_clk_max77686_get,
> > -                                            drv_data);
> > +               ret = devm_of_clk_add_parent_hw_provider(dev,
> > +                                               of_clk_max77686_get, drv_data);
> 
> The same, please.

I will change this to 
		ret = devm_of_clk_add_parent_hw_provider(dev,
							 of_clk_max77686_get,
							 drv_data);
> 
> Rest looks good, so with these changes:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
