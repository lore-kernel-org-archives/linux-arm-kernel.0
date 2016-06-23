From: robh@kernel.org (Rob Herring)
Date: Thu, 23 Jun 2016 11:12:32 -0500
Subject: [PATCH] config: Add android config fragments
In-Reply-To: <CAMi1Hd3WnVFfxjNZO4N6=X8CEvGt=6D0fA6ybqZPMbMQkn32cQ@mail.gmail.com>
References: <1465403951-32454-1-git-send-email-robh@kernel.org>
 <CAMi1Hd3VDnK+yA6tXLFELCqnnrsPtPHnmov9O9MpJuBpfkcC=w@mail.gmail.com>
 <CAL_JsqJQsTX8SJY_inC9dFhNsujbzV+5kNdvHEvn-8+7u3XfyA@mail.gmail.com>
 <CAMi1Hd3WnVFfxjNZO4N6=X8CEvGt=6D0fA6ybqZPMbMQkn32cQ@mail.gmail.com>
Message-ID: <CAL_JsqJ_z9Vc9K9vVZQuEwJ2+0cEpdEArOLy-Wsn7N6Pbg-9vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2016 at 1:14 AM, Amit Pundir <amit.pundir@linaro.org> wrote:
> On 23 June 2016 at 08:50, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Jun 22, 2016 at 2:53 AM, Amit Pundir <amit.pundir@linaro.org> wrote:
>>> On 8 June 2016 at 22:09, Rob Herring <robh@kernel.org> wrote:
>>>> Copy the config fragments from the AOSP common kernel tree. It is
>>>> becoming possible to run mainline kernels with Android, but the kernel
>>>> defconfigs don't work as-is and debugging missing config options is a
>>>> pain. Adding the config fragments into the kernel tree, makes
>>>> configuring a mainline kernel as simple as:
>>>>
>>>> make ARCH=arm multi_v7_defconfig android-base.config android-recommended.config
>>>>
>>>> Cc: Amit Pundir <amit.pundir@linaro.org>
>>>> Cc: John Stultz <john.stultz@linaro.org>
>>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>> Cc: Rom Lemarchand <romlem@android.com>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>  kernel/configs/android-base.config        | 161 ++++++++++++++++++++++++++++++
>>>>  kernel/configs/android-recommended.config | 121 ++++++++++++++++++++++
>>
>> [...]
>>
>>>> +CONFIG_STAGING=y
>>>> +CONFIG_SWITCH=y
>>>
>>> Switch Class support is dropped from kernel/common/android-4.4 sometime back.
>>
>> Okay. I'm also removing these options in v2 which don't exist in
>> upstream. Any comments on them?
>>
>> IP6_NF_TARGET_REJECT_SKERR
>> IP_NF_TARGET_REJECT_SKERR
>> NETFILTER_XT_MATCH_QTAGUID
>> NETFILTER_XT_MATCH_QUOTA2
>> NETFILTER_XT_MATCH_QUOTA2_LOG
>> PPPOLAC
>> PPPOPNS
>> RESOURCE_COUNTERS
>> SECURITY_PERF_EVENTS_RESTRICT
>> USB_CONFIGFS_F_MTP
>> USB_CONFIGFS_F_PTP
>> USB_CONFIGFS_F_ACC
>> USB_CONFIGFS_F_AUDIO_SRC
>> USB_CONFIGFS_UEVENT
>> USB_OTG_WAKELOCK
>> ANDROID_TIMED_GPIO
>> ARM_KERNMEM_PERMS
>> INPUT_KEYCHORD
>> INPUT_KEYRESET
>> TABLET_USB_WACOM
>
> In my opinion we can keep the core configs (usb gadget, netfilter,
> input key et al.). They will not harm the resulting kernel config
> anyway. And we can definitely drop following configs from v2:

They don't harm it, but several that I looked at are never going
upstream. For example INPUT_KEYRESET is to be replaced by sysrq
additions from what I found (BTW, is anything missing for that?). I
think Android should carry the burden of carrying those additions
rather that upstream having the burden to remove/change them later.
Perhaps having these as a 3rd config fragment would be easiest to
carry.

>
> IP6_NF_TARGET_REJECT_SKERR
> IP_NF_TARGET_REJECT_SKERR
> RESOURCE_COUNTERS
> ANDROID_TIMED_GPIO
> ARM_KERNMEM_PERMS
> TABLET_USB_WACOM
>
>
> Also please add the following options in v2, which are present in
> android-4.4 configs but missing from v1.
>
> In android-base.config:
> CONFIG_DM_VERITY_FEC
> CONFIG_INET_DIAG_DESTROY
> CONFIG_IP_MULTICAST
> CONFIG_IP_NF_NAT
> CONFIG_QUOTA
>
> In android-recommended.config:
> CONFIG_DRAGONRISE_FF
> CONFIG_TASKSTATS
> CONFIG_TASK_DELAY_ACCT
> CONFIG_TASK_IO_ACCOUNTING
> CONFIG_TASK_XACCT

I have all these as I copied the files over again since obviously I
failed to do that correctly the first time. :)

Rob
