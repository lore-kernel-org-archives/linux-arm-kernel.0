From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 11:56:17 +0200
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <20150430092953.GA32190@leverpostej>
References: <55417F5A.4040300@linaro.org>
 <CAFEAcA_VSkPPhmMmn+M+AoX5wjB0r66xq0ygMLSfR7zg0yiXnw@mail.gmail.com>
 <20150430092953.GA32190@leverpostej>
Message-ID: <10771707.5UNQMOWJlc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 April 2015 10:29:53 Mark Rutland wrote:
> On Thu, Apr 30, 2015 at 10:08:05AM +0100, Peter Maydell wrote:
> > On 30 April 2015 at 09:03, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thursday 30 April 2015 09:03:22 Shannon Zhao wrote:
> > >>
> > >> I am looking at adding support for external power down and reboot to
> > >> ARM VMs.  With ACPI this is fairly straight forward and requires only
> > >> adding a GPIO controller to the virt machine model and extending ACPI
> > >> appropriately (see code here [1]). In addition Linaro LEG also have
> > >> done a test that uses GPIO as power button to shutdown OS on fast model
> > >> (see detail here [2]).
> > >>
> > >> However, we would like for this to work in systems that do not use
> > >> ACPI as well. Adding a GPIO controller will still work, but we would
> > >> need a generic way to tell Linux how to handle the GPIO events without
> > >> adding any board-specific code to the VIRT platform. And what guest
> > >> kernel driver do we need? Do we need another user-level daemon like acpid?
> > >>
> > >> Note that external shutdown can also be accomplished using the qemu
> > >> guest agent [3], but maybe this is not a sufficiently stable approach.
> > >>
> > >> Any input on the approach to take here is very welcome.
> > >
> > > I would expect drivers/power/reset/gpio-poweroff.c to work in an identical
> > > way with ACPI and DT, once you have added an ACPI binding for it.
> > 
> > Looking at Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
> > that appears to be for "let the guest kernel turn off the system
> > from the inside by toggling a GPIO line". What we want is the
> > opposite: the external system (QEMU, in this case) toggles a GPIO
> > line in order to request the guest kernel to do a clean shutdown
> > or reboot. Or have I misunderstood what gpio-poweroff can do?
> 
> No, you're correct.
> 
> There are a few "power button" bindings around, but it looks like they
> all rely on platform details and aren't that generic.
> 
> With ACPI what events may be singalled? Just power off, or reset, etc?
> 
> Which of these do we need to be able to handle with DT?

Actually, there are at least three different ways to do this:

a) have an input device send the KEY_POWEROFF or KEY_REBOOT events to
   user space, and have some process (e.g. desktop environment, or daemon)
   handle the event by doing an appropriate action. This seems to be
   what ACPI does on x86, and a lot of device tree based systems do
   the same thing using gpio-keys.

b) Have a special driver that calls orderly_poweroff or orderly_reboot.
   Only PowerPC (OPAL) uses the orderly_reboot() here, but a few platforms
   (Xen, fsl_hypervisor, and some sparc and powerpc machines) as well
   as some device drivers (thermal management etc) call this as well.
   The effect is to call a user-configured binary (/sbin/reboot and
   /sbin/poweroff by default).

c) call ctrl_alt_del(): a bunch of platforms do this, and user space
   has to configure whether this immediately calls kernel_restart(),
   or sends SIGINT to the init process, which can then do an orderly
   reboot. Again, highbank does this as the reboot action, but very
   few other systems seem to do it, aside from the vt keyboard driver
   that is used on all machines that have normal keyboard.

	Arnd
