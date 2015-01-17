From: broonie@kernel.org (Mark Brown)
Date: Sat, 17 Jan 2015 14:12:48 +0000
Subject: [systemd-devel] Making udev emit a signal when it is done
 loading modules
In-Reply-To: <20150117135630.GA25585@kroah.com>
References: <54BA20D0.7060402@redhat.com>
 <20150117135630.GA25585@kroah.com>
Message-ID: <20150117141248.GD6414@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 05:56:30AM -0800, Greg KH wrote:
> On Sat, Jan 17, 2015 at 09:44:00AM +0100, Hans de Goede wrote:

> > If however the ahci_platform driver is a module, then as soon as
> > the kernel is ready to start init, unused regulators are turned off
> > and the disk looses its power while spinning and ends up doing an
> > emergency heads park.

> What turns off the power in this situation?  The kernel?  Or userspace?
> Don't you have control of this?

The kernel turns off the power in late_initcall because it noticed that
nothing is using the regulator, it does this because otherwise we're
just left with whatever the bootloader had which will may well be
wasting power on unused rails due to inflexible PMICs (we do similar
things for other subsystems like clocks).  This works fine for most use
cases since in embedded systems anything critical tends to end up built
in.

There is configurability to allow things to be flagged as always on so
they never get turned off.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150117/d69f50dd/attachment-0001.sig>
