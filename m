From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 May 2015 17:49:44 +0200
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <5546D4C0.5090105@linaro.org>
References: <55417F5A.4040300@linaro.org> <10771707.5UNQMOWJlc@wuerfel>
 <5546D4C0.5090105@linaro.org>
Message-ID: <2953543.GNxjbWV8RC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 May 2015 10:09:04 Shannon Zhao wrote:
> On 2015/4/30 17:56, Arnd Bergmann wrote:
> > On Thursday 30 April 2015 10:29:53 Mark Rutland wrote:

> > a) have an input device send the KEY_POWEROFF or KEY_REBOOT events to
> >    user space, and have some process (e.g. desktop environment, or daemon)
> 
> About this daemon, do we need a doc or spec to standardize it?

There is probably documentation about this that we just need to locate.
On my workstation, the power button device is owned by "systemd-logind",
I'd assume something like that to be present elsewhere as well. 

> > b) Have a special driver that calls orderly_poweroff or orderly_reboot.
> >    Only PowerPC (OPAL) uses the orderly_reboot() here, but a few platforms
> >    (Xen, fsl_hypervisor, and some sparc and powerpc machines) as well
> >    as some device drivers (thermal management etc) call this as well.
> >    The effect is to call a user-configured binary (/sbin/reboot and
> >    /sbin/poweroff by default).
> > 
> 
> This looks good which reuses existing user space process.
> 
> > c) call ctrl_alt_del(): a bunch of platforms do this, and user space
> >    has to configure whether this immediately calls kernel_restart(),
> >    or sends SIGINT to the init process, which can then do an orderly
> >    reboot. Again, highbank does this as the reboot action, but very
> >    few other systems seem to do it, aside from the vt keyboard driver
> >    that is used on all machines that have normal keyboard.
> > 
> 
> This only supports reboot, but we also need poweroff.

Well, I think these traditionally go together, and a lot of platforms
use c) for reboot and b) for poweroff, because c) was there first
and b) was introduced later to provide the reboot handling. The
orderly_reboot in turn was only just introduced last month.

Joel Stanly wrote that patch for PowerPC, maybe he can explain why
this PowerPC is doing it this way instead of having an input device
that sends KEY_RESTART. It's probably a good idea to have ARM and
PowerPC normally do the same thing here, especially if there are
problems with just using a gpio-key device.

	Arnd
