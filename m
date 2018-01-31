From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 31 Jan 2018 15:27:02 +0000
Subject: [RFC v3 11/25] watchdog: renesas_wdt: Add R-Car Gen2 support
In-Reply-To: <007dd1e3-70fd-69ad-fd02-4719e958b41c@roeck-us.net>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517343778-27902-12-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180130220504.GA16709@roeck-us.net>
 <TY1PR06MB0895ECB2936323F9D281C1EFC0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <CAMuHMdViQgCjVFbs0kkBObAAoFTzvz8yPFUHPWHrtYzkbnYm_g@mail.gmail.com>
 <007dd1e3-70fd-69ad-fd02-4719e958b41c@roeck-us.net>
Message-ID: <TY1PR06MB0895EDD2AEE12D4CA53994C9C0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Guenter, Geert

thank you for your feedback!

> >
> > IIRC, the reason we don't have the restart callback on R-Car Gen3 is the
> > arm64 maintainers insisting on using PSCI, and vetoing other means,
> > to restart the system.
> >
>
> You could just give it lower priority than PSCI.

I am looking at the implementation of machine_restart() for both arm and arm64,
and it looks like that if arm_pm_restart gets set, then arm_pm_restart has the
highest priority of all. If arm_pm_restart is not set, then the kernel will go through
the restart_handler_list, and the registered priority for the restart method will matter
at that point.
My understanding is that Gen3 does set arm_pm_restart due to
drivers/firmware/psci.c, and therefore other restart handlers shouldn't matter too
much, but I am not familiar with Gen3 at all.
Shall I just set the restart priority to 128 and leave the callback in place for both Gen2
and Gen3?

Thanks,
Fab

>
> > Which leaves us with a few boards where we have to use the watchdog, and
> > wait until the timeout triggers...
> >
>
> Which means the veto is counter-productive and thus meaningless.
>
> Guenter
>



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
