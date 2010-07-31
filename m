From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 10:16:50 +0100
Subject: [PATCH] PXA: Colibri320: Add M41T00 RTC support
In-Reply-To: <201007310933.05611.marek.vasut@gmail.com>
References: <1280543453-28237-1-git-send-email-marek.vasut@gmail.com>
	<201007310926.03292.pieterg@gmx.com>
	<201007310933.05611.marek.vasut@gmail.com>
Message-ID: <20100731091650.GB23886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 09:33:05AM +0200, Marek Vasut wrote:
> Actually, there is one thing that puzzles me. Eric/Dan, shall I stick all the 
> MFP configs into one (or two, one for board and once for cpu card) array or keep 
> it split in multiple smaller arrays for each device? I think putting it all in 
> one place would be more readable.

I've always been of the opinion that the pin configuration should be setup
independently of what drivers are built into the kernel or not.

Consider a pin which is used as an output to drive some high impedance
signal (eg, an input on another device) and it doesn't have any pull-up
or pull down.  If on reset, this signal is also configured as a high
impedance input, it will float.

Inputs which float cause increased current drain (that's a fact of the
high impedance FET input configurations - a floating signal ends up
partially turning on both N and P FETs at both ends, which allows
current to flow between supply and ground.  This is also why the current
consumption of devices is related to their clock frequency and disabling
clocks saves power.)

So, it is desirable to have the pin configuration correct for the entire
board, irrespective of the driver configuration.
