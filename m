From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Wed, 19 Feb 2014 11:59:59 +0000
Subject: BUG: Null pointer dereference on booting TC2 with
 vexpress_defconfig
In-Reply-To: <20140218213232.GD2084@cbox>
References: <20140217223907.GH21070@cbox> <53033E37.6000402@arm.com>
 <CAMJs5B-G86o8Tjcwg+dvDETqQ5qiDsDFB9kBPtL=RBLqFqpAOQ@mail.gmail.com>
 <5303916B.5060303@arm.com> <20140218213232.GD2084@cbox>
Message-ID: <53049CBF.5080602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/02/14 21:32, Christoffer Dall wrote:
> On Tue, Feb 18, 2014 at 04:59:23PM +0000, Sudeep Holla wrote:
>> On 18/02/14 16:33, Christoffer Dall wrote:
>>> On 18 February 2014 03:04, Sudeep Holla <Sudeep.Holla@arm.com> wrote:
>>>> On 17/02/14 22:39, Christoffer Dall wrote:
>>>>> Booting my TC2 using 3.14-rc3 and vexpress_defconfig causes a NULL
>>>>> pointer dereference in schedule_work_on.
>>>>>
>>>>> A quick look at the trace indicates that schedule_work() is called
>>>>> before system_wq is initialized.
>>>>>
>>>>> Further, a bisect seems to indicate that this call path is triggered by
>>>>> the changes in this merge commit of Theodore T'so's random_for_linus
>>>>> tag:
>>>>> 0891ad829d2a0501053703df66029e843e3b8365
>>>>>
>>>>> (However, my bisect may not be 100% correct, as some of the commits
>>>>> between 3.13 and 3.12 don't boot the TC2 with vexpress_defconfig,
>>>>> specifically the ones after f9300eaaac1ca300083ad41937923a90cc3a2394,
>>>>> which causes boot to halt after "ARM CCI driver probed").
>>>>>
>>>> Yes that requires some changes in defconfig to continue to work across
>>>> these changes(mainly have all these new configs disabled)
>>>>
>>>
>>> So vexpress_defconfig is known to not work on TC2?
>>>
>>
>> I would say yes before v3.13 for TC2 at-least. Pawel's commit: 81d6e719d1f8(
>> ARM: vexpress: Enable platform-specific options in defconfig) enabled several VE
>> specific features.
>>
>>>>> Disabling CONFIG_ARCH_VEXPRESS_TC2_PM avoids the issue.
>>>>>
>>>> Are you just disabling this or even CONFIG_MCPM ? Are the secondaries cpus
>>>> coming up ?
>>>>
>>>
>>> Disabling CONFIG_ARCH_VEXPRESS_TC2_PM allows the system to boot, but
>>> only with one CPU.
>>>
>>> Disabling CONFIG_MCPM allows SMP boot as well.
>>>
>> Yes that's what I suspected.
>>
>>>>> I'm not familiar enough with any of these code paths to quicly identify
>>>>> what the issue could be.  Apologies if I missed a previous post about
>>>>> this issue (I couldn't find anything but would be surprised if I'm the
>>>>> only one doing vexpress_defconfig on a TC2).
>>>>>
>>>> I just tried and it works fine. If CONFIG_MCPM and CONFIG_ARCH_VEXPRESS_TC2_PM,
>>>> it requires some changes in board configurations(for bootmon), I assume you have
>>>> done those changes.
>>>>
>>>
>>> What works fine? With both configs enabled?
>>>
>> Yes with the default vexpress_defconfig as is in the mainline.
>>
>>> I didn't change anything on the boot monitor side.  Can you give me a
>>> pointer to the specifics?  Was there an announcement about this
>>> somewhere that I failed to locate?
>>>
>>
>> You might be having very old firmware that doesn't support percpu mailbox and
>> hence can't enable CONFIG_MCPM. You can refer CFGREG48 in Section 3.3.2 of [1]
>> for details. You can grab the latest firmware in single step from [2] under
>> Firmware tab.
>>
>> [2] http://releases.linaro.org/14.01/openembedded/vexpress-lsk/
> 
> Thanks, unfortunately when I flash this newest firmware, I just see:
> 
> Setting DVI mode for VGA.
> Releasing Daughterboard resets.
> Switching MCC log to UART1.
> 
> And it never seems to proceed.  Any pointers to what I could be doing
> wrong?

I just tried dumping the exact contents from the git clone and it boots fine to
bootmon prompt to me.

BTW after a chat with MarcZ, got to know that you would enter linux kernel in
hyp-mode. It's broken esp. with U-boot and MCPM combination last time I checked.
So IMO it's better to revert back to !CONFIG_MCPM & !CONFIG_VEXPRESS_TC2_PM and
old firmware for now for all you KVM developments .

However the new firmware is backward compatible and should work w/o MCPM.

Regards,
Sudeep
