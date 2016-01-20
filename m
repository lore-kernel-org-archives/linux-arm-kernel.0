From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Jan 2016 09:06:11 +0000
Subject: [PATCH 1/3] irqchip/GIC: Add workaround for aliased GIC400
In-Reply-To: <CADaLNDmTTM36-bqT+h2WOgX8TebhYoAMNSf=fe_qusxZj-8DSw@mail.gmail.com>
References: <CADaLNDmTTM36-bqT+h2WOgX8TebhYoAMNSf=fe_qusxZj-8DSw@mail.gmail.com>
Message-ID: <20160120090611.2c8e3649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Duc,

On Tue, 19 Jan 2016 11:12:15 -0800
Duc Dang <dhdang@apm.com> wrote:

> On Sun, Sep 13, 2015 at 4:14 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >
> > The GICv2 architecture mandates that the two 4kB GIC regions are
> > contiguous, and on two separate physical pages (so that access to
> > the second page can be trapped by a hypervisor). This doesn't work
> > very well when PAGE_SIZE is 64kB.
> >
> > A relatively common hack^Wway to work around this is to alias each
> > 4kB region over its own 64kB page. Of course in this case, the base
> > address you want to use is not really the begining of the region,
> > but base + 60kB (so that you get a contiguous 8kB region over two
> > distinct pages).
> >
> > Normally, this would be described in DT with a new property, but
> > some HW is already out there, and the firmware makes sure that
> > it will override whatever you put in the GIC node. Duh. And of course,
> > said firmware source code is not available, despite being based
> > on u-boot.
> >
> > The workaround is to detect the case where the CPU interface size
> > is set to 128kB, and verify the aliasing by checking that the ID
> > register for GIC400 (which is the only GIC wired this way so far)
> > is the same at base and base + 0xF000. In this case, we update
> > the GIC base address and let it roll.
> 
> Hi Marc,
> 
> When booting ACPI with X-Gene Mustang, I saw it hangs when EOI mode is
> enabled, should we have ACPI version for gic_check_eoimode as well?

ACPI doesn't provide the size of the CPU interface, so you cannot
perform the same kind of check and bug workaround. I'm afraid you have
to fix your ACPI tables (which shouldn't be a problem since nobody is
using ACPI in production so far...).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
