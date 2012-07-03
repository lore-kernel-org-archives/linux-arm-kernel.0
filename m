From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Jul 2012 14:01:35 +0000
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <20120703132447.GN29030@opensource.wolfsonmicro.com>
References: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
 <4FF2EEA1.6080204@linaro.org>
 <20120703132447.GN29030@opensource.wolfsonmicro.com>
Message-ID: <201207031401.36262.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 July 2012, Mark Brown wrote:
> > Before, when we probed each device from Device Tree we came up
> > against some fairly major limitations of the Device Tree. As a
> > result, Arnd and I agreed that this was the way to go.
> 
> I'm really unconvinced that instnatiating the MFD cells from device tree
> is in general a good idea.

In general it's not, e.g. it makes no sense when the MFD is just
a bunch of registers that are mapped to various distinct Linux
devices. The two mfd devices on ux500 (prcmu and ab8500) are really
buses by themselves that happen to be implemented using the MFD
framework on Linux.

I don't see how we would get around representing the buses in
the device tree because we have to refer to nodes under them
from off-chip devices. Simplified we have something like


  db9500 {
	prcmu {
		opp at 1 {
		};

		regulator at 2 {
		};

		watchdog at 4 {
		};

		ab8500 at 5 {
			regulator at 3 {
			};
			regulator at 4 {
			};
			adc at a {
			};
			rtc at f {
			};
			irq at e {
			};
			gpio at 10 {
			};
		};
	};
  };

Most of the stuff on the board is connected to the ab8500 regulators and
gpio pins, which are also used as interrupts. In order to hook up
the external devices in the device tree, we need to have something that
we can point to as their interrupt-parent or the phandle in the gpio
description.

	Arnd
