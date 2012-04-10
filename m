From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 10 Apr 2012 11:49:28 +0800
Subject: [PATCH 1/1] pinctrl: add some error checking for user interfaces
In-Reply-To: <4F82FA2A.3090604@wwwdotorg.org>
References: <1333967409-8168-1-git-send-email-b29396@freescale.com>
 <4F82FA2A.3090604@wwwdotorg.org>
Message-ID: <20120410034927.GA674@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2012 at 11:03:06PM +0800, Stephen Warren wrote:
> On 04/09/2012 04:30 AM, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > This patch can avoid kernel oops in case the mux or config
> > function is not supported by driver.
> > 
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > ---
> >  drivers/pinctrl/pinconf.c |    4 ++++
> >  drivers/pinctrl/pinmux.c  |   15 +++++++++++++--
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
> > index eb3a14f..384dcc1 100644
> > --- a/drivers/pinctrl/pinconf.c
> > +++ b/drivers/pinctrl/pinconf.c
> > @@ -448,8 +448,12 @@ static void pinconf_dump_pin(struct pinctrl_dev *pctldev,
> >  static int pinconf_pins_show(struct seq_file *s, void *what)
> >  {
> >  	struct pinctrl_dev *pctldev = s->private;
> > +	const struct pinconf_ops *ops = pctldev->desc->confops;
> >  	unsigned i, pin;
> >  
> > +	if (!ops || !ops->pin_config_get)
> > +		return 0;
> 
> I don't think this is necessary; it looks like this function (and those
> it calls) always checks ops where they're used.
> 
Yes, it's true.
But it will still dump all pins configs although there's no config value
which is almost the same as another debug entry 'pins'.
It looks it does not make too much sense to dump this info if no config support.
The existing pinconf_group_show did like this way(no output).
So i changed pinconf_pins_show in the same behavior as pinconf_group_show.

Do you think it's reasonable?

Regards
Dong Aisheng
