From: balbi@ti.com (Felipe Balbi)
Date: Sun, 5 Feb 2012 13:35:22 +0200
Subject: [PATCH v9 01/25] gpio/omap: remove dependency on gpio_bank_count
In-Reply-To: <CAMQu2gyNhEJ3vr7_o_xYAQOYKaRofJViobKtfH2HoxwgU7nUpw@mail.gmail.com>
References: <4F2AF68D.1000505@ti.com>
 <20120202214907.GA22888@legolas.emea.dhcp.ti.com>
 <20120202215350.GB22888@legolas.emea.dhcp.ti.com>
 <4F2B078B.1040709@ti.com>
 <20120202220744.GA23092@legolas.emea.dhcp.ti.com>
 <87liojajs4.fsf@ti.com>
 <20120204160802.GA10818@legolas.emea.dhcp.ti.com>
 <CA+HSevqvHAgA+PPLm8BH5vfWkc8yY8W+fRpqjT2urq2EWtSYiA@mail.gmail.com>
 <20120205090805.GA13300@legolas.emea.dhcp.ti.com>
 <CAMQu2gyNhEJ3vr7_o_xYAQOYKaRofJViobKtfH2HoxwgU7nUpw@mail.gmail.com>
Message-ID: <20120205113521.GA13533@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 05, 2012 at 02:46:19PM +0530, Shilimkar, Santosh wrote:
> >> bank->mod_usage check is used to take care of doing pm_runtime_get*/put* only
> >> if all the GPIOs in a particular bank are enabled or disabled respectively.
> >
> > and why should you care about that ? The first get will enable the
> > resources you need, the second get will just increase a counter and so
> > on. So if you have 32 gets, you will disable the module when you have 32
> > puts.
> >
> Am not sure if it is clear to you that the GPIO resources like clock,
> debounce clk are per bank wise and not per GPIO line. So doing 32

this is just one more reason to have usage counters.

> get/put per bank is stupid. runtime pm is for managing pm

what's stupid is trying to use the pm usage counters as a binary flag,
see below.

> resources and if the pm resource is per bank, it has to be
> handled per bank.

hehe, what are you talking about Santosh ? That's the whole point of
reference counting. If there are 32 users for 1 resource, you want to
make sure that you only free the resources (clocks, or whatever resource
you want) after all 32 users are done with it.

Trying to use the pm usage counter as a binary flag, that's the stupid
part of the OMAP GPIO driver.

Instead of adding checks such as:

if (module_isnt_used())
	enable_clocks();

on get and:

if (module_isnt_needed_anymore())
	disable_clcoks()

on put is the most useless piece of code on that driver. Because such
checks are already available on PM core through usage counters. The way
that part of the code works is as follow:

get() {
	if (pm_counter_is_zero(dev)) {
		atomic_inc();

		rpm_resume();
	}
}

put() {
	atomic_dec();

	if (pm_counter_is_zero(dev)) {
		rpm_suspend();
	}
}

Do you not see that you're duplicating functionality by trying to use
the pm counter a binary flag ?

> >> With the above change, pm_runtime_put*/get* would be called for every
> >> gpio_request()
> >> /_free() (that is, for upto 32 pins in OMAP3/4) in a bank irrespective
> >> of whether other
> >
> > so ?
> It's useless.

no, it's not.

> >> GPIO pins are enabled or disabled in the same bank. Hence it is
> >> required to have a
> >> check based on mod_usage.
> >
> > unnecessary.
> >
> I don't think so.

then show that to me with code. Looking at the usage counters on pm
runtime, you're duplicating functionality with it and trying to use it
as a binary flag.

Preventing multiple gets/puts breaks the whole idea of _having_ usage
counters to start with.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120205/9aae9650/attachment.sig>
