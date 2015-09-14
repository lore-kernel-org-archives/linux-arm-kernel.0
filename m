From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 14 Sep 2015 11:40:55 +0100
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <55F68BC9.6020509@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com>
Message-ID: <55F6A437.3040403@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On 14/09/15 09:56, Roger Pau Monn? wrote:
> El 07/09/15 a les 17.33, Julien Grall ha escrit:
>> Hi all,
>>
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
>>
>> There is room for improvement, such as support of 64KB grant, modification
>> of PV protocol to support different page size... They will be explored in a
>> separate patch series later.
>>
>> TODO list:
>>     - Convert swiotlb to 64KB
>>     - Convert xenfb to 64KB
>>     - Support for multiple page ring support
>>     - Support for 64KB in gnttdev
>>     - Support of non-indirect grant with 64KB frontend
>>     - It may be possible to move some common define between
>>     netback/netfront and blkfront/blkback in an header
>>
>> I've got most of the patches for the TODO items. I'm planning to send them as
>> a follow-up as it's not a requirement for a basic guests.
>>
>> All patches has been built tested for ARM32, ARM64, x86. But I haven't tested
>> to run it on x86 as I don't have a box with Xen x86 running. I would be
>> happy if someone give a try and see possible regression for x86.
> 
> Do you have figures regarding if/how much performance penalty do the
> blkfront/blkback patches add to the traditional 4KB scenario (frontend
> and backend running on guests using 4KB pages)?

Which benchmark do you advice? Although, I don't have SSD on this
platform so it may be possible that the bottleneck will be the hard drive.

> 
> Since there's been no design document about this and the TODO list
> doesn't contain it, I would like to know which plans do we have in order
> to fix this properly.

Can you explain what kind of design document you were expecting? The
support of 64KB page granularity is pretty straight-forward and there is
not many way to do it. We have to split the page in 4KB chunk to feed
the ring.

TBH, I'm expecting a small impact to the performance. It would be hard
to get the exactly the same performance as today if we keep the helpers
to avoid the backend dealing himself with the splitting and page
granularity.

Although, if the performance impact is not acceptable, it may be
possible to optimize gnttab_foreach_grant_in_range by moving the
function inline. The current way to the loop is the fastest I've found
(I've wrote a small program to test different way) and we will need it
when different of size will be supported.

Regards,

-- 
Julien Grall
