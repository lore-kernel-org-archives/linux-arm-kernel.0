From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 12:42:48 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <20150430094134.GD3488@pd.tnic>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <7128860.xHITr0VFap@wuerfel> <20150430094134.GD3488@pd.tnic>
Message-ID: <10227049.9i19zDi2y3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 April 2015 11:41:34 Borislav Petkov wrote:
> But if those three vendors went and created an EDAC module each for
> their system, it would be a lot of repeated copy'pasting and bloat.
> 
> Now, the other dimension doesn't look better either:
> 
> xgene_edac_mc
> xgene_edac_mc-v2
> xgene_edac_l3
> xgene_edac-l2
> ...
> 
> Also, in both cases, if any of those drivers need to talk to each other
> or know of one another in any way, the situation becomes really funny as
> they need to create something ad-hoc each time.
> 

I've looked at the driver in a little more detail now, and found that
it is a weird conglomerate at the moment. Basically you have four
drivers in one file here, appended to one another, but not sharing
any common functions except the module_init() that registers the four
drivers. This is what Rob was referring to when he suggested splitting
it up into four files, and these would in total be smaller than the
common file (by being able to use module_platform_driver()).

However, there is another dimension to this, which supports your point
about making it one driver for the platform: The split into four drivers
is completely artificial, because all four use the same IRQs and
implement four separate interrupt handlers for it (using IRQF_SHARED),
each handling only the events they are interested in. Similarly, they
all access the same register set ("pcperror"), aside from having their
own separate registers, and they use the "syscon" framework to get to
the registers.  This seems to be an inferior design, as the pcperror
stuff apparently is the real EDAC block on the system and that should
have a device driver for itself, with proper interfaces. syscon in
contrast is designed for the case where you have a badly designed
IP block that has lots of registers for functions all over the place
for which no clear abstraction is possible.

There is also the "efuse" that is listed as "syscon" here, but should
really use a separate framework that has been under discussion for a
while.

	Arnd
