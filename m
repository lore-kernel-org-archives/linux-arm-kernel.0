From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Fri, 24 Apr 2015 17:53:31 +0300
Subject: [PATCH 00/13] Enable CoreSight for the Ux500
In-Reply-To: <1429261140-13910-1-git-send-email-linus.walleij@linaro.org>
References: <1429261140-13910-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1429887211.5211.4.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 2015-04-17 at 10:58 +0200, Linus Walleij wrote:
> This patch series enables the CoreSight blocks for the Ux500.
> 
> To do so I ran into a few obstacles, all resolved in this
> series:
> 
> - The Ux500 have two distinct clocks clocking the CS blocks,
>   APETRACECLK clocking the AHB interconnect, what is usually
>   referred to as "apb_pclk" in the AMBA primecell abstraction
>   layer, and another clock called APEATCLK which is connected
>   to the actual ATCLK on the CS blocks. So I have to add
>   handling for this second clock as only the PCLK is handled
>   today.
> 
> - Doing so I need to use runtime PM, and I discovered that
>   the current CS drivers go in and grab the PCLK from the
>   AMBA primecell abstraction which is wrong: this shall be
>   handled using runtime PM callbacks, see e.g.
>   drivers/mmc/host/mmci.c. So I made a patch series fixing
>   this. This also fixes the problem that the PCLK is left
>   on since none of the drivers call pm_runtime_put() so
>   the AMBA core can disable the PCLK, instead they are
>   poking around with the PCLK themselves which is wrong.

Probably stupid question, but.. How this is
supposed to work if CONFIG_PM is not enabled? 

Regards,
Ivan
