From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 13:32:22 -0800
Subject: [PATCH 1/7] clk: mmp: stop using platform headers
In-Reply-To: <3508030.Q62gfHvXvx@wuerfel>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
 <1448465875-435039-2-git-send-email-arnd@arndb.de>
 <20151125192114.GB11298@codeaurora.org>
 <3508030.Q62gfHvXvx@wuerfel>
Message-ID: <20151125213222.GF11298@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25, Arnd Bergmann wrote:
> On Wednesday 25 November 2015 11:21:14 Stephen Boyd wrote:
> > On 11/25, Arnd Bergmann wrote:
> > > diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
> > > index 09d2832fbd78..38931dbd1eff 100644
> > > --- a/drivers/clk/mmp/clk-mmp2.c
> > > +++ b/drivers/clk/mmp/clk-mmp2.c
> > > @@ -9,6 +9,7 @@
> > >   * warranty of any kind, whether express or implied.
> > >   */
> > >  
> > > +#include <linux/clk.h>
> > 
> > Why are we adding this include? I don't see any clk consumer API
> > usage being added.
> 
> drivers/clk/mmp/clk-pxa910.c: In function 'pxa910_clk_init':
> drivers/clk/mmp/clk-pxa910.c:166:2: error: implicit declaration of function 'clk_set_rate' [-Werror=implicit-function-declaration]
>   clk_set_rate(uart_pll, 14745600);
>   ^
> drivers/clk/mmp/clk-pxa910.c:209:2: error: implicit declaration of function 'clk_set_parent' [-Werror=implicit-function-declaration]
>   clk_set_parent(clk, uart_pll);
>   ^
> 
> Is there anything I need to change here?
> 

Hmph. I seems this broke when we removed the clk.h include from
clk-provider.h, but nobody has noticed for months. Can you make a
different commit to add the header? Otherwise we're sneaking in
that include to get this file to compile again.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
