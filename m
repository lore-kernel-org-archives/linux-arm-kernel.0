From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 23 Oct 2011 16:43:10 +0400
Subject: [PATCH] DaVinci: only poll EPCPR on DM644x and DM355
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930328B2DF68@dbde02.ent.ti.com>
References: <201109151829.49256.sshtylyov@ru.mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930328B2DF68@dbde02.ent.ti.com>
Message-ID: <4EA40BDE.40606@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-10-2011 15:10, Nori, Sekhar wrote:

>> EPCPR register and PDCTL.EPCGOOD bit exist only on DaVinci DM644x and DM35x,
>> so do not try to poll EPCPR and set PDCTL.EPCGOOD on the other SoCs -- it would
>> lead to lock up if some power domain hasn't been powered up by this time (which
>> hasn't happened yet on any board, it seems).

>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>

> Firstly, sorry about feedback this late. I was involved in
> the bring-up of a new TI SoC which took much more of my
> time than I anticipated.

> So, I looked at power domain support for each of the 6
> DaVinci SoCs we support (don't have the specifications

    But we support more than 6 SoCs... :-)

> for tnetv107x; and code does not have evidence of a separate
> DSP power domain).

> It looks like none of the SoCs except DM6446 actually support
> powering down the DSP power domain.

> DM6467, DM355, DM365 all have a single "Always ON" power
> domain. DM355 specification actually talks about EPCPR
> and EPCGOOD but that's probably due to copy paste from
> DM644x specification than anything else.

> OMAP-L137 and OMAP-L138 have additional power domains for DSP
> and Shared RAM, but do not support powering them down.

    I haven't found such words in either OMAP-L137 or OMAP-L138 datasheets.
What they say is:

<<
- On PSC0 PD1/PD_DSP Domain: Controls the sleep state for DSP L1 and L2 Memories
- On PSC1 PD1/PD_SHRAM Domain: Controls the sleep state for the 128K Shared RAM
 >>

    Although "OMAP-L137 Application Processor System Reference Guide" indeed 
said that powering off domain 1 is not supported.
    Actually, I was able to power down DSP/shared RAM domains on DA830 (at 
least the state transition completed); although the domains were on, at least 
after U-Boot. That's how I checked that the code powering up these domains 
actually locks up on this SoC.

> So, looks like the only SoC where PDSTAT might indicate a powered
> down domain is DM644x and existing code to looks alright for
> that SoC.

> At this time, it would be better to leave the code as-is and
> revisit it if/when a new SoC with programmable power domain
> support comes along.

    At least on DA830 power domains appear to be programmable. So I'd still 
like the patch to be applied (I could drop DM355 check though).

> Thanks,
> Sekhar

WBR, Sergei
