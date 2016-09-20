From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 20 Sep 2016 09:36:12 +0800
Subject: [PATCH 2/8] drm/rockchip: Get rid of some unnecessary code
In-Reply-To: <CAAFQd5A0M6vAbXHhUDMMXsaWND0hzWcT71HzOsSSCHa--qh0dA@mail.gmail.com>
References: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
 <1473857701-9250-3-git-send-email-tfiga@chromium.org>
 <57DDF2EE.5060807@rock-chips.com>
 <CAAFQd5A0M6vAbXHhUDMMXsaWND0hzWcT71HzOsSSCHa--qh0dA@mail.gmail.com>
Message-ID: <57E0928C.8080103@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?09?18? 12:01, Tomasz Figa wrote:
> Hi Mark,
>
> On Sun, Sep 18, 2016 at 10:50 AM, Mark yao <mark.yao@rock-chips.com> wrote:
>> On 2016?09?14? 20:54, Tomasz Figa wrote:
>>> Current code implements prepare_fb and cleanup_fb callbacks only to
>>> grab/release fb references, which is already done by atomic framework
>>> when creating/destryoing plane state. Let's remove these
>>> unused bits.
>>>
>>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>>> ---
>>>    drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 18 ------------------
>>>    1 file changed, 18 deletions(-)
>>
>> Hi Tomasz
>>
>> I think we can't get rid of the prepare_fb and cleanup_fb
> I think I have to disagree. Please see below for detailed explanation.
>
>> see the reason:
>> commit 44d0237a26395ac94160cf23f32769013b365590
>> Author: Mark Yao <mark.yao@rock-chips.com>
>> Date:   Fri Apr 29 11:37:20 2016 +0800
>>
>>      drm/rockchip: vop: fix iommu crash with async atomic
>>
>>      After async atomic_commit callback, drm_atomic_clean_old_fb will
>>      clean all old fb, but because async, the old fb may be also on
>>      the vop hardware, dma will access the old fb buffer, clean old
>>      fb will cause iommu page fault.
> I think the above is not quite right. Atomic plane state holds a
> reference to its fb and old state is not supposed to be destroyed
> until the flip completes.
>
> Indeed current rockchip_atomic_commit implementation has following
> order of calls: rockchip_atomic_wait_for_complete(),
> drm_atomic_helper_cleanup_planes(), drm_atomic_state_free(). This
> means that .cleanup_fb() is called from
> drm_atomic_helper_cleanup_planes() just before drm_atomic_state_free()
> will release references by destroying old plane states. Note that both
> are called already after rockchip_atomic_wait_for_complete(), so it
> should be already safe to free the old fbs.
>
> So the above fix doesn't really do anything, possibly just covers the
> race condition of the original wait for vblank function by delaying
> drm_atomic_state_free() a bit.
>
> Moreover, the whole series has been thoroughly tested in Chrome OS 4.4
> kernel, including async commits. (There is still a possibility some
> newer upstream changes slightly modified the semantics, but I couldn't
> find such difference. Actually one of the advantages of atomic helpers
> was to avoid manually refcounting the fbs from the driver.)
>
> Best regards,
> Tomasz
>
Hi Tomasz

You are right, plane_duplicate_state/plane_destroy_state already protect 
the old fbs.
we can get rid of prepare_fb and cleanup_fb.

-- 
?ark Yao
