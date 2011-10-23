From: nsekhar@ti.com (Nori, Sekhar)
Date: Sun, 23 Oct 2011 21:48:15 +0530
Subject: [PATCH] DaVinci: only poll EPCPR on DM644x and DM355
In-Reply-To: <4EA40BDE.40606@mvista.com>
References: <201109151829.49256.sshtylyov@ru.mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930328B2DF68@dbde02.ent.ti.com>
	<4EA40BDE.40606@mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930328B2DF8C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 18:13:10, Sergei Shtylyov wrote:
> On 23-10-2011 15:10, Nori, Sekhar wrote:

[...]

> > OMAP-L137 and OMAP-L138 have additional power domains for DSP
> > and Shared RAM, but do not support powering them down.
> 
>     I haven't found such words in either OMAP-L137 or OMAP-L138 datasheets.
> What they say is:
> 
> <<
> - On PSC0 PD1/PD_DSP Domain: Controls the sleep state for DSP L1 and L2 Memories
> - On PSC1 PD1/PD_SHRAM Domain: Controls the sleep state for the 128K Shared RAM
>  >>
> 
>     Although "OMAP-L137 Application Processor System Reference Guide" indeed 
> said that powering off domain 1 is not supported.

Right. There is a statement put in for shared ram as well.

"
Currently powering down the RAMs via the pseudo/RAM power domain is not 
supported; therefore, these domains and the RAM should be left in their 
default power on state.
"

BTW, it looks like a separate "System Reference Guide" doesn't exist
anymore and all the OMAP-L1x user guides have been consolidated to a
single "Technical Reference Manual".

>     Actually, I was able to power down DSP/shared RAM domains on DA830 (at 
> least the state transition completed); although the domains were on, at least 
> after U-Boot. That's how I checked that the code powering up these domains 
> actually locks up on this SoC.

Okay. Surely there must have been some corner case issues found
which probably led the chip design team to make this feature
unsupported.

> > So, looks like the only SoC where PDSTAT might indicate a powered
> > down domain is DM644x and existing code to looks alright for
> > that SoC.
> 
> > At this time, it would be better to leave the code as-is and
> > revisit it if/when a new SoC with programmable power domain
> > support comes along.
> 
>     At least on DA830 power domains appear to be programmable. So I'd still 
> like the patch to be applied (I could drop DM355 check though).

The problem would be that power domain state transition procedure isn't
documented for any SoC other than DM644x. So, we can never be sure
that just avoiding EPCR poll is sufficient for DA830. Software attempting
this would be operating out of spec.

So, how about allowing a power domain transition for DM644x and bailing
out with a warning if a power domain on any other SoC is found to be off?

This way users attempting this will be warned and fix their boot loader.

Thanks,
Sekhar
