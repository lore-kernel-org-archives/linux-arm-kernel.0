From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 16 Sep 2010 08:08:41 -0700
Subject: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
In-Reply-To: <AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
	(Linus Walleij's message of "Thu, 16 Sep 2010 14:19:59 +0200")
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
Message-ID: <87sk19eneu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Linus Walleij <linus.walleij@stericsson.com> writes:

> 2010/9/15 Kevin Hilman <khilman@deeprootsystems.com>:
>
>> OMAP SOCs have a standard set of tuples consisting of frequency and
>> voltage pairs that the device will support per voltage domain. ?These
>> are called Operating Performance Points or OPPs.
>> (...)
>> This introduces a common handling OPP mechanism accross all OMAPs.
>> As a start this is used for OMAP3.
>
> OPPs are a generic concept, it's in silicon construction textbooks and all.
> Should this code not be made generic instead? You wouldn't make
> regulators or even DMA platform-specific these days, so why should
> OPPs be?

You're right.

> What in this code is actually OMAP-specific

Only the users.  ;)

We currently register OPPs using an OMAP hwmod name, but we could easily
change that to use a struct device instead which would make this
much more generic (note we manage OPPs per-device, not just for the CPU)

The patch below[1] demonstrates quickly how easily we could remove all OMAP
specific stuff from opp.[ch], and move it to the OMAP-specific code that
does the opp_add()

> more than that you name
> some functions omap_*, and how hard would it be to put it under
> arch/arm/common/*.c
> arch/arm/include/asm/*.h
>
> Possible even higher up in the directory hiearchy in include/linux/opp.h
> for the header and drivers/opp/*.c, because I think SuperH and power
> are not that different in this respect.

Yeah, I guess this isn't ARM specific either, so should be at a higher
level. 

Nishanth, can take my hack below and continue this evolution?  As I
demonstrate with this hack, this won't really change anything for us.

Kevin
