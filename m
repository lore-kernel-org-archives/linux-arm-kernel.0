From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 7 Jul 2010 16:04:41 +0300
Subject: [PATCH] mx25: set GPT clock source to PER
In-Reply-To: <20100707102845.GW26079@pengutronix.de>
References: <20100704084343.GB19559@jasper.tkos.co.il>
	<40bc9462f125233cc9c63631a9b987ed684b6d97.1278233166.git.baruch@tkos.co.il>
	<20100705082123.GD26079@pengutronix.de>
	<20100706063511.GB28547@jasper.tkos.co.il>
	<20100706073314.GJ26079@pengutronix.de>
	<20100707080012.GE24774@jasper.tkos.co.il>
	<20100707102845.GW26079@pengutronix.de>
Message-ID: <20100707130440.GJ24774@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Jul 07, 2010 at 12:28:45PM +0200, Sascha Hauer wrote:
> On Wed, Jul 07, 2010 at 11:00:13AM +0300, Baruch Siach wrote:
> > > 
> > > Tell the timer code which clock to use with an argument to
> > > mxc_timer_init() and add the missing clocks to the clock.c file. You
> > > also have to pass this argument through from the board to
> > > mx25_clocks_init(). That's a lot of work and in the end we still do not
> > > know why some i.MX25 variants need the peripheral clock and others need
> > > the ipg clock. So what I really suggest is that you invest some
> > > research to find the source of this strangeness.
> > 
> > OK. I think I've nailed it down. The CCM MCR register was initialized 
> > differently.  
> > 
> > On the PDK I use the factory installed RedBoot bootloader. RedBoot leaves the 
> > PER CLK MUX field at its default state, that is, MCR[15:0] = 0.
> > 
> > On our target board I use a port of Barebox based on the built-in PDK support.  
> > The board_init_lowlevel routine of the PDK platform code includes the 
> > following line:
> > 
> >     writel(0x0000FEFF, IMX_CCM_BASE + MX25_CCM_MCR)
> > 
> > This makes MCR[15:0] = 0xfeff. Commenting out this line makes both boards 
> > behave the same way. The timer clock runs correctly with or without setting 
> > the V2_TCTL_CLK_PER bit.  Reverting faed406, however, breaks both boards.
> > 
> > So, I thing we should keep faed406. You may also consider applying this patch 
> > setting V2_TCTL_CLK_PER, For the reason Rob Herring has stated.
> 
> I made some tests on a custom i.MX25 board using barebox (no kernel
> started)
> 
> CCM_MCR		GPT_TCTL[8:6]	get_gpt_clk returns	result
> ----------------------------------------------------------------------
> 1. 0xfeff	1 (ipgclk)	ipgclk (66.5MHz)	works
> 2. 0x0		1 (ipgclk)	ipgclk (66.5MHz)	works
> 3. 0xfeff	2 (perclk)	perclk5 (8.87MHz)	works
> 4. 0x0		2 (perclk)	perclk5 (16MHz)		works
> 5. 0x0		1 (ipgclk)	perclk5 (16MHz)		does not work
> 
> 1 and 2 work because the MCR value only affects perclk, but not ipgclk.
> 3 and 4 work after I adjusted the per_clk5 divider so that the resulting
> clock is < ipgclk / 4. That seems to be what Martin stated.
> 5 does not work because the timer runs at ipgclk but the clock code
> returns per_clk5. This is exactly what the kernel currently does and
> it's imho wrong.
> reverting faed406 would mean switching to 1 or 2 which should both work.
> 
> We may switch to use perclk in the gpt later, but this would require
> adjusting the other i.MXs aswell. I'm not convinced this is a good idea
> though because currently we have a timer resolution of 1/66.5MHz, we
> would go to at least 1/4 of this when using perclk.
> 
> I found the following patch in our repository which I forgot to post and
> push upstream. Currenty the kernel returns wrong rates for the perclks
> when the corresponding CCM_MCR bit is cleared. I hope this patch clears
> some confusion instead of adding more...
> 
> commit 98901d5f62de56d87d3a31e46ebe9624edeac62b
> Author: Sascha Hauer <s.hauer@pengutronix.de>
> Date:   Mon Sep 14 09:01:13 2009 +0200
> 
>     mx25 clock: Peripheral parent clock is ahb, not ipg
>     
>     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
> index 7d8bca5..cb58b32 100644
> --- a/arch/arm/mach-mx25/clock.c
> +++ b/arch/arm/mach-mx25/clock.c
> @@ -99,7 +99,7 @@ static unsigned long get_rate_per(int per)
>  	if (readl(CRM_BASE + 0x64) & (1 << per))
>  		fref = get_rate_upll();
>  	else
> -		fref = get_rate_ipg(NULL);
> +		fref = get_rate_ahb(NULL);
>  
>  	return fref / (val + 1);
>  }

I tested this patch on our target board without reverting of applying any 
related patch. Boot messages appear on the console correctly, but when 
(busybox) getty starts I see garbage on the console instead of the login 
prompt.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
