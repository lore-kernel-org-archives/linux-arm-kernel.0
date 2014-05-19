From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 May 2014 13:22:13 +0100
Subject: [PATCH 0/9] arm64: KVM: debug infrastructure support
In-Reply-To: <CALrVBktviU6qs_N3AoRd0=BKEVRar65FBca8uQLkzZiuetNkVg@mail.gmail.com>
 (Anup Patel's message of "Mon, 19 May 2014 10:35:58 +0100")
References: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
 <CALrVBkscsWxRsS42eJi9deFeaBbjQMKq9R2e-u5ztu70rKUvUw@mail.gmail.com>
 <87d2fanmm7.fsf@approximate.cambridge.arm.com>
 <CALrVBktviU6qs_N3AoRd0=BKEVRar65FBca8uQLkzZiuetNkVg@mail.gmail.com>
Message-ID: <87tx8m3qmi.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19 2014 at 10:35:58 am BST, Anup Patel <anup.patel@linaro.org> wrote:
> On 19 May 2014 14:58, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Mon, May 19 2014 at 10:05:42 am BST, Anup Patel
>> <anup.patel@linaro.org> wrote
>>
>> Hi Anup,
>>
>>> Overall the patchset looks good to me.
>>>
>>> The debug register usage by Guest will be very rare
>>> so a lazy save/restore makes lot-of-sense here.
>>>
>>> The only concern here is that amount of time spend in
>>> world-switch will increase for Guest once Guest starts
>>> accessing debug registers.
>>>
>>> I was wondering if it is possible to detect that Guest
>>> has stopped using debug HW and we can mark debug
>>> state as clean. (or something similar)
>>
>> If you look carefully at patch #8 (last hunk of the patch), you'll see
>> that I always reset the debug state to "clean" at the end of a guest
>> run:
>>
>> @@ -609,6 +1040,12 @@ __kvm_vcpu_return:
>>
>>         bl __restore_sysregs
>>         bl __restore_fpsimd
>> +
>> +       skip_clean_debug_state x3, 1f
>> +       // Clear the dirty flag for the next run
>> +       str     xzr, [x0, #VCPU_DEBUG_FLAGS]
>> +       bl      __restore_debug
>> +1:
>>         restore_host_regs
>>
>>         mov     x0, x1
>>
>> This ensures that the guest's debug state will only be reloaded if:
>>
>> - MDSCR_EL1 has either MDE or KDE set (which means the guest is actively
>> using the debug infrastructure)
>> - or the guest has written to a trapped register (which marks the state
>> as dirty).
>
> Thanks for pointing out.
>
> Can you add this info as comment in patch#8 where you
> clear the dirty flag?

Right. There is already some comments to that effect just above, where
we compute the dirty state, but I think it doesn't hurt to repeat it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
