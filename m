From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Oct 2011 10:42:03 +0100
Subject: [PATCH] mmc: mmci: Improve runtime PM support
In-Reply-To: <4EA53181.2050700@stericsson.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<4EA51C4A.7040802@stericsson.com>
	<20111024090432.GA9893@n2100.arm.linux.org.uk>
	<4EA53181.2050700@stericsson.com>
Message-ID: <20111024094203.GI9893@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 11:36:01AM +0200, Ulf Hansson wrote:
> Russell King - ARM Linux wrote:
>> I repeat: if you cut power to the card, you have to re-initialize it.
>> Re-initialization takes quite a bit of time to re-detect and setup
>> the card.  You'd also need to re-configure things like the transfer
>> mode and so forth.
>
> Right now host->vcc (vmmc) regulator is controlling the power to card.  
> Not the MCIPWR register!

Maybe for you, but that's not the case on all platforms.

You *really* need to get out of the idea that just because your
implementation works one way that everything works that way.  You're
working on a cross-SoC cross-platform driver, and you need to take
account of how other platforms work.

In that case, there *are* platforms which the MCIPWR register does
indeed control power to the card - and setting this to zero _will_
power down the card.

> I would be very surprised if any hardware has this kind of setup, that  
> the PL180 itself controls a regulator.

ARM dev boards all use the MCIPWR bits to control an external power
switch - there's no adjustment of the voltage except via soldered
links on the board.
