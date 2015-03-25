From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 25 Mar 2015 01:32:01 +0100
Subject: at91 clocks
In-Reply-To: <55117568.6090202@microbit.se>
References: <55117568.6090202@microbit.se>
Message-ID: <20150325013201.3f01fc22@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonas,

On Tue, 24 Mar 2015 15:32:08 +0100
Jonas Andersson <jonas@microbit.se> wrote:

> Hi all,
> 
> I am working on a system with at91sam9260 soc. Trying to move from 
> kernel 3.17.4 to 3.19.2. I have problem with pck1 clock.
> 
> In my old code i use clk_get() to get pck1 and pllb, set pllb as parent 
> for pck1, set rate for pck1, enable pck1.

How do you do that (clk_set_parent + clk_set_rate) ?
Could you paste your code somewhere ?

> Extract from 
> /sys/kernel/debug/at91_clk:
> pllb       users= 1 on   96000000 Hz main
> pck1       users= 1 on   12000000 Hz pllb
> 
> In my new code i have defined the two clocks in DT:
>          clocks = <&prog1>, <&pllb>;
>          clock-names = "codec", "parent";
> Extract from  /sys/kernel/debug/clk/clk_summary:
>         mainck                             2            2 
> 18432000          0 0
>            prog1                           1            1 
> 9216000          0 0
>               pck1                         0            0 
> 9216000          0 0
>            pllbck                          0            0 0          0 0
>               usbck                        0            0 0          0 0
>                  udpck                     0            0 0          0 0
>                  uhpck                     0            0 0          0 0
> 
> I know i probably have to enable pck1 also.
> But my main problem is that I got the wrong frequency and parent of prog1.
> Why?

With the new implementation calling clk_set_rate(pck1, 120000000)
should do the job: it should choose the best parent clk and divisor.

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
