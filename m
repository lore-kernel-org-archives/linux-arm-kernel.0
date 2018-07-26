From: tpiepho@impinj.com (Trent Piepho)
Date: Thu, 26 Jul 2018 17:01:36 +0000
Subject: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
In-Reply-To: <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
Message-ID: <1532624495.2283.197.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-26 at 11:46 +0300, Andy Shevchenko wrote:
> > +
> > +       /*
> > +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
> > +        * round up as we look for equal or less speed
> > +        */
> > +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);
> > +       ckrat = roundup(ckrat, 2);
> 
> ckrat += ckrat & 1;

Either way, the compiler produces the same code:

 add r0, r0, #1
 bic r0, r0, #1

I.e., ckrat = (ckrat + 1) & ~1, one "add" and one "and".

Might as well use the macro so it's clear. There is also round_up(x,y),
which I believe is intended to be used only with power of 2 values of
y.
