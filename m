From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 22 Oct 2015 13:29:31 +0900
Subject: [PATCH 13/16] arm64: kdump: add kdump support
In-Reply-To: <20151022032534.GC11227@dhcp-129-115.nay.redhat.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <ef50b13d545f37a9fa95c5e6856e35f324798d00.1445297709.git.geoff@infradead.org>
 <20151022032534.GC11227@dhcp-129-115.nay.redhat.com>
Message-ID: <5628662B.1020605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Thank you for your comment.

On 10/22/2015 12:25 PM, Dave Young wrote:
> Hi, AKASHI,
>
> On 10/19/15 at 11:38pm, Geoff Levand wrote:
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
>
> How does kexec-tools pass usable memory ranges to kernel? using dtb?
> Passing an extra mem=X sounds odd in the design. Kdump kernel should get
> usable ranges and hanle the limit better than depending on an extern kernel
> param.

Well, regarding "depending on an external kernel param,"
- this limitation ("mem=") is compatible with arm(32) implementation although
   it is not clearly described in kernel's Documentation/kdump/kdump.txt.
- "elfcorehdr" kernel parameter is mandatory on x86 as well as on arm/arm64.
   The parameter is explicitly generated and added by kexec-tools.

Do I miss your point?

Thanks,
-Takahiro AKASHI

> Thanks
> Dave
>
