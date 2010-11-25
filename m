From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 24 Nov 2010 16:42:27 -0800
Subject: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
	disabled
In-Reply-To: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 24 Nov 2010 16:49:05 -0700 (MST)")
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
Message-ID: <87oc9e5j4c.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> The console semaphore must be held while the OMAP UART devices are
> disabled, lest a console write cause an ARM abort (and a kernel crash)
> when the underlying console device is inaccessible.  These crashes
> only occur when the console is on one of the OMAP internal serial
> ports.
>
> While this problem has been latent in the PM idle loop for some time,
> the crash was not triggerable with an unmodified kernel until commit
> 6f251e9db1093c187addc309b5f2f7fe3efd2995 ("OMAP: UART: omap_device
> conversions, remove implicit 8520 assumptions").  After this patch, a
> console write often occurs after the console UART has been disabled in
> the idle loop, crashing the system.  Several users have encountered
> this bug:
>
>     http://www.mail-archive.com/linux-omap at vger.kernel.org/msg38396.html
>
>     http://www.mail-archive.com/linux-omap at vger.kernel.org/msg36602.html
>
> The same commit also introduced new code that disabled the UARTs
> during init, in omap_serial_init_port().  The kernel will also crash
> in this code when earlyconsole and extra debugging is enabled:
>
>     http://www.mail-archive.com/linux-omap at vger.kernel.org/msg36411.html
>
> The minimal fix for the -rc series is to hold the console semaphore
> while the OMAP UARTs are disabled.  This is a somewhat overbroad fix,
> since the console may not be located on an OMAP UART, as is the case
> with the GPMC UART on Zoom3.  While it is technically possible to
> determine which devices the console or earlyconsole is actually
> running on, it is not a trivial problem to solve, and the code to do
> so is not really appropriate for the -rc series.
>
> The right long-term fix is to ensure that no code outside of the OMAP
> serial driver can disable an OMAP UART.  As I understand it, code to
> implement this is under development by TI.

Yes, what is underway is a conversion of the omap-serial driver to use
runtime PM so we can finally rid ourselves of the hackery in
mach-omap2/serial.c.  The PM stuff there is a real mess to understand
and maintain, and rather fragile, obviously.  Once the serial driver
itself is in charge of when to disable the UARTs, this becomes a much
easier problem to manage.

> This patch is a collaboration between Paul Walmsley <paul@pwsan.com>
> and Tony Lindgren <tony@atomide.com>.  Thanks to Ming Lei
> <tom.leiming@gmail.com> and Pramod <pramod.gurav@ti.com> for their
> feedback on earlier versions of this patch.

> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Ming Lei <tom.leiming@gmail.com>
> Cc: Pramod <pramod.gurav@ti.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Very nice.  I've been exploring various solutions to this problem as
well, but this one is much cleaner.  Also, I hadn't discovered the 'try'
version of the console semaphore, so was running into recursive locking.

Anyways, tested on omap35xx: omap3evm (uart1/core console) and beagle
(uart3/per console) and omap34xx/n900 (uart3/per console) using both
retention-idle and off-idle.

Kevin
