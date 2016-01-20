From: dyoung@redhat.com (Dave Young)
Date: Wed, 20 Jan 2016 16:26:17 +0800
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <569F3EC2.4020807@linaro.org>
References: <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org>
 <20160120063856.GA3725@dhcp-128-65.nay.redhat.com>
 <20160120070044.GF2999@dhcp-128-65.nay.redhat.com>
 <569F3EC2.4020807@linaro.org>
Message-ID: <20160120082617.GJ2999@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/16 at 05:01pm, AKASHI Takahiro wrote:
> On 01/20/2016 04:00 PM, Dave Young wrote:
> >>>So I'm not still sure about what are advantages of a property under /chosen
> >>>over "memmap=" kernel parameter.
> >>>Both are simple and can have the same effect with minimizing changes to dtb.
> >>>(But if, in the latter case, we have to provide *all* the memory-related information
> >>>through "memmap=" parameters, it would be much complicated.)
> >>
> >>Maybe I did not say it clearly, I prefer kexec syscall/tool to modifiy dtb
> >>or uefi-memmap so that we do not need any extra kernel cmdline.
> 
> Yes, I understand.
> But on arm64, kexec-tools can generate a "memmap=" parameter for crash kernel's
> memory region without any user's interaction.
> (please note that this parameter eventually goes into dtb's cmdline property in
> /chosen.)
> 
> In this sense, it is no different from an extra property under /chosen
> as kexec-tools can also add it to dtb passed to the crash dump kernel.
> 
> (See what I mean?)

I think I understand your points, what I would prefer is not an extra property
but modifying uefi memmap or recreating memory nodes for !EFI to be used in kdump kernel.

> 
> >>For x86 we would like to drop the memmap= usage in kexec-tools
> 
> I didn't know that :)
> 
> >>but we can not
> >>do that for a compatibility problem about calgary iommu. So that currently
> >>kexec-tools supports both recreating E820 maps and passing memmap=.
> >>
> >>We should think it carefully because it will be hard to remove once we support it.
> 
> Absolutely.
> 
> >>IMO handling it in code is better than using an external interface.
> >
> >Also seems semantic of memmap=exactmap is different than current use in the implementation
> >exactmap means we need pass each range seperately including reserved, acpi and other types
> >We can not reuse ranges in uefi memmap for other than usable memory.
> 
> 
> If necessary, we may use a different name, say, "usablememmap=" for arm64
> or just extend "mem=" semantics (allowing XX at YY format) to avoid any confusion.

For either of above what is the 1st kernel behavior with these params?

> 
> Thanks,
> -Takahiro AKASHI
> 
> >It will also have the cmdline array size issue.k
> >
> >Thanks
> >Dave
> >
