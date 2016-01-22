From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 22 Jan 2016 13:50:34 +0900
Subject: [PATCH 16/19] arm64: kdump: add kdump support
In-Reply-To: <56A0E869.1020906@arm.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <c1faadcc74ca0670413396b36e2bdcc02b15bcd9.1452884156.git.geoff@infradead.org>
 <56A0E869.1020906@arm.com>
Message-ID: <56A1B51A.3000001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On 01/21/2016 11:17 PM, James Morse wrote:
> Hi!
>
> On 15/01/16 19:18, Geoff Levand wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> On crash dump kernel, all the information about primary kernel's core
>> image is available in elf core header specified by "elfcorehdr=" boot
>> parameter. reserve_elfcorehdr() will set aside the region to avoid any
>> corruption by crash dump kernel.
>>
>> Crash dump kernel will access the system memory of primary kernel via
>> copy_oldmem_page(), which reads one page by ioremap'ing it since it does
>> not reside in linear mapping on crash dump kernel.
>> Please note that we should add "mem=X[MG]" boot parameter to limit the
>> memory size and avoid the following assertion at ioremap():
>> 	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
>> 		return NULL;
>> when accessing any pages beyond the usable memories of crash dump kernel.
>>
>> We also need our own elfcorehdr_read() here since the weak definition of
>> elfcorehdr_read() utilizes copy_oldmem_page() and will hit the assertion
>> above on arm64.
>
> How does this work for a different-endian crash kernel?
>
> It looks like fs/proc/vmcore.c:parse_crash_elf64_headers() does some
> validation on the elf-headers that doesn't look like it will work if
> elfcorehdr:endian != kernel:endian.

Good point!

> Is it worth preventing this corner case by getting kexec-tools to
> prevent linux with a different endianness being loaded as a kdump kernel?

It may be, but I think that people should always check whether or not kdump
will work in their environment before puting the system in practical use.

(I know the check costs almost nothing though.)

Thanks,
-Takahiro AKASHI

>
> Thanks,
>
> James
>
>
