From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 26 Jun 2014 11:30:33 +0530
Subject: Suspend/Resume support for PCI
In-Reply-To: <CAGAs2AnPSGYhC7KkW=pFYKaoFgp7NEjf4gyoDeXZ9wQoPFPG7g@mail.gmail.com>
References: <CAGAs2AnPSGYhC7KkW=pFYKaoFgp7NEjf4gyoDeXZ9wQoPFPG7g@mail.gmail.com>
Message-ID: <CAKohpok9YxuQqD53A9O0MXjPhvzfv5LjbjZcWQBV_R_hTvbeTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'd Arnd/Ulf.

On 26 June 2014 11:24, AYAN KUMAR HALDER <ayankumarh@gmail.com> wrote:
> Hi,
>
> I am using a ARM based custom SOC which has a power management unit to
> turn off/on the various power domains. When I execute a suspend
> command(echo mem > /sys/power/state), then I turn off the power of the
> entire SOC except my PMU( as they are in different power domains).
>
> When ever the PMU receives a certain wake-up interrupt, it powers up
> the CPU and SOC and the CPU resumes the kernel as per the Linux power
> management framework.
>
> Now I have a PCI controller which has been configured in
> "linux/arch/arm/<mach-mysoc>/pcie.c". During suspend as the PCI
> power(which is part of the SOC power domain) gets turned off, so the
> controller loses its register configurations. On resume, the pci
> driver's resume functions get called and the system hangs up(when it
> tries to read/write to pci configuration space).
>
> As per my understanding, the pci driver has implementation of bus/
> device power management. It does not reconfigure the pci controller.
> So how should I make the pci controller work fine on system resume.
> Is it so that I need to reconfigure the pcie controller's registers
> (as it has been done in "linux/arch/arm/<mach-mysoc>/pcie.c") from the
> resume function of pci driver. Or would that compromise the entire
> linux pm framework.

AFAIR, you need to do a save/restore of registers for all peripherals
you care about from the suspend/resume callbacks..

There must be many examples of this, like: drivers/gpio/gpio-pl061.c

I was involved in doing this long back and am not aware of latest
happenings around this.

People cc'd must be able to tell you better answers probably :)
