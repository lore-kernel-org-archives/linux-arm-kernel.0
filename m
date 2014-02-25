From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 17:04:54 +0100
Subject: [GIT PULL 00/21] Renesas ARM based SoC Board Updates for v3.15
In-Reply-To: <CANqRtoQj8CNn=pNP5HkVbaSSc=PbZEoOD3wGa9sXF9nXraTVeQ@mail.gmail.com>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
 <20140220082316.GE19089@quad.lixom.net>
 <CANqRtoQj8CNn=pNP5HkVbaSSc=PbZEoOD3wGa9sXF9nXraTVeQ@mail.gmail.com>
Message-ID: <201402251704.54970.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014, Magnus Damm wrote:
> On Thu, Feb 20, 2014 at 5:23 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Thu, Feb 06, 2014 at 03:17:08PM +0900, Simon Horman wrote:
> Thanks for your email. I agree that the number of board file commits
> is definitely larger than zero so some clarification is in order.
> 
> As you probably recall, we earlier agreed on not adding any new board
> files. That part is clear I believe so I will skip that.
> 
> Regarding the legacy board code, we have quite ok hardware support
> coverage as it is now, but some devices drivers are of course still
> under development. This means that in some cases integration is on
> going or has not happened yet. You may see those kind of changes as
> significant commits in the pull requests for board support.

[adding Ben Dooks, since he was complaining about this as well]

My feeling is that we should adjust the strategy for shmobile. We've
had good success with the dual strategy of keeping board support
separate for DT-enabled and ATAGS-only boards in the sense that
we did not have to coordinate updates for bindings between subsystem
and architecture git trees, which has always been source for
problems on other platforms.

However, the price for this seems to be that it's still not possible
to get a properly working system without a board file, and my feeling
is that it's taking too long to get there. In particular, we now see
new drivers getting added (I noticed VIN, which Ben mentioned before)
that start out with just platform_device support but no DT support.
This is bad, because it means DT users are always behind.

> In the Legacy Lager/Koelsch board code the following devices are
> supported as platform devices:
> 
> ETHER, SCIF, DU, I2C, SATA*, USB*, MSIOF*, SDHI*, QSPI*, MMCIF,
> Audio*, VIN*, Thermal, IRQC, PFC, CMT
> 
> * Platform device support under development in v3.15-pre
> 
> In the Multiplatform DT for Lager/Koelsch the following devices have DT support:
> 
> ETHER, SCIF**, I2C, SATA, MSIOF, SDHI, QSPI, MMCIF, Thermal, IRQC, PFC, CMT**
> 
> ** Driver DT binding development on-going but integration not finalized
> 
> In Multiplatform DT for Lager/Koelsch the following devices lack DT bindings:
> 
> DU (drm/kms)
> USB (host/function/phy)
> Audio (alsa-soc + dmac)
> VIN (v4l2 + camera sensor)

Ok, thanks for the list.

> Our plan is to migrate over to the DT Multiplatform code base as soon
> as ever possible, but at the same time we do not want to commit long
> term support of potentially premature DT bindings. Our short term
> solution to that is to use platform devices for a limited number of
> devices together with DT Multiplatform.
> 
> If you would like use to adjust our way forwards please let me know!

I think you should try to close the gap between ATAGS and DT now and
stop the dual strategy. You seem to have come far enough with the
basic infrastructure (clock, pinctrl, irq, timer, ...) that all the
devices missing DT support now are on-chip peripherals. If this is the
case, it should be possible to use auxdata registration in the
per-soc files to connect the platform data to the remaining devices
that are lacking DT bindings. This means we have to be more careful
with the dependencies when a driver gains a DT binding, but at least
we can enforce that any driver in the future only gets merged with
a proper DT binding as we do for other subarchitectures, and you don't
have to implement probing twice for each new driver.

	Arnd
