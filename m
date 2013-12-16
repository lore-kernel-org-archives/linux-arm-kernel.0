From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Mon, 16 Dec 2013 22:54:21 +0100
Subject: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
In-Reply-To: <52AF68DB.7090105@elopez.com.ar>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
 <20131215045116.23538.4@quantum> <52AF68DB.7090105@elopez.com.ar>
Message-ID: <2899559.jbTzDM2qtE@dizzy-6.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> that takes the MMC clock (and only the MMC clock) and does the setup
> (it's basically configuring two values, "sample" and "output", into the
> clock register). I really don't know what does this do/why is it
> required/when is it used; I'm cc'ing Hans and David who can hopefully
> explain that part.
Since the read/write operations have to happen asynchronously and in a manner
so that the data provided by the SD-Card can be fetched on time, a specific
clock phase shift is required as you can see in the linked picture[1].
That's what the function is doing: It accesses the special registers of the
MMC clock device and configures this phase offset.

> I also saw a similar requirement from the gmac people (on cc too), who
> needed to set the phy type (or something like that) on one of the clock
> registers; so I'm thinking maybe a generic "tune something" approach
> that lets users configure some clock-dependent, arbitrary aspect of the
> clock is the way forward. Otherwise, we're going to end up bloating the
> clock framework with a lot of callback pointers that are going to be
> used in one or two clocks out of potentially hundreds on the whole system.
It totally makes sense, since GMAC will be doing asynchrous
operations as well.

-David

[1] http://www.chipestimate.com/techtalk/images/11022010_fig2_3.JPG
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/b7515f05/attachment.sig>
