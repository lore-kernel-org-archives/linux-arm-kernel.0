From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Aug 2013 19:23:12 +0200
Subject: [PATCH RFC v2 11/16] ARM: socfpga: remove call to of_clk_init
In-Reply-To: <1377790696.26261.3.camel@linux-builds1>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-12-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377790696.26261.3.camel@linux-builds1>
Message-ID: <201308291923.13151.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 August 2013, Dinh Nguyen wrote:
> On Tue, 2013-08-27 at 23:28 +0200, Sebastian Hesselbarth wrote:

> > @@ -107,7 +106,6 @@ static void __init socfpga_cyclone5_init(void)
> >  {
> >  	l2x0_of_init(0, ~0UL);
> >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > -	of_clk_init(NULL);
> >  	socfpga_init_clocks();
> >  }
> >  
> 
> Acked-by: Dinh Nguyen <dinguyen@altera.com>

I saw that your socfpga_init_clocks() function only has these contents:

void __init socfpga_init_clocks(void)
{
        struct clk *clk;
        int ret;

        clk = clk_register_fixed_factor(NULL, "smp_twd", "mpuclk", 0, 1, 4);
        ret = clk_register_clkdev(clk, NULL, "smp_twd");
        if (ret)
                pr_err("smp_twd alias not registered\n");
}


I think that can easily be expressed with DT syntax now (correct me if I'm wrong), so
you should be able to kill this off as well. Once somebody gets around to automate
the l2x0 setup, the entire socfpga_cyclone5_init() function can go away too.

	Arnd
