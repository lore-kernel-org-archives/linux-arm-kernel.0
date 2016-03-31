From: labbott@redhat.com (Laura Abbott)
Date: Thu, 31 Mar 2016 15:53:26 -0700
Subject: Issue with ioremap
In-Reply-To: <20160331200147.GA20530@jcartwri.amer.corp.natinst.com>
References: <CAGnW=BYw9iqm8BpuWrxgcvXV3wwvHcvMtynPeHUGHHiZfPmfuA@mail.gmail.com>
 <20160331200147.GA20530@jcartwri.amer.corp.natinst.com>
Message-ID: <56FDAA66.2000505@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(cc linux-arm)

On 03/31/2016 01:01 PM, Josh Cartwright wrote:
> On Fri, Apr 01, 2016 at 01:13:06AM +0530, punnaiah choudary kalluri wrote:
>> Hi,
>>
>> We are using the pl353 smc controller for interfacing the nand in our zynq SOC.
>> The driver for this controller is currently under mainline review.
>> Recently we are moved to 4.4 kernel and observing issues with the driver.
>> while debug, found that the issue is with the virtual address returned from
>> the ioremap is not aligned to the physical address and causing nand
>> access failures.
>> the nand controller physical address starts at 0xE1000000 and the size is 16MB.
>> the ioremap function in 4.3 kernel returns the virtual address that is
>> aligned to the size
>> but not the case in 4.4 kernel.
>
> :(.  I had actually ran into this, too, as I was evaluating the use of
> the upstream-targetted pl353 stuff; sorry I didn't say anything.
>
>> this controller uses the bits [31:24] as base address and use rest all
>> bits for configuring adders cycles, chip select information. so it
>> expects the virtual address also aligned to 0xFF000000 otherwise the
>> nand commands issued will fail.
>
> The driver _currently_ expects the virtual address to be 16M aligned,
> but is that a hard requirement?  It seems possible that the driver could
> be written without this assumption, correct?
>
> This would mean that the driver would need to maintain the cs/cycles
> configuration state outside of the mapped virtual address, and then
> calculate + add the calculated offset to the base.  Would that work?
> I had been meaning to give it a try, but haven't gotten around to it.
>
>    Josh
>

I was curious so I took a look and this seems to be caused by

commit 803e3dbcb4cf80c898faccf01875f6ff6e5e76fd
Author: Sergey Dyasly <dserrg@gmail.com>
Date:   Wed Sep 9 16:27:18 2015 +0100

     ARM: 8430/1: use default ioremap alignment for SMP or LPAE
     
     16MB alignment for ioremap mappings was added by commit a069c896d0d6 ("[ARM]
     3705/1: add supersection support to ioremap()") in order to support supersection
     mappings. But __arm_ioremap_pfn_caller uses section and supersection mappings
     only in !SMP && !LPAE case. There is no need for such big alignment if either
     SMP or LPAE is enabled.
     
     After this change, ioremap will use default maximum alignment of 128 pages.
     
     Link: https://lkml.kernel.org/g/1419328813-2211-1-git-send-email-d.safonov at partner.samsung.com
     
     Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
     Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
     Cc: James Bottomley <JBottomley@parallels.com>
     Cc: Will Deacon <will.deacon@arm.com>
     Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
     Cc: Catalin Marinas <catalin.marinas@arm.com>
     Cc: Andrew Morton <akpm@linux-foundation.org>
     Cc: Dmitry Safonov <d.safonov@partner.samsung.com>
     Signed-off-by: Sergey Dyasly <s.dyasly@samsung.com>
     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The thread assumed the higher alignment behavior was only needed for super
section mappings. Apparently not.

Thanks,
Laura
