From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 12:45:43 +0100
Subject: [PATCH v5 00/22] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <20150930113214.GA10997@leverpostej>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
 <20150930113214.GA10997@leverpostej>
Message-ID: <560BCB67.1060100@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/15 12:32, Mark Rutland wrote:
> On Wed, Sep 30, 2015 at 11:45:15AM +0100, Julien Grall wrote:
>> Hi all,
> 
> Hi,
> 
>> ARM64 Linux is supporting both 4KB and 64KB page granularity. Although, Xen
>> hypercall interface and PV protocol are always based on 4KB page granularity.
>>
>> Any attempt to boot a Linux guest with 64KB pages enabled will result to a
>> guest crash.
>>
>> This series is a first attempt to allow those Linux running with the current
>> hypercall interface and PV protocol.
>>
>> This solution has been chosen because we want to run Linux 64KB in released
>> Xen ARM version or/and platform using an old version of Linux DOM0.
> 
> Just to check, would this be expected to work with a 16K DomU (e.g.
> [2])?
> 
> From a quick scan it looks like the relaxations provided by this series
> should work so long as PAGE_SIZE % XEN_PAGE_SIZE == 0, assuming I
> haven't missed something.

Correct, this series is able to cope with any PAGE_SIZE as long as it's
a multiple of the granularity used by Xen (i.e 4KB on ARM).

>> There is room for improvement, such as support of 64KB grant, modification
>> of PV protocol to support different page size... They will be explored in a
>> separate patch series later.
>>
>> TODO list:
>>     - Convert xenfb to 64KB
>>     - Support for multiple page ring support
>>     - Support for 64KB in gnttdev
>>     - Support of non-indirect grant with 64KB frontend (patch sent [1])
>>     - It may be possible to move some common define between
>>     netback/netfront and blkfront/blkback in an header
> 
> Would any of these require more work to also handle 16K?

No. It should just boot on Xen as long as the CPU is support 16K
granularity.

Regards,

-- 
Julien Grall
