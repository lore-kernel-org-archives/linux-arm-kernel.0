From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 24 Nov 2016 16:10:51 +0900
Subject: [PATCH v1 & v6 1/2] PM/devfreq: add suspend frequency support
In-Reply-To: <58368C91.8030502@rock-chips.com>
References: <CGME20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
 <20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
 <58368C91.8030502@rock-chips.com>
Message-ID: <5836927B.9010205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Tobias Jakobi,

Hi Lin,

We need to discuss how to support the suspend-opp of devfreq device.
Now, there are two patch thread for suspend-opp of devfreq.

The Lin's approach modify the devfreq_suspend_device() to support suspend-opp.
The Tobias's approach[1] add new devfreq_suspend() and then call it on dpm_suspend()
when entering the suspend state.

[1] [RFC 0/4] PM / devfreq: draft for OPP suspend impl
- https://patchwork.kernel.org/patch/9443323/
- https://patchwork.kernel.org/patch/9443325/
- https://patchwork.kernel.org/patch/9443329/
- https://patchwork.kernel.org/patch/9443331/

I think we need to discuss it together.

Regards,
Chanwoo Choi

On 2016? 11? 24? 15:45, hl wrote:
> Hi MyungJoo Ham,
> 
> On 2016?11?24? 14:14, MyungJoo Ham wrote:
>> On Thu, Nov 24, 2016 at 11:18 AM, hl <hl@rock-chips.com> wrote:
>>> Hi MyungJoo Ham,
>> []
>>>> We still need to sync the all status even i call target() in
>>>> devfreq_suspend/resume_device
>>>> directly, so still need update_devfreq() other setp except
>>>> devfreq->governor->get_target_freq(devfreq, &freq);
>>> And i think it better to be governor behaviors, for userspace they may not
>>> want to change
>>> the suspend frequency like other governor, the frequency should decide by
>>> the user, if they
>>> want this function, they should like other governor to rigister a
>>> devfreq_monitor_suspend().
>>
>>> What do you think about my rev6 patch?
>> If I understand the intention correctly, this is for the stability of
>> the device due to the behavior or bootloader/SoC-initializer, which
>> has nothing to do with governors.
>>
>> Even if users are using userspace, as long as they set the custom
>> frequencies lower than the default, they have the possibility of
>> being unstable as ondemand is going to have.
>>
>>
>> To reuse the update_devfreq() code, you may do something like:
>>
>> static int _update_freq(struct devfreq *devfreq, bool is_suspending)
>> {
>>     /* original contents of update_freq with if statement with is_suspending wrapping get_target_freq */
>> }
>> int update_freq(struct devfreq *devfreq)
>> {
>> 	return _update_freq(devfreq, false);
>> }
>>
>>
>> There should be other good non-invasive methods that are not governoe-specific as well.
>>
> Thanks for your suggestion, i will update the new version soon.
>>
>> Cheers,
>> MyungJoo
>>
>>
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> -- 
> Lin Huang
> 
