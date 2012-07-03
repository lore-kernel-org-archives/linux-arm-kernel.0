From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 Jul 2012 15:46:47 +0100
Subject: [PATCH] can: flexcan: add a regulator for transceiver
In-Reply-To: <20120703141829.GG22705@S2101-09.ap.freescale.net>
References: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
 <20120703130747.GD25995@sirena.org.uk>
 <20120703141829.GG22705@S2101-09.ap.freescale.net>
Message-ID: <20120703144646.GT29030@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 10:18:31PM +0800, Shawn Guo wrote:
> On Tue, Jul 03, 2012 at 02:07:47PM +0100, Mark Brown wrote:

> > No, the regulator API will stub itself out if not enabled, and if the
> > supply is fixed then a fixed voltage regulator will do the job.  We
> > shouldn't be open coding this stuff in individual users.

> Ah, yes.  But when you say "a fixed voltage regulator", you actually
> meant dummy regulator, right?

No, I really do mean a fixed voltage regulator.  Dummy regulators should
essentially never be used in production.

>  static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
>  {
> +       if (on)
> +               regulator_enable(priv->reg_xcvr);
> +       else
> +               regulator_disable(priv->reg_xcvr);
> +

So long as the stack guarantees that you won't get unbalanced calls to
this and...

> +       priv->reg_xcvr = devm_regulator_get(&pdev->dev, "xcvr");

...add error checking here the code should be fine, yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120703/782081de/attachment.sig>
