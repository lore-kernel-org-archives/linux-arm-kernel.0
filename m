From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Feb 2015 10:36:50 +0000
Subject: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <54EFE282.1090305@codeaurora.org>
 <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
Message-ID: <20150227103650.GA9011@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I'm still debugging it, but v9 on the 4.0-rc1 kernel crashes after calling
> > the UEFI boot time services exit function.  That is, this line:
> >
> > status = sys_table->boottime->exit_boot_services(handle, mmap_key);
> >
> > in allocate_new_fdt_and_exit_boot() gets called, and then soon after it
> > returns, the kernel crashes.  It's really early because the UEFI exception
> > handler is called.
> >
> > I did not have this problem with v8 patchset on 3.19.
> >
> 
> Are you not seeing this on v4.0-rc1 without the patchset applied?
> 
> Could the crash be inside the subsequent call to
> SetVirtualAddressMap() instead of inside ExitBootServices()?
> 
> If so, you have a firmware bug: Mark Rutland spotted a similar bug in
> the AMD Seattle firmware, which has been fixed in the mean time.
> It has to do with the firmware dereferencing the virtual mapping as it
> is being installed, which violates the UEFI spec.

A simple way to test is to change EFI_RT_VIRTUAL_BASE to point to the
(unmapped) high half of the address space (e.g. set it to
0xffff000000000000). If EFI is using pointers erroneously then something
should fault within SetVirtualAddressMap(), and you can catch this with
your favourite debugger.

Otherwise it's possible that the virtual address space chosen will cover
memory and/or devices in the existing idmap, and any erroneous accesses
will corrupt memory and/or cause devices to explode.

Thanks,
Mark
