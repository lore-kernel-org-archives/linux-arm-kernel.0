From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 13:59:03 +0800
Subject: Question: Common clock framework, (Mux + Divider)
In-Reply-To: <CAF1ZMEeE-vJ7chGggPbaS4L2QghDJSegw4zg+LHGhYT1-CMD9g@mail.gmail.com>
References: <CAF1ZMEeE-vJ7chGggPbaS4L2QghDJSegw4zg+LHGhYT1-CMD9g@mail.gmail.com>
Message-ID: <20120427055901.GK2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 07:10:35PM +0800, Dennis.Yxun wrote:
> HI Shawn:
> 
>   I've looked at the code which you implement the common clock framework
> for mxs
> and I notice that you extend the fixed clock with clk-fixed-factor (support
> multi and divider)

I assume you are talking about drivers/clk/mxs/clk-frac.c.  It's not
an extension of clk-fixed-factor but a mxs specific implementation on
its own.

> However I think the actually case may more complicated than this, say clock
> could be
> div1 = (bit[1] == 1) ? 4 : 8;
> mul1 = (bit[4:3] << 2)
> mul2 = bit[12:8]
> b = (a * mul1 * mul2) / (div2 -1)
>   Here difference is actually the algorithm, but should we provide specific
> implementation, say create struct clk_foo?
> or can we extend the framework, to just call our own customize algorithm?
> 
I'm not ready to say this should be implemented as a generic clock, and
that's why I chose to create mxs specific clk-frac.

>   then how about the clk framework handle mux plus divider case (see the
> dagram)
> can we also extend as drivers/clk/clk-mux-divider.c? so others could get
> benefits.
> 
>  a ----\
>  b -----\ ------ d   ,    d = ( a  or b or c ) /divider
>  c-----/
> 
> or could we handle this with following, crate virtual clock like a', b',c'
> a -- a' --\
> b -- b' --\ ---d
> c -- c' --/
> a -- > a' , b --> b' , c --> c' could be handled with clk-divider
> a', b',c' -> d could be handled with clk-mux
> 
That's should be the case, and it's the whole point we have those basic
clks in framework.

-- 
Regards,
Shawn
