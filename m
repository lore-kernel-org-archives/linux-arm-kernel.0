From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Fri, 19 Dec 2014 16:26:25 +0100
Subject: AT91 slow clock mode regression/fixes, improvement proposal
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFCB6762@penmbx01>
References: <20141218203904.GA25215@gradator.net>
 <B256D81BAE5131468A838E5D7A243641BFCB6762@penmbx01>
Message-ID: <20141219152625.GA30666@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,


On Fri, Dec 19, 2014 at 02:50:04AM +0000, Yang, Wenyou wrote:
> > 
> > Is actually jumping to wait_pllblock before enabling PLLB instead of skipping UTMI
> > PLL. Unfortunately the compiler does not warn about that.
> 
> Thanks. I will check it

Fixed in proposed patch (UPLL code removed).


> > Furthermore, it looks like MCKRDY_TIMEOUT set to 1000 is not enough, my board
> > crashes in about 1 wake up to 10 with this value and works perfectly
> > fine with 4000.
> 
> I also encountered this issue.

Fixed in proposed patch, since we don't timeout anymore.


> Moreover the Main Crystal Oscillator Startup Time seems not enough 
> too, not sure, I am confirming it.

This is OK for me, CKGR_MOR.MOSCXTST is set to 8:  (1/32768)*8*8 = 1.95 ms

I checked with a scope on XTAL of the AT91SAM9G35-CM module, 2 ms is 
about twice enough waiting time.


> > Therefore I am also proposing to remove all the timeout.
> 
> Good idea, but I still worry the deadlock without timeout. Maybe 
> increasing timeout is better.

This is just a test request patch, I am first trying without timeout to 
get some feedback. It works well for me, at least, but this isn't 
convicing myself enough :-)


> > By the way, I don't know for other AT91 boards (or without DT, or
> > something else), but the UTMI PLL suspend/resume seem unnecessary for
> > me, the USB driver is already disabling the USB PLL when suspending,
> > could you confirm ?
> Yes, I agree.

Removed.


> Remove disabling the PLLB code as well.  

Done, but my SoC don't have a PLLB, so I can't check myself, could you 
check if "AT91: PM - Suspend-to-RAM with PLL B running" does not fire on 
PLL B enabled board ?


Regards,
Sylvain
