From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Feb 2014 13:48:55 +0100
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <20140213104248.GU26684@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <201401281148.10670.arnd@arndb.de>
 <20140213104248.GU26684@n2100.arm.linux.org.uk>
Message-ID: <2874395.Ul86gYA57i@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 February 2014 10:42:48 Russell King - ARM Linux wrote:
> 
> What if we have a platform where things subtly change, like for instance,
> the wiring on the SD slot to fix a problem with UHS-1 cards, which means
> you don't have UHS-1 support for some platforms but do for others.
> 
> What if you have a platform which uses a brcm4329 chip for Wifi, but then
> later in the production run switch to using a different Wifi chipset?

As far as I can tell, the power sequencing is normally really
dependent on the device. If someone has an on-board brcm4329
that requires a specific set of clocks, resets, voltages etc
to be routed to the chip and enabled in the correct order to
allow probing, it seems unlikely that changing the wifi chipset
to something else would keep the exact same requirements.

> With this information encoded into DT, the number of DT files quickly
> increases, and then this presents its own problem - how do users get to
> know which DT file should be used for their platform when all they see
> externally is "a product of type A"?

I haven't seen a suggestion that would not encode this in DT. The
difference between Olof's original suggestion and mine is that he
proposed to put the data into the existing node of the host controller,
while my approach would be to add a node for each function with
these requirements and modify the sdio code so that we can deal
with it in the function driver. The data that would get passed
however is almost the same.

	Arnd
