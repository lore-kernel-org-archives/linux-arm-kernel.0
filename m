From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jan 2014 21:50:35 +0100
Subject: [PATCH v2 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
In-Reply-To: <52CBFE57.5020409@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <201401071003.31309.arnd@arndb.de> <52CBFE57.5020409@free-electrons.com>
Message-ID: <201401072150.36223.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014, Gregory CLEMENT wrote:
> On 07/01/2014 10:03, Arnd Bergmann wrote:
> > On Monday 06 January 2014, Gregory CLEMENT wrote:
> > My main concern is that this patch is adding platform code that we'd
> > otherwise have to carry in the kernel indefinitely. I agree that
> > it's best if we can probe stuff automatically, but that doesn't normally
> > mean looking at an unrelated piece of information. If the i2c controller
> > registers themselves tell us whether this device is broken or not,
> > we should use that information. Looking at a global SoC version register
> > however is more like checking a board ID in the pre-DT days where the
> > board number is the only information we have and everything is
> > derived from that.
> 
> Well the way the hardware is designed is exactly like this: between
> two revision of a SoC you can have slightly differences between various
> IP and most of the time this IP don't have a specific register for it.
> Moreover from my experience a change done in a IP of a given revision
> of a SoC will be for this revision and not necessary reported in future
> generation of a SoC. Most of the time the IP are not really under a VCS.
> That means that the SoC ID is the only reliable information to know
> the version of most of the IP inside this SoC.

Right. This is not exactly what I'd call "discoverable" though:
ideally we would have a way to ask the hardware for the availability
of specific features, but that clearly doesn't work here, which
leaves the default way to handle it by using DT properties to describe
it in software. In case of the AX3-4 board, that would unfortunately
imply that we would either need two separate dtb files or fall back
to the workaround for all of them. Neither approach seems particularly
user-friendly, so some form of autodetection seems appropriate.

> > Another idea: Could we have a quirk in the mvebu platform code for
> > the AX3-4 to check the SoC version and then change the property for
> > the i2c controller based on whether we expect it to work or not?
> > This way, we wouldn't even need an interface between the platform
> > code and the driver code.
> 
> I can try this last approach: using the device tree to pass platform
> parameter from the arch part to the driver.

Ok, thanks!

	Arnd
