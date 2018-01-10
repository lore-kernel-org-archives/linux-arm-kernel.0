From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 10 Jan 2018 08:28:44 +0100
Subject: [PATCH 0/2] pinctrl: meson: use one uniform 'function' name
In-Reply-To: <a6a4ed23-696c-ae2d-9b6a-c2578372b1aa@amlogic.com>
References: <20180108073328.205769-1-yixun.lan@amlogic.com>
 <1515401544.5048.67.camel@baylibre.com>
 <a6a4ed23-696c-ae2d-9b6a-c2578372b1aa@amlogic.com>
Message-ID: <1515569324.5048.103.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-01-10 at 10:12 +0800, Yixun Lan wrote:
> 
> On 01/08/18 16:52, Jerome Brunet wrote:
> > On Mon, 2018-01-08 at 15:33 +0800, Yixun Lan wrote:
> > > These two patches are general improvement for meson pinctrl driver.
> > > It make the two pinctrl trees (ee/ao) to share one uniform 'function' name for
> > > one hardware block even its pin groups live inside two differet hardware domains,
> > > which for example EE vs AO domain here.
> > > 
> > > This idea is motivated by Martin's question at [1]
> > > 
> > > [1]
> > >  http://lkml.kernel.org/r/CAFBinCCuQ-NK747+GHDkhZty_UMMgzCYOYFcNTrRDJgU8OM=Gw at mail.gmail.com
> > > 
> > > 
> > > Yixun Lan (2):
> > >   pinctrl: meson: introduce a macro to have name/groups seperated
> > >   pinctrl: meson-axg: correct the pin expansion of UART_AO_B
> > > 
> > >  drivers/pinctrl/meson/pinctrl-meson-axg.c | 4 ++--
> > >  drivers/pinctrl/meson/pinctrl-meson.h     | 8 +++++---
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > Hi Yixun,
> > 
> > Honestly, I don't like the idea. I think it adds an unnecessary complexity.
> > I don't see the point of FUNCTION_EX(uart_ao_b, _z) when you could simply write 
> > FUNCTION(uart_ao_b_z) ... especially when there is just a couple of function per
> > SoC available on different domains.
> > 
> > A pinctrl driver can already be challenging to understand at first, let's keep
> > it simple and avoid adding more macros.
> > 
> 
> Hi Jerome?
>   In my opinion, the idea of keeping one uniform 'function' in DT (thus
> introducing another macro) is worth considering. It would make the DT
> part much clean.

Ok this is your opinion. I don't share it. Keeping function names tidy is good,
I don't think we need another macro to do so.

>   And yes, it's a trade-off here, either we 1) do more in code to make
> DT clean or 2) do nothing in the code level to make DT live with it.

I don't see how adding a macro doing just string concatenation is going to make
anything more clean. It does not prevent one to write FUNCTION_EX(uart_ao_b,
_gpioz), resulting in uart_ao_b_gpioz, which is what is apparently considered
'not clean'

BTW, there no cleanness issue here, the name is just out of the 'usual scheme'
but there is no problem with. If you want to change this, and
s/uart_ao_b_gpioz/uart_ao_b_z/, now is the time to change it. 

> 
> Yixun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
