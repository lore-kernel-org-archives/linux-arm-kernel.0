From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 May 2015 11:53:02 +0200
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <CACPK8XfkxU+5Szn6=fdeiqCK5+yVYHZc+iaUb1eqowFQZt20LA@mail.gmail.com>
References: <55417F5A.4040300@linaro.org> <2953543.GNxjbWV8RC@wuerfel>
 <CACPK8XfkxU+5Szn6=fdeiqCK5+yVYHZc+iaUb1eqowFQZt20LA@mail.gmail.com>
Message-ID: <2490159.r1U8jHTvO3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 May 2015 12:27:54 Joel Stanley wrote:
> On Tue, May 5, 2015 at 1:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 04 May 2015 10:09:04 Shannon Zhao wrote:
> >> On 2015/4/30 17:56, Arnd Bergmann wrote:
> >> > On Thursday 30 April 2015 10:29:53 Mark Rutland wrote:
> >
> >> > a) have an input device send the KEY_POWEROFF or KEY_REBOOT events to
> >> >    user space, and have some process (e.g. desktop environment, or daemon)
> >>
> >> About this daemon, do we need a doc or spec to standardize it?
> >
> > There is probably documentation about this that we just need to locate.
> > On my workstation, the power button device is owned by "systemd-logind",
> > I'd assume something like that to be present elsewhere as well.
> >
> >> > b) Have a special driver that calls orderly_poweroff or orderly_reboot.
> >> >    Only PowerPC (OPAL) uses the orderly_reboot() here, but a few platforms
> >> >    (Xen, fsl_hypervisor, and some sparc and powerpc machines) as well
> >> >    as some device drivers (thermal management etc) call this as well.
> >> >    The effect is to call a user-configured binary (/sbin/reboot and
> >> >    /sbin/poweroff by default).
> >> >
> >>
> >> This looks good which reuses existing user space process.
> >>
> >
> > Joel Stanly wrote that patch for PowerPC, maybe he can explain why
> > this PowerPC is doing it this way instead of having an input device
> > that sends KEY_RESTART. It's probably a good idea to have ARM and
> > PowerPC normally do the same thing here, especially if there are
> > problems with just using a gpio-key device.
> 
> We wanted to support reboot and poweroff on existing distributions
> without having to rely on new userspace.
> 
> I chatted to a few people at linux.conf.au this year and we came to
> the conclusion that the options were orderly_poweroff() or ACPI for
> doing a graceful shutdown involving userspace. ACPI required acpid or
> a desktop environment listening to the netlink message (plus we aren't
> an ACPI machine) so that was out.
> 
> KEY_POWEROFF looks useful, but how would you support userspace that
> does not have a systemd-logind, or anything listening to that input
> event?

Ok, thanks for providing that background. I was under the impression
that the power button was not handled through netlink but instead
through the input subsystem, and I just checked the acpid source
code and found that it basically handles acpi events and input
events separately and should still work fine if only one of the
two is present.

I still find it hard to come up with a good decision for ARM here:
I think either way will work in most cases but has minor downsides
(orderly_poweroff() and orderly_reboot() being less configurable
vs input events requiring some user space to run).
Unfortunately, it is not an option to just "do both", because the
orderly_reboot() will unconditionally reboot the system, so any
user configuration is just ignored here.

Maybe we just use the the input framework for now, because it
requires zero kernel changes and is already used on ARM platforms
today, and see if we run into problems with that.

	Arnd
