From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Nov 2011 09:49:47 +0800
Subject: [PATCH 0/3] make stmp-style devices mach-independent
In-Reply-To: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20111117014946.GE14656@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 11:47:36AM +0100, Wolfram Sang wrote:
> It seems I haven't been following the lists too closely lately, so I might have
> missed similar patches. Yet, I noticed some patches dealing with drivers using
> mxs-specific features, so they need to include mach-specific files which is
> troublesome. I started to address the problem as well some time ago, so I push
> out the patches now as RFC to enrich the discussion. The patches are rebased to
> linux 3.2-rc2 and are boot tested.
> 
> The basics: mach-mxs uses ip-cores which follow a register layout I have
> first seen on STMP SoCs. That means, every register has four incarnations:
>  - one u32 to store a value
>  - a SET register where every 1-bit sets the corresponding bit,
>    others are unaffected
>  - similar with a CLR register
>  - and a TGL (toggle) register
> 
> Also, the 2 MSBs in register 0 are always the same and can be used to reset the
> block.
> 
> All this is strictly speaking not mach-specific (but ip-core specific) and,
> thus, doesn't need to be in mach-mxs/include. As I have been told, mx50 and
> mx6(?) might also use IP cores following the STMP-style; so I wondered if it
> can't be exported like the following patch series does:
> 
> Introduce a stmp-style device, put the code around that in a public place
> (currently drivers/base/; dunno if that is the best place, though), and let
> drivers for stmp-style devices select that code.
> 
> Voila, mach dependency gone, reusable code introduced. Note that I didn't
> remove the duplicated code from mach-mxs yet, first all drivers have to be
> converted.
> 
> Right thing to do?

I think it's the right thing to do.  But I do not like the name as
stmp-style device.  Why not just mxs-style device?  Name mxs is born
to replace stmp, and keeping using two names may confuse people.
Also sticking to mxs may save the diffs like the one below.

-       mxs_reset_block(i2c->regs);
+       stmp_reset_block(i2c->regs);

Regards,
Shawn

> If so, I'll repost properly to the right lists. Fishing for
> feedback right now :)
> 
