From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 28 Jul 2016 11:01:04 +0800
Subject: [PATCH 1/3] drm: introduce share plane
In-Reply-To: <579732B2.80600@rock-chips.com>
References: <1469519194-23133-1-git-send-email-mark.yao@rock-chips.com>
 <20160726082635.GA31475@phenom.ffwll.local> <579732B2.80600@rock-chips.com>
Message-ID: <57997570.5070806@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any ideas for the share planes?

This function is important for our series of vop full design.
     The series of vop is:
     IP version    chipname
     3.1           rk3288
     3.2           rk3368
     3.4           rk3366
     3.5           rk3399 big
     3.6           rk3399 lit
     3.7           rk322x

example on rk3288:  if not support share plane, each vop only support 
four planes, but if support this function, each vop can support ten planes.

On 2016?07?26? 17:51, Mark yao wrote:
> On 2016?07?26? 16:26, Daniel Vetter wrote:
>> On Tue, Jul 26, 2016 at 03:46:32PM +0800, Mark Yao wrote:
>>> >What is share plane:
>>> >Plane hardware only be used when the display scanout run into plane 
>>> active
>>> >scanout, that means we can reuse the plane hardware resources on plane
>>> >non-active scanout.
>>> >
>>> >      --------------------------------------------------
>>> >     |  scanout                                       |
>>> >     |         ------------------                     |
>>> >     |         | parent plane   |                     |
>>> >     |         | active scanout |                     |
>>> >     |         |                |   ----------------- |
>>> >     |         ------------------   | share plane 1 | |
>>> >     |  -----------------           |active scanout | |
>>> >     |  | share plane 0 |           |               | |
>>> >     |  |active scanout |           ----------------- |
>>> >     |  |               |                             |
>>> >     |  -----------------                             |
>>> >     --------------------------------------------------
>>> >One plane hardware can be reuse for multi-planes, we assume the first
>>> >plane is parent plane, other planes share the resource with first one.
>>> >     parent plane
>>> >         |---share plane 0
>>> >         |---share plane 1
>>> >         ...
>>> >
>>> >Because resource share, There are some limit on share plane: one group
>>> >of share planes need use same zpos, can not overlap, etc.
>>> >
>>> >We assume share plane is a universal plane with some limit flags.
>>> >people who use the share plane need know the limit, should call the 
>>> ioctl
>>> >DRM_CLIENT_CAP_SHARE_PLANES, and judge the planes limit before use it.
>>> >
>>> >A group of share planes would has same shard id, so userspace can
>>> >group them, judge share plane's limit.
>>> >
>>> >Signed-off-by: Mark Yao<mark.yao@rock-chips.com>
>> This seems extremely hw specific, why exactly do we need to add a new
>> relationship on planes? What does this buy on_other_  drivers?
> Yes, now it's plane hardware specific, maybe others have same design, 
> because this design
> would save hardware resource to support multi-planes.
>
>> Imo this should be solved by virtualizing planes in the driver. Start 
>> out
>> by assigning planes, and if you can reuse one for sharing then do that,
>> otherwise allocate a new one. If there's not enough real planes, fail 
>> the
>> atomic_check.
> I think that is too complex, trying with atomic_check I think it's not 
> a good idea, userspace try planes every commit would be a heavy work.
>
> Userspace need  know all planes relationship, group them, some display 
> windows can put together, some can't,
> too many permutation and combination, I think can't just commit with try.
>
> example:
> userspace:
> windows 1: pos(0, 0)  size(1024, 100)
> windows 2: pos(0, 50) size(400, 500)
> windows 3: pos(0, 200) size(800, 300)
>
> drm plane resources:
> plane 0 and plane 1 is a group of share planes
> plane 2 is common plane.
>
> if userspace know the relationship, then they can assign windows 1 and 
> window 3 to plane0 and plane 1. that would be success.
> but if they don't know, assign window 1/2 to plane 0/1, failed, assign 
> window 2/3 to plane 0/1, failed. mostly would get failed.
>
>>
>> This seems way to hw specific to be useful as a generic concept.
>
> We want to change the drm_mode_getplane_res behavior, if userspace 
> call DRM_CLIENT_CAP_SHARE_PLANES, that means userspace know hardware 
> limit,
> then we return full planes support to userspace, if don't, just make a 
> group of share planes as one plane.
> this work is on generic place.
>
>> -Daniel
>>
>>
>


-- 
?ark Yao
