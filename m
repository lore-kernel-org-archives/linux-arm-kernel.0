From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 2 Oct 2015 16:19:31 +0100
Subject: [Xen-devel] [PATCH v5 12/22] xen/balloon: Don't rely on the page
 granularity is the same for Xen and Linux
In-Reply-To: <560E9A19.2010301@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
 <1443609937-25278-13-git-send-email-julien.grall@citrix.com>
 <560E9004.8030604@citrix.com> <560E9551.6020105@citrix.com>
 <560E9A19.2010301@citrix.com>
Message-ID: <560EA083.2020102@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/15 15:52, Julien Grall wrote:
> On 02/10/15 15:31, Julien Grall wrote:
>> Hi David,
>>
>> On 02/10/15 15:09, David Vrabel wrote:
>>> On 30/09/15 11:45, Julien Grall wrote:
>>>> For ARM64 guests, Linux is able to support either 64K or 4K page
>>>> granularity. Although, the hypercall interface is always based on 4K
>>>> page granularity.
>>>>
>>>> With 64K page granularity, a single page will be spread over multiple
>>>> Xen frame.
>>>>
>>>> To avoid splitting the page into 4K frame, take advantage of the
>>>> extent_order field to directly allocate/free chunk of the Linux page
>>>> size.
>>>>
>>>> Note that PVMMU is only used for PV guest (which is x86) and the page
>>>> granularity is always 4KB. Some BUILD_BUG_ON has been added to ensure
>>>> that because the code has not been modified.
>>>
>>> This causes a BUG() in x86 PV guests when decreasing the reservation.
>>>
>>> Xen says:
>>>
>>> (XEN) d0v2 Error pfn 0: rd=0 od=32753 caf=8000000000000001
>>> taf=7400000000000001
>>> (XEN) memory.c:250:d0v2 Bad page free for domain 0
>>>
>>> And Linux BUGs with:
>>>
>>> [   82.032654] kernel BUG at
>>> /anfs/drall/scratch/davidvr/x86/linux/drivers/xen/balloon.c:540!
>>>
>>> Which is a non-zero return value from the decrease_reservation hypercall.
>>>
>>> The frame_list[] has been incorrectly populated.  The below patch fixes
>>> it for me.  Please test as well.
> 
> FIY, I've just tested with the patch on ARM64 and I haven't see any issue.

Thanks, I've folded it in.

Boris, can we get another test run on the for-linus-4.4 branch, please?

David
