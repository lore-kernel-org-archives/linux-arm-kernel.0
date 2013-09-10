From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Sep 2013 22:35:22 +0100
Subject: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
In-Reply-To: <3397524.g9aUWuArnm@vostro.rjw.lan>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130910142631.GL7393@intel.com>
 <20130910161321.GM29403@sirena.org.uk>
 <3397524.g9aUWuArnm@vostro.rjw.lan>
Message-ID: <20130910213522.GG29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 10:04:21PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 10, 2013 05:13:21 PM Mark Brown wrote:

> > OK, that is very much not the model which embedded systems follow, in
> > embedded systems the driver for the device is fully in control of its
> > own power.  It gets resources like GPIOs and regulators which allow it
> > to make fine grained decisions.

> There are platforms where those resources are simply not available for
> direct manipulation and we need to use ACPI methods for power management.

> Now, since those methods are used in pretty much the same way for all I2C
> devices, we add a PM domain for that to avoid duplicating the same code in
> all of the drivers in question (patch [2/2]).  Does that make sense to you?

It doesn't seem like a particular problem, but the existing usage does
need to be preserved for the systems that use it so things like having
auto as the default and updating the drivers seem like they're needed.

> > If we're starting to get a reasonable number of buses following the same
> > pattern it seems like we're in a position to start 

> We need that for exactly 3 buses: platform (already done), I2C and SPI.

> No other bus types are going to use ACPI this way for PM, at least for the
> time being, simply because PCI, USB and SATA/IDE have their own ways of doing
> this (which are bus-specific) and the spec doesn't cover other bus types
> directly (it defines support for UART, but we don't have a UART bus type).

> Moreover, because PCI and USB use ACPI for PM in their own ways, moving that
> thing up to the driver core would be rather inconvenient.

That only applies to the power domains though, what Mika was saying was
that the process for enabling runtime PM (just drop a reference) also
becomes easier with this method regardless of anything else - that makes
sense to me as something we might want to end up with so do we want to
just move towards making that a default?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130910/28a97a47/attachment-0001.sig>
