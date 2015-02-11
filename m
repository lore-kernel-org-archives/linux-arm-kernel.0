From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 11 Feb 2015 15:26:31 -0800
Subject: Delays, clocks, timers, hrtimers, etc
In-Reply-To: <54DBD095.3040800@free.fr>
References: <54D52F84.9050600@free.fr>
 <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch>
 <54D576B1.4000001@free.fr> <54D903F6.3050608@codeaurora.org>
 <54D93556.9050008@free.fr> <54D93FFA.3090506@codeaurora.org>
 <54D947B4.4080401@free.fr> <54DB94B0.8020000@free.fr>
 <20150211184515.GB11190@codeaurora.org> <54DBD095.3040800@free.fr>
Message-ID: <20150211232631.GE11190@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11, Mason wrote:
> 
> Looking at the difference between OF and !OF registration functions
> in smp_twd.c
> 
> !OF
>   if (twd_base || twd_evt) return -EBUSY;
>   assign twd_ppi and twd_base
>   twd_local_timer_common_register(NULL)
> 
> OF
>   if (!is_smp() || !setup_max_cpus) return; // TO BE DELETED
>   assign twd_ppi and twd_base
>   twd_local_timer_common_register(np)
> 
> I suppose OF guarantees that the init code is called only once?

It's called as many times as there's a match with the
corresponding CLOCKSOURCE_OF_DECLARE. In practice that's once.

> (Hence the !OF guard code would be unnecessary.)
> 

The other difference is that OF based registration needs to use
OF functions for irqs and ioremap whereas the non-OF code relies
on the irqs being provided before hand and the ioremap done
without OF functions.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
