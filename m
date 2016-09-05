From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 Sep 2016 11:27:28 +0200
Subject: [PATCH v3 4/5] net: stmmac: add a glue driver for the Amlogic
 Meson 8b / GXBB DWMAC
In-Reply-To: <CAFBinCCVUhUVyceGc2capcCPOK8MTsn+RcC9gnrtMVvZUENXtQ@mail.gmail.com>
References: <20160820093538.9707-1-martin.blumenstingl@googlemail.com>
 <20160830191906.GD12510@codeaurora.org>
 <CAFBinCCVUhUVyceGc2capcCPOK8MTsn+RcC9gnrtMVvZUENXtQ@mail.gmail.com>
Message-ID: <8189845.3pyN0uTLGL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, September 4, 2016 8:20:15 PM CEST Martin Blumenstingl wrote:
> 
> >> +     dwmac->m25_div_clk = devm_clk_register(dev, &dwmac->m25_div.hw);
> >> +     if (WARN_ON(PTR_ERR_OR_ZERO(dwmac->m25_div_clk)))
> >> +             return PTR_ERR(dwmac->m25_div_clk);
> >> +
> >> +     return 0;
> >
> > This could be return WARN_ON(PTR_ERR_OR_ZERO(...))
> This would work as well but I prefer the way it is right now (as one
> could easily extend the code without having to touch any existing code
> apart from the last return).
> However, as it's always the case with personal preference: if
> coding-style requires me to change it then I'll do so, just let me
> know.
> 
> I have addressed all other issues you found (thanks for that!) in v4
> (which I am about to send in the next few minutes).


Both of these are fairly unusual. The most common way to write it is

	if (WARN_ON(IS_ERR(dwmac->m25_div_clk)))
		return PTR_ERR(dwmac->m25_div_clk);
   return 0;

However, I now tend to prefer

	ret = PTR_ERR_OR_ZERO(dwmac->m25_div_clk);
	WARN_ON(ret);
	return ret;

which is less likely to cause false-positive warnings when building
with -Wmaybe-uninitialized than any of the other ones.

Please don't use PTR_ERR_OR_ZERO() as a condition, that is what
IS_ERR() is meant for.

	Arnd
