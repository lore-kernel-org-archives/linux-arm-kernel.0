From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 22:26:01 +0100
Subject: [PATCH 1/7] clk: mmp: stop using platform headers
In-Reply-To: <20151125192114.GB11298@codeaurora.org>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
 <1448465875-435039-2-git-send-email-arnd@arndb.de>
 <20151125192114.GB11298@codeaurora.org>
Message-ID: <3508030.Q62gfHvXvx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 11:21:14 Stephen Boyd wrote:
> On 11/25, Arnd Bergmann wrote:
> > diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
> > index 09d2832fbd78..38931dbd1eff 100644
> > --- a/drivers/clk/mmp/clk-mmp2.c
> > +++ b/drivers/clk/mmp/clk-mmp2.c
> > @@ -9,6 +9,7 @@
> >   * warranty of any kind, whether express or implied.
> >   */
> >  
> > +#include <linux/clk.h>
> 
> Why are we adding this include? I don't see any clk consumer API
> usage being added.

Without these #includes, I get a build error:

drivers/clk/mmp/clk-mmp2.c: In function 'mmp2_clk_init':
drivers/clk/mmp/clk-mmp2.c:192:2: error: implicit declaration of function 'clk_set_rate' [-Werror=implicit-function-declaration]
  clk_set_rate(clk, 14745600);
  ^
drivers/clk/mmp/clk-mmp2.c:251:2: error: implicit declaration of function 'clk_set_parent' [-Werror=implicit-function-declaration]
  clk_set_parent(clk, vctcxo);
  ^
drivers/clk/mmp/clk-pxa168.c: In function 'pxa168_clk_init':
drivers/clk/mmp/clk-pxa168.c:161:2: error: implicit declaration of function 'clk_set_rate' [-Werror=implicit-function-declaration]
  clk_set_rate(uart_pll, 14745600);
  ^
drivers/clk/mmp/clk-pxa168.c:204:2: error: implicit declaration of function 'clk_set_parent' [-Werror=implicit-function-declaration]
  clk_set_parent(clk, uart_pll);
  ^
drivers/clk/mmp/clk-pxa910.c: In function 'pxa910_clk_init':
drivers/clk/mmp/clk-pxa910.c:166:2: error: implicit declaration of function 'clk_set_rate' [-Werror=implicit-function-declaration]
  clk_set_rate(uart_pll, 14745600);
  ^
drivers/clk/mmp/clk-pxa910.c:209:2: error: implicit declaration of function 'clk_set_parent' [-Werror=implicit-function-declaration]
  clk_set_parent(clk, uart_pll);
  ^

Is there anything I need to change here?

	Arnd
