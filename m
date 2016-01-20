From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 20 Jan 2016 17:01:06 +0900
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <20160120070044.GF2999@dhcp-128-65.nay.redhat.com>
References: <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org>
 <20160120063856.GA3725@dhcp-128-65.nay.redhat.com>
 <20160120070044.GF2999@dhcp-128-65.nay.redhat.com>
Message-ID: <569F3EC2.4020807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2016 04:00 PM, Dave Young wrote:
>>> So I'm not still sure about what are advantages of a property under /chosen
>>> over "memmap=" kernel parameter.
>>> Both are simple and can have the same effect with minimizing changes to dtb.
>>> (But if, in the latter case, we have to provide *all* the memory-related information
>>> through "memmap=" parameters, it would be much complicated.)
>>
>> Maybe I did not say it clearly, I prefer kexec syscall/tool to modifiy dtb
>> or uefi-memmap so that we do not need any extra kernel cmdline.

Yes, I understand.
But on arm64, kexec-tools can generate a "memmap=" parameter for crash kernel's
memory region without any user's interaction.
(please note that this parameter eventually goes into dtb's cmdline property in
/chosen.)

In this sense, it is no different from an extra property under /chosen
as kexec-tools can also add it to dtb passed to the crash dump kernel.

(See what I mean?)

>> For x86 we would like to drop the memmap= usage in kexec-tools

I didn't know that :)

>> but we can not
>> do that for a compatibility problem about calgary iommu. So that currently
>> kexec-tools supports both recreating E820 maps and passing memmap=.
>>
>> We should think it carefully because it will be hard to remove once we support it.

Absolutely.

>> IMO handling it in code is better than using an external interface.
>
> Also seems semantic of memmap=exactmap is different than current use in the implementation
> exactmap means we need pass each range seperately including reserved, acpi and other types
> We can not reuse ranges in uefi memmap for other than usable memory.


If necessary, we may use a different name, say, "usablememmap=" for arm64
or just extend "mem=" semantics (allowing XX at YY format) to avoid any confusion.

Thanks,
-Takahiro AKASHI

> It will also have the cmdline array size issue.k
 >
> Thanks
> Dave
>
