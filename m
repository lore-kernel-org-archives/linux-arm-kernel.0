From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon, 13 Mar 2017 11:49:01 -0700
Subject: [PATCH v1] soc: rockchip: power-domain: Fix clang warning about
 negative shift count
In-Reply-To: <20170313172222.GA50582@google.com>
References: <20170311022153.139362-1-mka@chromium.org>
 <1715023.AuHs9buZxh@phil> <20170313172222.GA50582@google.com>
Message-ID: <20170313184901.GB50582@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Mon, Mar 13, 2017 at 10:22:22AM -0700 Matthias Kaehlcke ha dit:

> El Sat, Mar 11, 2017 at 01:03:48PM +0100 Heiko Stuebner ha dit:
> 
> > Hi Matthias,
> > 
> > Am Freitag, 10. M?rz 2017, 18:21:53 CET schrieb Matthias Kaehlcke:
> > > The following warning is generated when building with clang:
> > > 
> > > drivers/soc/rockchip/pm_domains.c:726:22: error: shift count is negative
> > > [-Werror,-Wshift-count-negative] [RK3399_PD_TCPD0]       = DOMAIN_RK3399(8,
> > > 8, -1, false),
> > >                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/soc/rockchip/pm_domains.c:101:2: note: expanded from macro
> > > 'DOMAIN_RK3399' DOMAIN(pwr, status, req, req, req, wakeup)
> > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/soc/rockchip/pm_domains.c:88:27: note: expanded from macro 'DOMAIN'
> > >         .req_mask = (req >= 0) ? BIT(req) : 0,          \
> > >                                  ^~~~~~~~
> > > include/linux/bitops.h:6:24: note: expanded from macro 'BIT'
> > > 
> > > The BIT macro is evaluated with the negative value -1, even though the
> > > resulting value would not be assigned. To fix this we only pass values
> > > between 0 and 63 to BIT(). Unfortunately this means that we lose the
> > > benefit of the compiler checking for out of bounds errors.
> > 
> > I tend to disagree here. This looks more like a case of "fix your compiler".
> > 
> > That conditional seems perfectly valid as the BIT(req) will never be reached 
> > if req < 0 - your clang simply doesn't recognize the pattern somehow, while 
> > for example gcc does.
> 
> My interpretation is that with clang the '(req >= 0) ?' condition is
> not evaluated by the preprocessor, but only by the compiler. This seems to
> be different with gcc.
> 
> > Catering to specific whims of specific compilers feels somehow wrong, as what 
> > will happen if some imaginary third compiler requires another different hack 
> > to be satisfied?
> 
> I'll check with the clang developers if clang can be changed to behave
> like gcc in this aspect.

FYI:

"We currently don't construct control-flow graphs (CFGs) when
processing initializer expressions in a global context.  CFGs have
been used for doing a variety of flow-based warnings in functions, but
at this point they haven't been used for global initializer
expressions."

https://bugs.llvm.org//show_bug.cgi?id=10030

m.
