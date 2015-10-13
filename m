From: andrew@ncrmnt.org (Andrew)
Date: Tue, 13 Oct 2015 11:14:23 +0300
Subject: [RFC][PATCH 1/2] WIP: Devicetree bindings for Ion
In-Reply-To: <vnkwh9lwlymo.fsf@codeaurora.org>
References: <1444164433-9107-1-git-send-email-labbott@fedoraproject.org>
 <1444164433-9107-2-git-send-email-labbott@fedoraproject.org>
 <CAL_JsqJ+i3zC7UJ3BcdtOhdmQd8YnRC7bs3D2Ei5JD-4-C+A0g@mail.gmail.com>
 <vnkwh9lwlymo.fsf@codeaurora.org>
Message-ID: <1c6ea0362f5336d9bc8acbfbd7ceae06@mail.ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-10-12 21:39, Mitchel Humpherys wrote:
> On Tue, Oct 06 2015 at 05:35:41 PM, Rob Herring <robherring2@gmail.com> 
> wrote:
>> On Tue, Oct 6, 2015 at 3:47 PM, Laura Abbott 
>> <labbott@fedoraproject.org> wrote:
> 
> [...]
> 
>>> +Example:
>>> +
>>> +       ion {
>>> +               compatbile = "linux,ion";
>>> +               #address-cells = <1>;
>>> +               #size-cells = <0>;
>>> +
>>> +               ion-system-heap {
>>> +                       linux,ion-heap-id = <0>;
>>> +                       linux,ion-heap-type = <ION_SYSTEM_HEAP_TYPE>;
>>> +                       linux,ion-heap-name = "system";
>> 
>> How does this vary across platforms? Is all of this being pushed down
>> to DT, because there is no coordination of this at the kernel ABI
>> level across platforms. In other words, why can't heap 0 be hardcoded
>> as system heap in the driver. It seems to me any 1 of these 3
>> properties could be used to derive the other 2.
> 
> The heap-id<->heap-type mapping isn't necessarily 1:1.  As Laura
> indicated elsewhere on this thread, a given heap might need to be
> contiguous on one platform but not on another.  In that case you just
> swap out the heap-type here and there's no need for userspace to 
> change.
> 
> The heap-name, OTOH, could be derived from the heap-id, which is what 
> we
> hackishly do here [1] and here[2].

By the way, since we agreed that heap id and heap type mappings
are not 1:1 - we have a problem with the current API.

In userspace we currently have this:

int ion_alloc(int fd, size_t len, size_t align, unsigned int heap_mask,
               unsigned int flags, ion_user_handle_t *handle);

We do not specify here what TYPE of heap we want the allocation to come 
from.
This may lead to very unpleasant stuff when porting from one platfrom to 
another.

But, manual heap id control is VERY neat, since it allows to cover a lot 
of
platform-specific cases, where allocating memory from certain heaps can
yield performance boost.

In other words - maybe we should specify both suitable heap types and 
heap ids?

> [1]
> https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.14/tree/drivers/staging/android/ion/msm/msm_ion.c?h=msm-3.14#n53
> [2]
> https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.14/tree/drivers/staging/android/ion/msm/msm_ion.c?h=msm-3.14#n398
> 
> 
> -Mitch

-- 
Regards,
Andrew
