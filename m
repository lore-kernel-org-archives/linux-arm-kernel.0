From: nsekhar@ti.com (Nori, Sekhar)
Date: Sun, 23 Oct 2011 16:40:51 +0530
Subject: [PATCH] DaVinci: only poll EPCPR on DM644x and DM355
In-Reply-To: <201109151829.49256.sshtylyov@ru.mvista.com>
References: <201109151829.49256.sshtylyov@ru.mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930328B2DF68@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Sep 15, 2011 at 19:59:48, Sergei Shtylyov wrote:
> EPCPR register and PDCTL.EPCGOOD bit exist only on DaVinci DM644x and DM35x,
> so do not try to poll EPCPR and set PDCTL.EPCGOOD on the other SoCs -- it would
> lead to lock up if some power domain hasn't been powered up by this time (which
> hasn't happened yet on any board, it seems).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Firstly, sorry about feedback this late. I was involved in
the bring-up of a new TI SoC which took much more of my
time than I anticipated.

So, I looked at power domain support for each of the 6
DaVinci SoCs we support (don't have the specifications
for tnetv107x; and code does not have evidence of a separate
DSP power domain).

It looks like none of the SoCs except DM6446 actually support
powering down the DSP power domain.

DM6467, DM355, DM365 all have a single "Always ON" power
domain. DM355 specification actually talks about EPCPR
and EPCGOOD but that's probably due to copy paste from
DM644x specification than anything else.

OMAP-L137 and OMAP-L138 have additional power domains for DSP
and Shared RAM, but do not support powering them down.

So, looks like the only SoC where PDSTAT might indicate a powered
down domain is DM644x and existing code to looks alright for
that SoC.

At this time, it would be better to leave the code as-is and
revisit it if/when a new SoC with programmable power domain
support comes along.

Thanks,
Sekhar
