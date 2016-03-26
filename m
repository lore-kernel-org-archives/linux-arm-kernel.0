From: ipaton0@gmail.com (Iain Paton)
Date: Sat, 26 Mar 2016 08:56:53 +0000
Subject: [linux-sunxi] [PATCH 1/3] sunxi: A20-OLinuXino-LIME2: Fix
 ldo3/ldo4 in DTS
In-Reply-To: <56F5DEB9.7070207@gmail.com>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <56F5DEB9.7070207@gmail.com>
Message-ID: <56F64ED5.7030405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having reread the A20 datasheet yesterday, something in the back of my 
mind was bothering me overnight so I took some time to check this morning.

On the lime2 schematic we see the pins labeled as follows:

F19 : VCC_CSI0
E18 : VCC_CSI1

However the A20 datasheet doesn't label them this way, instead using:

F19 : VCC-PE : Port E Power Supply
E18 : VCC-PG : Port G Power Supply

no mention at all of CSI. CSI just happens to be a function that can be 
multiplexed onto ports E & G.

So lets assume for a moment we don't have a CSI device, or a CSI driver 
and are not using those pins for CSI functions but are instead using 
their default GPIO purpose, or in the case of PG perhaps for UART3 
or UART4.

What happens when you disable the regulator?  Hopefully from the above 
you'll already have worked out that you lose ports E & G when you turn 
their I/O power supply off and anything multiplexed onto those ports 
becomes unuseable.

I haven't checked other schematics, but all of the Olimex A10/A20 
boards along with Cubieboard & CubieTruck label these pins as VCC_CSIn
It would be my guess that there's a reference design being given to 
manufacturers, perhaps the original Cubieboard even, that makes this 
mistake and everyone else has blindly copied it.

So, unless we want to lose access to 24 GPIO pins for no real reason 
I'd suggest that the u-boot patch is reverted and/or the dts is altered 
such that the gpio driver claims the regulators and prevents them being 
turned off.

The u-boot commit message and reasoning given on list are trivially 
proved incorrect. Ports E & G are not CSI-only, losing all other 
functions on these ports is not acceptable.

I've also just tested building u-boot with LDO3 & 4 voltages set to 
3.3v to be the same as CubieBoard, this works for lime2.
So it's unlikely that the 2.8v & 2.3v settings from my previous patch 
make sense. The crash is actually being caused by something else, 
probably sequencing, due to unnecessarily turning the regulators off.
Whatever the reason, we don't have enough information in the 
datasheets to know for sure so we simply shouldn't turn them off to 
begin with.

The people behind this need to take responsibility and clean up their 
mess.

Iain
