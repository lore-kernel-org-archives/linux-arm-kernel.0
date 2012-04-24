From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 24 Apr 2012 14:51:00 +0200
Subject: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <20120424120019.GE24089@lunn.ch>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
 <20120424120019.GE24089@lunn.ch>
Message-ID: <20374.41396.280974.710188@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Andrew Lunn writes:
> > -#if defined(CONFIG_HAVE_CLK)
> >  	hpriv->clk = clk_get(&pdev->dev, NULL);
> > -	if (IS_ERR(hpriv->clk))
> > -		dev_notice(&pdev->dev, "cannot get clkdev\n");
> > -	else
> > -		clk_enable(hpriv->clk);
> > -#endif
> > +	if (IS_ERR(hpriv->clk)) {
> > +		dev_err(&pdev->dev, "cannot get clkdev\n");
> > +		return PTR_ERR(hpriv->clk);
> > +	}
> > +
> > +	clk_enable(hpriv->clk);
> 
> Sorry, but still wrong.
> 
> The clock is optional. If we can find a clock, turn it on. If not,
> keep going....
> 
> You patch causes the missing clock to become a fatal error.
> 
The clock API should accept NULL pointers as valid clocks and
treat them as NOP.
Thus drivers wouldn't have to worry about whether they actually got a
clock to manage or if their clocks are just dummies.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
