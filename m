From: myungjoo.ham@samsung.com (=?UTF-8?B?TXl1bmdKb28gSGFt?=)
Date: Thu, 24 Nov 2016 06:14:16 +0000
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MSAmIHY2IDEvMl0gUE0vZGV2ZnJlcTog?=
 =?UTF-8?B?YWRkIHN1c3BlbmQgZnJlcXVlbmN5IHN1cHBvcnQ=?=
References: <CGME20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
Message-ID: <20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 11:18 AM, hl <hl@rock-chips.com> wrote:
> Hi MyungJoo Ham,
[]
>>
>> We still need to sync the all status even i call target() in
>> devfreq_suspend/resume_device
>> directly, so still need update_devfreq() other setp except
>> devfreq->governor->get_target_freq(devfreq, &freq);
>
> And i think it better to be governor behaviors, for userspace they may not
> want to change
> the suspend frequency like other governor, the frequency should decide by
> the user, if they
> want this function, they should like other governor to rigister a
> devfreq_monitor_suspend().


> What do you think about my rev6 patch?

If I understand the intention correctly, this is for the stability of
the device due to the behavior or bootloader/SoC-initializer, which
has nothing to do with governors.

Even if users are using userspace, as long as they set the custom
frequencies lower than the default, they have the possibility of
being unstable as ondemand is going to have.


To reuse the update_devfreq() code, you may do something like:

static int _update_freq(struct devfreq *devfreq, bool is_suspending)
{
    /* original contents of update_freq with if statement with is_suspending wrapping get_target_freq */
}
int update_freq(struct devfreq *devfreq)
{
	return _update_freq(devfreq, false);
}


There should be other good non-invasive methods that are not governoe-specific as well.



Cheers,
MyungJoo
