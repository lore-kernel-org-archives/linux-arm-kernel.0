From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 May 2015 00:02:48 +0200
Subject: [GIT PULL] Broadcom SoC changes for 4.2
In-Reply-To: <555D01AD.2040705@broadcom.com>
References: <1431556453-11633-1-git-send-email-f.fainelli@gmail.com>
 <26666329.i6kznPGNxa@wuerfel> <555D01AD.2040705@broadcom.com>
Message-ID: <3733749.guFogFhQqU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 14:50:37 Florian Fainelli wrote:
> >>> - it is in include/linux/ where it clearly does not belong, as no other component
> >>>   should be including it. Even the function documentation in there mentions that
> >>>   one must hold the pmb_lock before calling it, and that is defined statically
> >>>   arch/arm/mach-bcm/bcm63xx_pmb.c, so it's impossible for other code to use.
> >>>   Just move it all into bcm63xx_pmb.c.
> >>
> >> This header will later be used by the bcm63138 reset controller, and I
> >> thought I had explained the reasoning behind that in either the commit
> >> message or cover letter, I will make sure the commit message explains it.
> > 
> > I see. I still think it's a bit rude to place this header in the top-level
> > include/linux directory though. I realize there are a lot of other headers
> > like this, but I'm trying not to add too many more.
> 
> Would a lesser evil be to create include/linux/resets/ and place this
> header file there?

I've also thought about that. It would certainly help.

> > Maybe a lesser evil would be to put the reset driver into
> > arch/arm/mach-bcm/bcm63xx_pmb.c as well?
> > 
> > How big is it? And is there anything else besides that driver which would
> > need these functions?
> 
> It is going to be (once feature complete) as big as
> arch/arm/mach-bcm/bcm63xx_pmb.c except that it will also have to inspect
> the client asking for the reset, e.g: the reset procedure for the SATA
> block is a little different than the one for the PCIe PHY, or integrated
> Ethernet switch, or USB controlers...
> 
> The way we power on a secondary CPU is code that is not shared with how
> other on-chip peripherals are powered on, hence the idea behind the
> separation.

Ok, I see. Let's start with the include/linux/resets/ approach then.

Yet another idea would be to expose the read/write interface here
as a regmap and find a way to share that. That way, you could move
a large part of bcm63xx_pmb.c and bcm63xx_pmb.h into the reset
driver and just have one interface to get the regmap, like we do
for syscon devices. It would still need a single function declaration
though.

	Arnd
