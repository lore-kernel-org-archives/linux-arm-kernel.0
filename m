From: Ben.Whitten@lairdtech.com (Ben Whitten)
Date: Thu, 5 Jul 2018 08:59:54 +0000
Subject: [RFC net-next 15/15] net: lora: Add Semtech SX1301
In-Reply-To: <c68e5336-1647-e0e4-0a1d-3efdcfb4fe9c@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <BY1PR02MB11148FFC047AE7509DD811E0E7430@BY1PR02MB1114.namprd02.prod.outlook.com>
 <c68e5336-1647-e0e4-0a1d-3efdcfb4fe9c@suse.de>
Message-ID: <BY1PR02MB11145A00AC66E03E61607C09E7400@BY1PR02MB1114.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
> 
> Hi Ben,
> 
> Am 02.07.2018 um 13:51 schrieb Ben Whitten:
> > Excellent work on doing this I have also been working on and off
> > this personally for some time.
> 
> Thanks. Colliding work is always unfortunate, I can relate...
> 
> > Have a look at my repository [1] for sx1301 and sx1257 drivers,
> > I use regmaps capability of switching pages which should simplify
> > your driver considerably, I also have a full register map and bit field.
> 
> Please note that my lora-next branch already has bug fixes and cleanups
> over this patch. The probe error handling was broken, and I implemented
> wrappers for paged reads and writes as well as burst modes, plus the
> firmware loading.
> 
> https://github.com/afaerber/linux/commits/lora-next
> 
> I took a quick look at your sx1257 and noticed you licensed it as GPLv2.
> Is there any particular reason for that? Since I wrote my driver without
> copying from GPLv2 code, I prefer the less restrictive GPLv2+.

As I was learning about regmap usage and how SPI devices connect to the bus I adopted the most common licence employed in these kernel files, seemed appropriate.
Ultimately I don?t want a licence choice to hamper inclusion to mainline, not a lawyer I don?t find that fun.

> 
> So far a work day has passed with no maintainer objecting to or
> commenting on the underlying PF_LORA network layer design. Meanwhile
> there's already three of us with code and more people have inquired
> about testing and contributing, so I'm thinking about setting up a
> staging tree on kernel.org to collaborate on...
> 
> Would you be willing to contribute your regmap ideas to my driver as a
> patch to squash? Needs a Signed-off-by of course, which your GitHub
> commits are lacking, so I can't merge them on my own.

I'm sure whichever way we merge it, yours to mine / mine to yours, we can work together on it.
As I already have regmap running and mostly split out SX1257 drivers to Marks suggestions avoiding the extra SPI layer it may by easier to port the various functions you have to mine and share authorship.

> > I have also been trying to use the clk framework to capture the various
> > routing that the cards have.
> 
> I thought about clk too, but won't that cause name conflicts when
> probing multiple concentrators? Would be nice to use that for
> configuring the SX1257 clock output instead of my current hack.

Potentially, it maybe that we need to augment the names of the clk with the CS of the concentrator in use.
Or maybe the radio only searches the clk's of its parent device...
I've not explored this area to far yet but there will be a solution I'm sure.

> Another thought I haven't investigated yet is whether we could use
> remoteproc for ARB and AGC. I would at least prefer to have the firmware
> as a binary loaded via the usual request_firmware(), not as byte array.
> But then again the AGC gets firmware loaded twice, so maybe too complex
> for remoteproc.
> 
> BTW do you have any insights on what MCU is in there? Would be nice to
> understand in form of source code what the firmware is doing, to avoid
> the hard dependency on a specific firmware version (imagine user
> updating kernel-firmware - containing versions X,Y,Z - and kernel and
> booting two different kernel versions, the older one stops working).

I'm afraid no insight into the internals of this chip, some good guesswork but I think a firmware blob is something we are going to have to live with for the time being.

> https://www.thethingsnetwork.org/forum/t/secret-price-of-a-lora-
> gateway/5730/74
> 
> Regards,
> Andreas
> 
> > I will dig into this series this evening.
> >
> > [1] https://github.com/BWhitten/linux-
> stable/tree/971aadc8fdfe842020d912449bdd71b33d576fe3/drivers/net/lora
> [...]
> >> diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
> >> new file mode 100644
> >> index 000000000000..5c936c1116d1
> >> --- /dev/null
> >> +++ b/drivers/net/lora/sx1301.c
> >> @@ -0,0 +1,446 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> [snip]

Ben
