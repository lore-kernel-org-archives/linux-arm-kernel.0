From: laura@labbott.name (Laura Abbott)
Date: Thu, 22 Oct 2015 10:23:15 -0700
Subject: [RFC][PATCH 1/2] WIP: Devicetree bindings for Ion
In-Reply-To: <93351858f57ca6e1220a0007f98baa25@cloud.ncrmnt.org>
References: <vnkw8u6xts6n.fsf@codeaurora.org>
 <1444164433-9107-1-git-send-email-labbott@fedoraproject.org>
 <1444164433-9107-2-git-send-email-labbott@fedoraproject.org>
 <CAL_JsqJ+i3zC7UJ3BcdtOhdmQd8YnRC7bs3D2Ei5JD-4-C+A0g@mail.gmail.com>
 <vnkwh9lwlymo.fsf@codeaurora.org>
 <1c6ea0362f5336d9bc8acbfbd7ceae06@mail.ncrmnt.org>
 <93351858f57ca6e1220a0007f98baa25@cloud.ncrmnt.org>
Message-ID: <56291B83.6060208@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/15 3:36 AM, andrew at ncrmnt.org wrote:
> 20 ??????? 2015 ?., 19:34, "Mitchel Humpherys" <mitchelh@codeaurora.org> ???????:
>> On Tue, Oct 13 2015 at 11:14:23 AM, Andrew <andrew@ncrmnt.org> wrote:
>>
>>> On 2015-10-12 21:39, Mitchel Humpherys wrote:
>>>> On Tue, Oct 06 2015 at 05:35:41 PM, Rob Herring <robherring2@gmail.com>
>>>> wrote:
>>>>> On Tue, Oct 6, 2015 at 3:47 PM, Laura Abbott <labbott@fedoraproject.org>
>>>>> wrote:
>>>>
>>>> [...]
>>>>
>>>>>> +Example:
>>>>>> +
>>>>>> + ion {
>>>>>> + compatbile = "linux,ion";
>>>>>> + #address-cells = <1>;
>>>>>> + #size-cells = <0>;
>>>>>> +
>>>>>> + ion-system-heap {
>>>>>> + linux,ion-heap-id = <0>;
>>>>>> + linux,ion-heap-type = <ION_SYSTEM_HEAP_TYPE>;
>>>>>> + linux,ion-heap-name = "system";
>>>>>
>>>>> How does this vary across platforms? Is all of this being pushed down
>>>>> to DT, because there is no coordination of this at the kernel ABI
>>>>> level across platforms. In other words, why can't heap 0 be hardcoded
>>>>> as system heap in the driver. It seems to me any 1 of these 3
>>>>> properties could be used to derive the other 2.
>>>>
>>>> The heap-id<->heap-type mapping isn't necessarily 1:1. As Laura
>>>> indicated elsewhere on this thread, a given heap might need to be
>>>> contiguous on one platform but not on another. In that case you just
>>>> swap out the heap-type here and there's no need for userspace to change.
>>>>
>>>> The heap-name, OTOH, could be derived from the heap-id, which is what we
>>>> hackishly do here [1] and here[2].
>>>
>>> By the way, since we agreed that heap id and heap type mappings
>>> are not 1:1 - we have a problem with the current API.
>>>
>>> In userspace we currently have this:
>>>
>>> int ion_alloc(int fd, size_t len, size_t align, unsigned int heap_mask,
>>> unsigned int flags, ion_user_handle_t *handle);
>>>
>>> We do not specify here what TYPE of heap we want the allocation to come
>>> from.
>>> This may lead to very unpleasant stuff when porting from one platfrom to
>>> another.
>
> Okay, I may be totally missing some point here then.
>
>> What "unpleasant stuff" are you referring to, exactly?
>
> It's not really clear for me how (and at where - kernel or userspace)
> we should properly sort out cases when the next device the pipeline
> introduces some constraints on the buffer it can use.
>
> For instance: camera can save data into a non-contiguous buffer, but the
> image processing hardware (that may or may not be involved) expects the
> buffer to be contiguous.
>

You've just hit on one of the open problems. There isn't a good answer
right now for how that is supposed to work. Sumit was working on
cenalloc as an answer to some of that. I think we've decided that
may become more of a long term theoretical problem to solve rather
than a pressing practical problem. These days IOMMUs and the like are
much more common across the entire system so it's becoming rarer to
have a case where some hardware can have discontiguous buffers but
some cannot. This isn't to say it's not a problem that needs to be
solved, but we're focusing on other efforts of Ion right now.

In general though we're working off the assumption that the
kernel knows the constraints and if userspace is requesting memory from
a particular heap the kernel will allocate the correct memory. This
means that it's up to the kernel to set up the heaps correctly for
a particular platform (once again, an open problem).

Thanks,
Laura
