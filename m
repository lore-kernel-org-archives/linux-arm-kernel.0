From: robdclark@gmail.com (Rob Clark)
Date: Fri, 12 Aug 2016 10:32:29 -0400
Subject: [PATCH V6 0/6] iommu/msm: Add DT adaptation and generic bindings
 support
In-Reply-To: <000501d1f4a0$325f0dd0$971d2970$@codeaurora.org>
References: <1465817767-9856-1-git-send-email-sricharan@codeaurora.org>
 <CAF6AEGsF5M1sfwaXKW0x=Mu=nQJR-9+xqrtXd=7Vz_+6G_u25A@mail.gmail.com>
 <CAF6AEGsLGDqRuB97+qN1g7X60A49Wv1HGbAiaeZoxogMmHY9HA@mail.gmail.com>
 <003a01d1f467$2b180ba0$814822e0$@codeaurora.org>
 <CAF6AEGsRVULNpSe_s460biNhV0dRaKLv6tf2Y244HEjGVOV3bw@mail.gmail.com>
 <000001d1f499$fe2caf50$fa860df0$@codeaurora.org>
 <CAF6AEGuitSWt9dhXrMfBDqAkXzpZObuj6A_8XxL+TVSWnbkwaQ@mail.gmail.com>
 <000501d1f4a0$325f0dd0$971d2970$@codeaurora.org>
Message-ID: <CAF6AEGuagnVu_cxkHB4vjBT_=XSpHyWAkKdB8=++z-FBnvMB3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 9:48 AM, Sricharan <sricharan@codeaurora.org> wrote:
> Hi,
>
>>>>>>> btw, the current state, at least on linaro integration branch, fault
>>>>>>> handling doesn't work so well (ie. device never gets resumed).. which
>>>>>>> is a bit unfortunate for a gpu (and results in a *lot* of rebooting on
>>>>>>> my part when debugging userspace).  I haven't had time yet to compare
>>>>>>> to the ancient downstream driver, but not sure if you have any ideas?
>>>>>>>
>>>>>>> I guess probably disabling stall on fault would help.  But I'm not
>>>>>>> even getting the "Fault occurred in context.." prints.  Seeing the
>>>>>>> fault iova is pretty useful since that plus gpu cmdstream trace helps
>>>>>>> me figure out which texture/etc is being accessed out of bounds.
>>>>>>
>>>>>>fyi, it looks like it is not getting any fault irq..  it's *possible*
>>>>>>that I screwed up the irq #'s when translating from downstream, so you
>>>>>>might want to double check that.  I thought I had it right, I assume I
>>>>>>would have noticed during piglit runs if fault recovery wasn't working
>>>>>>(since the result is that *everything* after the faulting test would
>>>>>>have failed since gpu is wedged with no access to memory), but it was
>>>>>>long enough ago that I can't claim that definitively.
>>>>>>
>>>>>>If you need an easy way to trigger a gpu fault, msmtest is a good way,
>>>>>>change this line:
>>>>>>
>>>>>>  https://github.com/freedreno/msmtest/blob/master/msmtest.c#L247
>>>>>>
>>>>>>from OUT_RELOC() to OUT_RING(ring, 0x00000000) will trigger a fault.
>>>>>>
>>>>>    So for the irq to be triggered, 'non-secure' irq line has to be
>>>>>   populated in DT. There is a 'secure'and 'non-secure' irq lines for these iommus
>>>>>   and  non-secure irq number is secure + 1. I tested this by having a 'return 0'
>>>>>  from the msm_iommu_map (no mapping), and the faults were getting triggered.
>>>>>
>>>>>   Can you share me your dts data ?
>>>>>
>>>>
>>>>I think this is what you want:
>>>>
>>>>https://github.com/freedreno/kernel-msm/blob/integration-linux-qcomlt/arch/arm/boot/dts/qcom-apq8064.dtsi#L2008
>>>>
>>>>I haven't tested a display fault, so I suppose it is possible that
>>>>irq's are working for some iommu instances but not others?
>>>
>>> So in your DT, for gfx3d, the non-secure line is '70' and not '69' (This is secure) .
>>>  Infact only '70' should be populated. The driver sets the irq line based on resource 0.
>>>  This applies for all iommu nodes in your DT. (only the second irq line is needed).
>>
>>ahh, that would explain.
>>
>>Is it better to remove the extra entry, or should I just swap them
>>all?  Ie. might there be some point in the future where the driver
>>would want both?
>     I feel better to have one. Not sure why the secure irq was added in first
>     place in the downstream data and it would setup/handled by the TZ

Ok, getting further.. still seems like the gpu is not getting resumed,
but at least we are getting a fault interrupt..

BR,
-R
