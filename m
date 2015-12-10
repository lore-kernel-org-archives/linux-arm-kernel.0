From: horms@verge.net.au (Simon Horman)
Date: Thu, 10 Dec 2015 16:02:42 +0900
Subject: [PATCH 00/13] ARM: shmobile: dts: Update console parameters
In-Reply-To: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20151210070239.GA17682@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 06:54:05PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series updates the console parameters in the DTSes for
> various Renesas ARM boards.
> 
>   - For all of them, the serial port config is added to
>     chosen/stdout-path, as per current best practices,
>   - On some boards (armadillo, bockw, kzm9d, kzm9g), "console="
>     parameters are removed from the kernel command lines, as they're no
>     longer needed for DT-only platforms,
>   - On some boards (genmai, kzm9g), the console alias is changed to
>     "serial0", for consistency with other boards (the first serial port
>     is always called "serial0", unless labeled otherwise); this does
>     mean the device changes its name to /dev/ttySC0 in userspace, which
>     also happened on R-Car Gen2 before,
>   - On kzm9d, a console alias is added.
> 	    
> Tested on r8a73a4/ape6evm, r8a7740/armadillo, r8a7778/bockw,
> r8a7779/marzen, r8a7791/koelsch, and sh73a0/kzm9g.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (13):
>   ARM: shmobile: alt dts: Add serial port config to chosen/stdout-path
>   ARM: shmobile: ape6evm dts: Add serial port config to
>     chosen/stdout-path

alt and ape6evm tested ok.
I have queued up the changes for those boards.

>   ARM: shmobile: armadillo800eva dts: Update console parameters

I would prefer not to take the serial1 -> serial0 portion of this change at
this time as it causes a user-space visible change: the console moves from
ttySC1 to ttySC0. I noticed this because I no longer made it all the way
to user-space which was expecting a console on ttySC1.

-- start before --
[    0.050000] e6c50000.serial: ttySC1 at MMIO 0xe6c50000 (irq = 25, base_baud = 0) is a scifa
[    0.780000] console [ttySC1] enabled
-- end before -- 

-- start after --
[    0.050000] e6c50000.serial: ttySC0 at MMIO 0xe6c50000 (irq = 25, base_baud = 0) is a scifa
[    0.780000] console [ttySC0] enabled
-- end after -- 

>   ARM: shmobile: bockw dts: Update console parameters

bockw tested ok.
I have queued up the change for that board.

>   ARM: shmobile: genmai dts: Update console parameters

As per my remarks regarding the armadillo800eva I would prefer not
to make the serial2 -> serial0 portion of this change.

As a bonus the  serial2 -> serial0 portion of this change seems to prevent
console output during boot too. I've posted some debuging using earlyprintk
in reply to this patch in case its useful.

>   ARM: shmobile: gose dts: Add serial port config to chosen/stdout-path
>   ARM: shmobile: koelsch dts: Add serial port config to
>     chosen/stdout-path

gose and koelsch tested ok.
I have queued up the change for those boards.

>   ARM: shmobile: kzm9d dts: Update console parameters

I am wary of the new serial1 alias.
Have you checked to see if there is any user-space visible change
as a result of this?

>   ARM: shmobile: kzm9g dts: Update console parameters

As per my remarks regarding the armadillo800eva I would prefer not
to make the serial4 -> serial0 portion of this change.

>   ARM: shmobile: lager dts: Add serial port config to chosen/stdout-path

lager tested ok.
I have queued up the change for this board.

>   ARM: shmobile: marzen dts: Add serial port config to
>     chosen/stdout-path

Changing &scif2 to serial0 creates a user-space visible change:
the console moves from ttySC2 to ttySC0.

I'm unsure how we can update to use the new syntax without encountering
this problem.

>   ARM: shmobile: porter dts: Add serial port config to
>     chosen/stdout-path
>   ARM: shmobile: silk dts: Add serial port config to chosen/stdout-path

I'm unable to test porter and silk but they look ok to me.
I have queued up the changes for those boards.
