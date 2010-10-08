From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Oct 2010 19:51:27 +0900
Subject: [PATCH 3/10] ARM: S5PC100: Add SCLK_SPDIF clock
In-Reply-To: <AANLkTinZuMkDNotnwDFS8_EPhbG+p_GWEZjU5thzvW++@mail.gmail.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286192545-18327-1-git-send-email-sw.youn@samsung.com>
	<001901cb66d1$32db1e10$98915a30$%kim@samsung.com>
	<AANLkTinZuMkDNotnwDFS8_EPhbG+p_GWEZjU5thzvW++@mail.gmail.com>
Message-ID: <001f01cb66d6$c5c33410$51499c30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seungwhan Youn wrote:
> 
> Hi,
> 
> >> +static int s5pc100_spdif_set_rate(struct clk *clk, unsigned long rate)
> >> +{
> >> +     struct clk *pclk;
> >> +     int ret;
> >> +
> >> +     pclk = clk_get_parent(clk);
> >> +     if (IS_ERR(pclk))
> >> +             return -EINVAL;
> >> +
> >> +     ret = pclk->ops->set_rate(pclk, rate);
> >> +     clk_put(pclk);
> >> +
> >> +     return ret;
> >
> > How about following?
> >
> > static int parent_set_rate(struct clk *clk, unsigned long rate)
> > {
> >        struct clk *p_clk;
> >        int ret;
> >
> >        p_clk = clk_get_parent(clk);
> >        ret = clk_set_rate(p_clk, rate);
> >
> >        clk_put(p_clk);
> >
> >        return ret;
> > }
> >
> > Hmm...isn't there any method?...
> 
> I think you mean is that adds a new clock api function that sets
> parent clock rate.(am I right?) But as you know, this also needs that

If possible?...yes.

> S/PDIF knows it's source clock can not set rate directly and set it's
> parent clock.
> 
Hmm...ok.

> Actually my point was that I want to make S/PDIF does not care about
> clock characteristics, so I did make it solve in clock part, not in
> audio driver. And also, I do not want to modify a common function
> 'clk_set_rate()' that can support jassi's opinion, because I'm not
> sure about side effect that I can not grantee it's safety with other
> drivers.
> 
Oh yes...it's expected recursive lockup or any side effect in this case.

Ok...Firstly will apply this...but we need to sort out this later.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
