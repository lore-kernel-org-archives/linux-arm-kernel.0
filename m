From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 23:28:15 +0800
Subject: [PATCH] can: flexcan: add a regulator for transceiver
In-Reply-To: <20120703144646.GT29030@opensource.wolfsonmicro.com>
References: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
 <20120703130747.GD25995@sirena.org.uk>
 <20120703141829.GG22705@S2101-09.ap.freescale.net>
 <20120703144646.GT29030@opensource.wolfsonmicro.com>
Message-ID: <20120703152813.GI22705@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 03:46:47PM +0100, Mark Brown wrote:
> On Tue, Jul 03, 2012 at 10:18:31PM +0800, Shawn Guo wrote:
> > On Tue, Jul 03, 2012 at 02:07:47PM +0100, Mark Brown wrote:
> 
> > > No, the regulator API will stub itself out if not enabled, and if the
> > > supply is fixed then a fixed voltage regulator will do the job.  We
> > > shouldn't be open coding this stuff in individual users.
> 
> > Ah, yes.  But when you say "a fixed voltage regulator", you actually
> > meant dummy regulator, right?
> 
> No, I really do mean a fixed voltage regulator.  Dummy regulators should
> essentially never be used in production.
> 
In that case, my patch may need to stay unchanged.  Some systems have
a supply controlled by gpio and we need to have it be a Linux regulator
to switch it, while other systems have the supply non-switchable which
can be reasonably invisible to software.  That said, the regulator is
optional and the failure of devm_regulator_get should not make the
driver probe fail.

I guess your suggestion here is to make the regulator mandatory for
the driver, which means those non-switchable supplies have to be
also defined as Linux regulators for every single system.  I'm not
sure we want to do that just for saving a regulator pointer check.

> >  static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
> >  {
> > +       if (on)
> > +               regulator_enable(priv->reg_xcvr);
> > +       else
> > +               regulator_disable(priv->reg_xcvr);
> > +
> 
> So long as the stack guarantees that you won't get unbalanced calls to
> this and...
> 
> > +       priv->reg_xcvr = devm_regulator_get(&pdev->dev, "xcvr");
> 
> ...add error checking here the code should be fine, yes.

-- 
Regards,
Shawn
