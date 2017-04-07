From: jeffy.chen@rock-chips.com (jeffy)
Date: Fri, 07 Apr 2017 14:44:05 +0800
Subject: [PATCH v3 8/9] drm/rockchip: gem: Don't alloc/free gem buf when
 dev_private is invalid
In-Reply-To: <CAKMK7uEjyBwJKmZUnXZLZ_YzgajFMKNem-2Eoc80ZDXha-7o6g@mail.gmail.com>
References: <1491380967-28570-1-git-send-email-jeffy.chen@rock-chips.com>
 <1491380967-28570-9-git-send-email-jeffy.chen@rock-chips.com>
 <20170405162839.k6q4b3tpt6t2s3zm@art_vandelay>
 <20170406082612.qmwyfjr5uwcp3arr@phenom.ffwll.local>
 <58E621D7.3030205@rock-chips.com>
 <CAKMK7uEjyBwJKmZUnXZLZ_YzgajFMKNem-2Eoc80ZDXha-7o6g@mail.gmail.com>
Message-ID: <58E73535.4000409@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 04/07/2017 02:30 PM, Daniel Vetter wrote:
> On Thu, Apr 6, 2017 at 1:09 PM, jeffy <jeffy.chen@rock-chips.com> wrote:
>>
>> On 04/06/2017 04:26 PM, Daniel Vetter wrote:
>>>
>>> On Wed, Apr 05, 2017 at 12:28:40PM -0400, Sean Paul wrote:
>>>>
>>>> On Wed, Apr 05, 2017 at 04:29:26PM +0800, Jeffy Chen wrote:
>>>>>
>>>>> After unbinding drm, the userspace may still has a chance to access
>>>>> gem buf.
>>>>>
>>>>> Add a sanity check for a NULL dev_private to prevent that from
>>>>> happening.
>>>>
>>>>
>>>> I still don't understand how this is happening. You're saying that these
>>>> hooks
>>>> can be called after rockchip_drm_unbind() has finished?
>>>
>>>
>>> Yeah this is supposed to be impossible. If it isn't, we need to debug and
>>> fix this properly. This smells like pretty bad duct-tape ...
>>
>>
>> it looks like after unbind, the user space may still own drm dev fd, and
>> could be able to call ioctl:
>> lrwx------. 1 chronos chronos 64 Mar 15 12:53 28 -> /dev/dri/card1 (deleted)
>>
>> and the drm_unplug_dev may help it, maybe we should call it in unbind? or
>> just break drm_ioctl when drm_dev not registered?
>
> Yes, by default unbind while userspace is running is totally broken in
> drm. drm_unplug_dev would be the fix, but it's only used by udl and
> not many use that. You might need to fix infrastructure up a bit.
please check this patch:
9667071 New          [v5,12/12] drm/drm_ioctl.c: Break ioctl when drm 
device not registered
>
> For normal module unload the module reference will prevent unloading.
> So why exactly do you care about the unbind use-case?
sometimes we use unbind/bind for testing ;)
> -Daniel
>
