From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Wed, 08 Oct 2014 10:02:07 +0100
Subject: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <4656BEB6164FC34F8171C6538F1A595B2E997E59@SHSMSX101.ccr.corp.intel.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
 <54348D56.20708@nexus-software.ie>
 <4656BEB6164FC34F8171C6538F1A595B2E997E59@SHSMSX101.ccr.corp.intel.com>
Message-ID: <5434FD8F.8090209@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/14 08:48, Chen, Alvin wrote:

> Now, we have another board which can support 4 slave spi per master, but not only Galileo. Since that board is not public, after discussing with team, we decide to make the
> upstream code to support '1'.
>
> I will change it back to
> .num_chipselect = 1,

Hi Alvin.

The important thing in terms of Galileo is to ensure that a GPIO can be 
used for chip-select.

The user-space API ported from Arduino to Linux wants to control it's 
own chip-select directly - so the internal chip-select of the Quark SPI 
master can - and does de-assert while doing SPI transactions on Galileo. 
The CS on the master is tied to FIFO occupancy - so at higher bit-rates 
we can fail to keep the FIFO occupied :(

That doesn't matter though, because the pinned out SPI:CS on the Arduino 
header is a GPIO.

 From the perspective of the Arduino code in user-space and the slave 
hardware @ the other end of the SPI bus - we see a nice and consistent 
chip-select for the entire duration of the SPI transaction - even though 
the actual SPI:CS coming from the SoC can *waggle* - when FIFOs go empty.

IMO - so long as you've tested on Galileo and seen working SPI - you're 
good to go anyway.

Bryan
