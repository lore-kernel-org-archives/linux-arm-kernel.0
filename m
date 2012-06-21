From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 21 Jun 2012 11:01:21 +0800
Subject: [PATCH v2 0/5] mmp audio support
In-Reply-To: <87y5nrw4ko.fsf@octavius.laptop.org>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
 <87y5nrw4ko.fsf@octavius.laptop.org>
Message-ID: <CAMj5Bkh=BOBi+SeKYvE4hZsO1hWUD9OQSz-_g=a1c-Scgxfu6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 12:37 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Zhangfei,
>
> On Mon, Jun 11 2012, Zhangfei Gao wrote:
>> v1->v2:
>> modify accroingly with suggestion from Vinod and Mark
>> remove deprecated chan->private and dma.h
>> remove prep_slave_sg
>> remove module_init and move operation to probe
>> misc change
>>
>> v0->v1:
>> dmaengine -> soc-dmaengine.
>> update according to Mark's suggestion
>>
>> These patches provide mmp audio support under alsa via dmaengine
>> Support platfrom pxa688 and pxa910
>> mmp_tdma.c and mmp-pcm.c is shared for pxa688 and pxa910
>> pxa688 (mmp2) use mmp2-sspa.c
>> pxa910 directly use pxa-ssp.c
>> mmp_tdma.c is under dmaengine framework
>>
>> Verified on brownstone (pxa688) and ttc-dkb
>
> Great, we're looking into adopting this for OLPC XO-1.75 too.
>
> Could you explain how system suspend/resume should work with this
> patchset? ?You don't seem to be adding any suspend/resume handlers.
>
> Thanks,
>
> - Chris.

Chris

Some confusion about audio suspend.
We use android environment, wake lock is hold preventing system
entering suspend when audio work.
Only entering early-suspend, which close LCD etc.
If this is the case, we may not need consider suspend during audio play back.

If support suspend during audio work, some modification required.
I found SNDRV_PCM_TRIGGER_START/STOP is send in suspend/resume
instead of SNDRV_PCM_TRIGGER_RESUME/SUSPEND as before.
The result is dmaengine_pcm_prepare_and_submit will be re-called every
suspend/resume.
Unfortunately we malloc descriptor in prep function, but no function
to free at such case.

Thanks
