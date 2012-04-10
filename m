From: govindraj.raja@ti.com (Govindraj.R)
Date: Tue, 10 Apr 2012 19:10:44 +0530
Subject: [PATCH 0/2] OMAP2+: UART: Fix usage of default mux pads
Message-ID: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Govindraj.R" <govindraj.raja@ti.com>

We populating default uart mux pins if no mux data is provided
by board files. But were not probing the availability of uart pins
in tx/rx mode i.e. mux mode0. If particular pin is used for any other
purpose then default pads were breaking those peripherals e.g. uart2
pin was used as gpio nreset pin ehci on beagle board.

So remove the default adding procedure and probe the pins before
using them as uart pins. Determine if uart pins are used in uart mux_mode0
then configure rx pin for wakeup capability.

Testing updates:
Boot tested on 3430SDP
Tested on beagle-xm with ehci module which needs uart pin muxed as gpio
line for nreset sequence.

RX pad wakeup after enabling off mode in cpu_idle path and suspend path
tested - 3430SDP & Beagle-XM

Govindraj.R (2):
  OMAP2+: UART: Fix incorrect population of default uart pads
  OMAP2+: UART: Add mechanism to probe uart pins and configure rx
    wakeup

 arch/arm/mach-omap2/mux.c    |    3 +-
 arch/arm/mach-omap2/mux.h    |   10 +++
 arch/arm/mach-omap2/serial.c |  164 +++++++++++++-----------------------------
 3 files changed, 61 insertions(+), 116 deletions(-)

-- 
1.7.9
