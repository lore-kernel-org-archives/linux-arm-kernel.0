From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 11 Jun 2010 10:14:35 +0200
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <201006111557.12249.jeremy.kerr@canonical.com>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<1275636608.607067.417709988883.1.gpush@pororo>
	<20100611042046.GA31045@fluff.org.uk>
	<201006111557.12249.jeremy.kerr@canonical.com>
Message-ID: <19473.61547.684572.647641@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > > +static inline int clk_enable(struct clk *clk)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	if (!clk->ops->enable)
> > > +		return 0;
> > > +
> > > +	mutex_lock(&clk->mutex);
> > > +	if (!clk->enable_count)
> > > +		ret = clk->ops->enable(clk);
> > > +
> > > +	if (!ret)
> > > +		clk->enable_count++;
> > > +	mutex_unlock(&clk->mutex);
> > > +
> > > +	return ret;
> > > +}
> > 
Using a mutex in clk_enable()/clk_disable() is a bad idea, since that
makes it impossible to call those functions in interrupt context.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
