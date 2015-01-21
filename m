From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Jan 2015 15:42:43 +0000
Subject: [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
 and pass acpi=force to enable ACPI
In-Reply-To: <54BFC5F0.3020500@redhat.com>
References: <CAKv+Gu8vPKAdsNg7QC7xW+i8_BemWEx4mvBx6NrnAHi8Y+bNtw@mail.gmail.com>
 <20150119135144.GI11835@e104818-lin.cambridge.arm.com>
 <20150119151350.21B65C40948@trevor.secretlab.ca>
 <54BD3803.6020307@redhat.com>
 <20150119175233.GK11835@e104818-lin.cambridge.arm.com>
 <20150119180122.GJ21553@leverpostej> <54BE1FEA.5040109@linaro.org>
 <alpine.DEB.2.02.1501201901190.12653@kaball.uk.xensource.com>
 <20150121152326.GD6358@e104818-lin.cambridge.arm.com>
 <54BFC5F0.3020500@redhat.com>
Message-ID: <20150121154243.GE6358@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 03:29:52PM +0000, Jon Masters wrote:
> On 01/21/2015 10:23 AM, Catalin Marinas wrote:
> > I have some questions for the ACPI and EFI folk:
> > 
> > 1. When booting with ACPI, are the EFI run-time services required for
> >    anything? If yes, Xen may have a bigger problem
> 
> Yes. At least for some things. For example, installing an Operating
> System would require that you make runtime services calls to set the
> BootOrder/BootNext variables, and so on. Further, we use the GetTime
> service and EFI based reboot to avoid having special drivers. I had
> those added to SBBR as requirements for that reason.

So what would a kexec'ed kernel do here? Or we usually expect it to be
short lived and doesn't need reboot, nor GetTime.

Xen is slightly more problematic but I wonder whether it could run a
(paravirtualised) UEFI.

> > 2. Could a boot loader (either kernel doing kexec or Xen) emulate the
> >    EFI system/config tables and still make them useful to the kernel but
> >    without EFI_BOOT or EFI_RUNTIME_SERVICES?
> 
> Yes. But again, without the other required pieces (including the
> services function pointers in the systab which are required) you'd crash
> soon after boot trying to make those calls.

My point was whether you can still pass information like RSDP address
via EFI tables but explicitly disable runtime services so that the
kernel won't try to make such calls (and crash).

-- 
Catalin
