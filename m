From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 18 Sep 2012 08:11:55 +0200
Subject: [PATCH 5/7] pwm: i.MX: add devicetree support
In-Reply-To: <20120912090458.GN6180@pengutronix.de>
References: <1347267577-3296-1-git-send-email-s.hauer@pengutronix.de>
 <1347267577-3296-6-git-send-email-s.hauer@pengutronix.de>
 <20120911144043.GA3824@avionic-0098.mockup.avionic-design.de>
 <20120912090458.GN6180@pengutronix.de>
Message-ID: <20120918061154.GB1459@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 11:04:58AM +0200, Sascha Hauer wrote:
> On Tue, Sep 11, 2012 at 04:40:43PM +0200, Thierry Reding wrote:
> > On Mon, Sep 10, 2012 at 10:59:35AM +0200, Sascha Hauer wrote:
> > > From: Philipp Zabel <p.zabel@pengutronix.de>
> > > 
> > > At the same time remove platform based support. No user for
> > > this driver has made it into mainline so far, so all we break
> > > is out of tree stuff.
> > > 
> > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> > > Reviewed-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
> > [...]
> > 
> > I was just doing some build tests on the series and noticed that it
> > fails with this:
> > 
> > 	  CC [M]  drivers/pwm/pwm-imx.o
> > 	/home/thierry.reding/src/kernel/linux-pwm.git/drivers/pwm/pwm-imx.c: In function 'imx_pwm_config_v2':
> > 	/home/thierry.reding/src/kernel/linux-pwm.git/drivers/pwm/pwm-imx.c:140:2: error: implicit declaration of function 'cpu_is_mx25' [-Werror=implicit-function-declaration]
> > 
> > This breaks bisection in the middle of the series. It seems to be
> > related to this change.
> > 
> > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > index a1e799e..b4e0ad3 100644
> > > --- a/drivers/pwm/pwm-imx.c
> > > +++ b/drivers/pwm/pwm-imx.c
> > > @@ -16,8 +16,7 @@
> > >  #include <linux/clk.h>
> > >  #include <linux/io.h>
> > >  #include <linux/pwm.h>
> > > -#include <mach/hardware.h>
> > 
> > This probably needs to be postponed to the next patch, until the final
> > reference to cpu_is_mx25() is removed.
> 
> Oops, you are right. I updated the tag accordingly, and did a full
> compile test over this series, so please pull again:
> 
> 
> The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> 
>   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-pwm-oftree
> 
> for you to fetch changes up to a1d38ca9e249e670aa9f608e1cc7491fb4ca45af:
> 
>   pwm: i.MX: fix clock lookup (2012-09-12 11:00:55 +0200)
> 
> ----------------------------------------------------------------
> Cleanup i.MX PWM driver and add devicetree support
> 
> ----------------------------------------------------------------
> Philipp Zabel (2):
>       pwm: i.MX: add devicetree support
>       pwm: i.MX: fix clock lookup
> 
> Sascha Hauer (5):
>       pwm: i.MX: factor out SoC specific functions
>       pwm: i.MX: remove unnecessary if in pwm_[en|dis]able
>       pwm: i.MX: add functions to enable/disable pwm.
>       pwm: i.MX: Use module_platform_driver
>       pwm: i.MX: use per clock unconditionally
> 
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt |   17 ++
>  drivers/pwm/pwm-imx.c                             |  278 ++++++++++++++-------
>  2 files changed, 199 insertions(+), 96 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.txt

Applied, thanks. On a side note, I decided to pull the branch, extract
the patches and apply them to my tree with git am, so this won't show up
as a proper merge. This is all still pretty new to me and I'm still in
the process of finding out what works best, so I hope you don't mind.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120918/c2c1a27a/attachment.sig>
