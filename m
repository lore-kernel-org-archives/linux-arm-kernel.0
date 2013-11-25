From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 25 Nov 2013 21:28:08 +0100
Subject: [PATCH 11/31] dma: add channel request API that supports
 deferred probe
In-Reply-To: <52938F75.7020108@wwwdotorg.org>
References: <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
 <528E4F55.9070204@wwwdotorg.org>
 <CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>
 <528F95A9.2050305@wwwdotorg.org>
 <CAPcyv4iXmBmcsHDc7yjxxbH7sO8m1nVoEO6PUibuDeb1Wtge+g@mail.gmail.com>
 <528F9DF9.6080706@wwwdotorg.org>
 <20131123003442.GH16735@n2100.arm.linux.org.uk>
 <5293883A.8050808@wwwdotorg.org>
 <20131125175330.GQ16735@n2100.arm.linux.org.uk>
 <52938F75.7020108@wwwdotorg.org>
Message-ID: <20131125202808.GN2760@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 10:57 -0700, Stephen Warren wrote:
> 
> As Dan pointed out, there are many drivers where DMA is optional, so
> there's a lot of this sprinkled through the body of the driver:
> 
> if (chan) ...
> if (!chan) ...
> 
> If we don't convert IS_ERR() values to NULL like I showed above, then
> all those tests would need to be converted to something else. Can we
> please avoid that?

Recently I had a similar situation with clocks.  It turned out to
be cumbersome to call allocation routines to assign the result
into state tracking variables, and to adjust the pointer to
become NULL in hindsight upon failure.  And I received feedback
that this feels dirty and somehow wrong.

What I did instead was to assign the allocation/lookup results to
local variables, then test them, and only assign to state
tracking variables when they are not error pointers (or expected
or acceptable errors which should go silently).

The shutdown logic then only had to check for the state tracking
variables against NULL, and release what was allocated as these
never could be errors.  Other references during the driver's
lifetime would be similar.

See 2771399a "fs_enet: cleanup clock API use" or b3bfce2bc "i2c:
mpc: cleanup clock API use" for an example.

Does this help in your case?  The "normalization" would be
concentrated in the acquisition spot, all error situations are
handled appropriately, and all other references in subsequent
code paths remain simple, and identical if there already are any.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
