From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 3 Jul 2018 05:01:27 +0200
Subject: [RFC net-next 15/15] net: lora: Add Semtech SX1301
In-Reply-To: <BY1PR02MB11148FFC047AE7509DD811E0E7430@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <BY1PR02MB11148FFC047AE7509DD811E0E7430@BY1PR02MB1114.namprd02.prod.outlook.com>
Message-ID: <c68e5336-1647-e0e4-0a1d-3efdcfb4fe9c@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Am 02.07.2018 um 13:51 schrieb Ben Whitten:
> Excellent work on doing this I have also been working on and off
> this personally for some time.

Thanks. Colliding work is always unfortunate, I can relate...

> Have a look at my repository [1] for sx1301 and sx1257 drivers,
> I use regmaps capability of switching pages which should simplify
> your driver considerably, I also have a full register map and bit field.

Please note that my lora-next branch already has bug fixes and cleanups
over this patch. The probe error handling was broken, and I implemented
wrappers for paged reads and writes as well as burst modes, plus the
firmware loading.

https://github.com/afaerber/linux/commits/lora-next

I took a quick look at your sx1257 and noticed you licensed it as GPLv2.
Is there any particular reason for that? Since I wrote my driver without
copying from GPLv2 code, I prefer the less restrictive GPLv2+.

So far a work day has passed with no maintainer objecting to or
commenting on the underlying PF_LORA network layer design. Meanwhile
there's already three of us with code and more people have inquired
about testing and contributing, so I'm thinking about setting up a
staging tree on kernel.org to collaborate on...

Would you be willing to contribute your regmap ideas to my driver as a
patch to squash? Needs a Signed-off-by of course, which your GitHub
commits are lacking, so I can't merge them on my own.

> I have also been trying to use the clk framework to capture the various
> routing that the cards have.

I thought about clk too, but won't that cause name conflicts when
probing multiple concentrators? Would be nice to use that for
configuring the SX1257 clock output instead of my current hack.

Another thought I haven't investigated yet is whether we could use
remoteproc for ARB and AGC. I would at least prefer to have the firmware
as a binary loaded via the usual request_firmware(), not as byte array.
But then again the AGC gets firmware loaded twice, so maybe too complex
for remoteproc.

BTW do you have any insights on what MCU is in there? Would be nice to
understand in form of source code what the firmware is doing, to avoid
the hard dependency on a specific firmware version (imagine user
updating kernel-firmware - containing versions X,Y,Z - and kernel and
booting two different kernel versions, the older one stops working).

https://www.thethingsnetwork.org/forum/t/secret-price-of-a-lora-gateway/5730/74

Regards,
Andreas

> I will dig into this series this evening.
> 
> [1] https://github.com/BWhitten/linux-stable/tree/971aadc8fdfe842020d912449bdd71b33d576fe3/drivers/net/lora
[...]
>> diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
>> new file mode 100644
>> index 000000000000..5c936c1116d1
>> --- /dev/null
>> +++ b/drivers/net/lora/sx1301.c
>> @@ -0,0 +1,446 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
[snip]

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
