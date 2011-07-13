From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jul 2011 15:42:37 +0200
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <4E1D52E4.1040907@linaro.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<201107121847.46144.arnd@arndb.de> <4E1D52E4.1040907@linaro.org>
Message-ID: <201107131542.37432.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 July 2011, Lee Jones wrote:
> Okay, obviously I'm missing something. I am trying to adhere to your
> advice, but there must be some communication break-down somewhere down
> the line. Let me attempt to explain what's going on in my head.
> 
> You keep asking for the SoC devices to be children of the parent SoC
> device and as far as I'm concerned they are. Devices appear like this in
> sysfs:
> 
> /sys/devices/soc/1   /* 1st SoC */
> /sys/devices/soc/2   /* 2nd SoC */
> /sys/devices/soc/3   /* 3rd SoC */
> 
> etc ...
> 
> Surely the parent which you speak of is "soc" and each SoC is
> represented by "1|2|3|..."? Under each directory with a digit naming
> convention appears that SoC's attributes, namely: "family", "machine",
> "process", "revision" and "soc_id".
> 
> If this is incorrect, would you be kind enough to tell me why its
> incorrect and how you would like it changed/fixed please?
> 

I'm not talking of the root soc devices but the platform_devices that
are part of the soc, i.e. interrupt controller, i2c bus, mmc host,
etc.

Basically all the devices that are currently statically declared
in arch/arm/mach-ux500/board-mop500.c and are missing a parent pointer.

What I'm asking you to do is fix those device declarations to have
their .dev.parent pointer point to the correct soc device. If there
are nested buses, they should ideally also be represented as devices
so you end up with something like

/sys/devices/soc/1/amba/uart1
                       /uart2
                       /i2c/bus1
                           /bus2/tc35892
                                /lp5521
                       /spi/foo
                           /bar
                  /dma
                /2/amba/...

Basically, if you have a soc node, I would expect /sys/devices/platform to
become empty, and all devices properly parented to where they are actually
connected.

	Arnd
