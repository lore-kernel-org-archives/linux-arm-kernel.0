From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Sep 2014 16:49:03 +0100
Subject: [PATCH v4 05/18] ARM64 / ACPI: Introduce sleep-arm.c
In-Reply-To: <20140912151850.GB9234@xora-haswell.xora.org.uk>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
 <20140912145102.GB5532@arm.com>
 <20140912151850.GB9234@xora-haswell.xora.org.uk>
Message-ID: <20140912154903.GE5532@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 04:18:51PM +0100, Graeme Gregory wrote:
> On Fri, Sep 12, 2014 at 03:51:02PM +0100, Catalin Marinas wrote:
> > On Fri, Sep 12, 2014 at 03:00:03PM +0100, Hanjun Guo wrote:
> > > --- a/drivers/acpi/Makefile
> > > +++ b/drivers/acpi/Makefile
> > > @@ -23,7 +23,11 @@ acpi-y				+= nvs.o
> > >  
> > >  # Power management related files
> > >  acpi-y				+= wakeup.o
> > > +ifeq ($(ARCH), arm64)
> > > +acpi-y				+= sleep-arm.o
> > > +else # X86, IA64
> > >  acpi-y				+= sleep.o
> > > +endif
> > >  acpi-y				+= device_pm.o
> > >  acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
> > 
> > What about:
> > 
> > -acpi-y				+= sleep.o
> > +acpi-$(CONFIG_ACPI_SLEEP)	+= sleep.o
> > 
> > and make CONFIG_ACPI_SLEEP depend on !ARM64? Does the kernel compile if
> > you disable CONFIG_ACPI_SLEEP?
> 
> sleep.c is still needed in the case CONFIG_ACPI_SLEEP=n
> 
> basically the two functions I stubbed are always called by bus.c

So the two functions are:

acpi_target_system_state() - already defined in acpi_bus.h when
CONFIG_ACPI_SLEEP is off.

acpi_sleep_init() - this one doesn't have a dummy implementation for
!ACPI_SLEEP.

Now, for x86, do we need acpi_sleep_init() when CONFIG_ACPI_SLEEP is
off? If not, we could simply add a dummy acpi_sleep_init() function when
!ACPI_SLEEP and don't enable the config option for arm64.

-- 
Catalin
