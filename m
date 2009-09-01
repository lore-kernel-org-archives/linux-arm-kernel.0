From: psanchez@fosstel.com (Pedro I. Sanchez)
Date: Tue, 01 Sep 2009 18:18:10 -0400
Subject: AT91SAM9260: PLLA/B Programming
Message-ID: <20090901181810.lelh5pmlnkkc0sko@mail.colcan.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

I'm starting a new thread about programming the PLLA/B clocks.

My need to do this comes from the fact that these clocks can be used  
as input to the programmable clocks which are the ones I'm trying to  
use right now. Unfortunately the clock rates that I can get from the  
programmable clocks using the default PLLA/B clock rates are no good  
for me. I need to program a PLL with the right rate to use it as input  
to the programmable clocks in order to obtain the desired clocks on  
pin PC1.

I am writing directly to the PLLBR register using this sample code  
(there doesn't seem to be an API in clock.c to do it):


at91_sys_write(AT91_CKGR_PLLBR, 0x0063bf1b);
do {
     cpu_relax();
} while ((at91_sys_read(AT91_PMC_SR) & AT91_PMC_LOCKB) != AT91_PMC_LOCKB);
pr_info("PMC_SR %08x, PLLR %08x\n",
         at91_sys_read(AT91_PMC_SR),
         at91_sys_read(css));


The print out tells me that AT91_CKGR_PLLB is properly written and  
that it is locked.

I then setup the PMC_PCKR directly using this sample code:

pckr = at91_sys_read(AT91_PMC_PCKR(0));
pckr &= AT91_PMC_CSS_PLLB;
pckr |= 2 << 2;
at91_sys_write(AT91_PMC_PCKR(0), pckr);

If I source PCM_PCKR(0) from a different clock, i.e. from  
AT91_PMC_CSS_SLOW or AT91_PMC_CSS_MAIN, or if I modify the divider,  
i.e. pckr |= 4 << 2;, the clock rates change accordingly.

But no matter what I write to the PLLB I always get the same set of  
clocks on PC1, as if PLLB hadn't changed@all.

Any ideas?

-- 
Pedro
