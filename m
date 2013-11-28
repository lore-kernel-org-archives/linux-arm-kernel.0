From: gsi@denx.de (Gerhard Sittig)
Date: Thu, 28 Nov 2013 22:20:20 +0100
Subject: NULL clock items (was: [PATCH 11/31] dma: add channel request
 API that supports deferred probe)
In-Reply-To: <20131125205224.GT16735@n2100.arm.linux.org.uk>
References: <CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>
 <528F95A9.2050305@wwwdotorg.org>
 <CAPcyv4iXmBmcsHDc7yjxxbH7sO8m1nVoEO6PUibuDeb1Wtge+g@mail.gmail.com>
 <528F9DF9.6080706@wwwdotorg.org>
 <20131123003442.GH16735@n2100.arm.linux.org.uk>
 <5293883A.8050808@wwwdotorg.org>
 <20131125175330.GQ16735@n2100.arm.linux.org.uk>
 <52938F75.7020108@wwwdotorg.org>
 <20131125202808.GN2760@book.gsilab.sittig.org>
 <20131125205224.GT16735@n2100.arm.linux.org.uk>
Message-ID: <20131128212020.GE2982@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 20:52 +0000, Russell King - ARM Linux wrote:
> 
> [ ... 2771399a "fs_enet: cleanup clock API use" example ... ]
> [ ... NULL clocks won't get released, calls might get skipped ... ]

I agree that the NULL clock reference is not handled correctly in
that code.  Part of the issue is that NULL is both an
initialization value and a valid reference to something that was
acquired (and quite counter intuitive so).

This inability to tell the two reasons for NULL apart only
vanishes when each clock variable explicitly gets initialized or
pre-set to some ERR_PTR() value (or when the allocation and
assignment is unconditional, no code path depends on some other
condition).  I'm afraid that the source tree currently is not
there yet, and it may be quite some churn (with a lot of
potential for conflicts) to touch each driver, if it's at all
possible to identify all spots where those variables are NULL
because of
- static declarations without initializers
- static declarations with incomplete initializers
- memory allocation with "zeroes please" flags
- memset() calls
- clock acquisition code paths were not taken


Which platform or clock provider or specific clock driver exactly
is this mysterious instance which returns NULL for a valid clock?
Is this one or the very few instances easier to adjust and thus
(re-)gain certainty about correct operation with less effort and
much less risk of missing something?


> This is not very nice.  Better solution:
> 
> 	fpi->clk_per = PTR_ERR(-EINVAL);
> 	clk = devm_clk_get(&ofdev->dev, "per");
> 	if (!IS_ERR(clk)) {
> 		err = clk_prepare_enable(clk);
> 		if (err) {
> 			ret = err;
> 			goto out_free_fpi;
> 		}
> 		fpi->clk_per = clk;
> 	}
> 
> ...
> 
>         of_node_put(fpi->phy_node);
>         if (!IS_ERR(fpi->clk_per))
>                 clk_disable_unprepare(fpi->clk_per);

Assume in the above example that the fpi->clk_per assignment
would be in a conditional code path.  In that case the code is as
wrong (unpreparing a not acquired NULL reference) as leaking an
acquired NULL reference is.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
