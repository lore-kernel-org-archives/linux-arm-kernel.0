From: jcm@redhat.com (Jon Masters)
Date: Wed, 21 Jan 2015 10:29:52 -0500
Subject: [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
 and pass acpi=force to enable ACPI
In-Reply-To: <20150121152326.GD6358@e104818-lin.cambridge.arm.com>
References: <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <20150119114255.GF11835@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8vPKAdsNg7QC7xW+i8_BemWEx4mvBx6NrnAHi8Y+bNtw@mail.gmail.com>
 <20150119135144.GI11835@e104818-lin.cambridge.arm.com>
 <20150119151350.21B65C40948@trevor.secretlab.ca>
 <54BD3803.6020307@redhat.com>
 <20150119175233.GK11835@e104818-lin.cambridge.arm.com>
 <20150119180122.GJ21553@leverpostej> <54BE1FEA.5040109@linaro.org>
 <alpine.DEB.2.02.1501201901190.12653@kaball.uk.xensource.com>
 <20150121152326.GD6358@e104818-lin.cambridge.arm.com>
Message-ID: <54BFC5F0.3020500@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2015 10:23 AM, Catalin Marinas wrote:

> I have some questions for the ACPI and EFI folk:
> 
> 1. When booting with ACPI, are the EFI run-time services required for
>    anything? If yes, Xen may have a bigger problem

Yes. At least for some things. For example, installing an Operating
System would require that you make runtime services calls to set the
BootOrder/BootNext variables, and so on. Further, we use the GetTime
service and EFI based reboot to avoid having special drivers. I had
those added to SBBR as requirements for that reason.

> 2. Could a boot loader (either kernel doing kexec or Xen) emulate the
>    EFI system/config tables and still make them useful to the kernel but
>    without EFI_BOOT or EFI_RUNTIME_SERVICES?

Yes. But again, without the other required pieces (including the
services function pointers in the systab which are required) you'd crash
soon after boot trying to make those calls. We saw this with e.g. RTC in
early firmwares. One of the reasons we've been hitting every service and
establishing a reliance upon them immediately is to allow third party
EFI vendors to notice when they've got any firmware bugs.

Jon.
