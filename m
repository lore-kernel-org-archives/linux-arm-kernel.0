From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 May 2014 13:59:54 +0100
Subject: [PATCH 0/9] arm64: KVM: debug infrastructure support
In-Reply-To: <CAFEAcA9K0fu+B-j0sN7OaWPzkT+0hYCxu3JLwDKT3qYob4h1PA@mail.gmail.com>
 (Peter Maydell's message of "Mon, 19 May 2014 13:32:28 +0100")
References: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
 <CALrVBkscsWxRsS42eJi9deFeaBbjQMKq9R2e-u5ztu70rKUvUw@mail.gmail.com>
 <87d2fanmm7.fsf@approximate.cambridge.arm.com>
 <CAFEAcA9K0fu+B-j0sN7OaWPzkT+0hYCxu3JLwDKT3qYob4h1PA@mail.gmail.com>
Message-ID: <87iop153g5.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19 2014 at  1:32:28 pm BST, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 May 2014 10:28, Marc Zyngier <marc.zyngier@arm.com> wrote:
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
> Do we also handle the case where the guest didn't write to the trapped
> register but userspace did (via the SET_ONE_REG API)? Maybe this just
> falls out in the wash or is handled already...

This is pretty much handled by the same code:

- Userspace wrote to any register but MDSCR_EL1, and MDSCR_EL1 doesn't
have MDE/KDE set. In this case, we don't need to do anything, as the new
state is not in use yet.
- Userspace has written to MDSCR_EL1.{MDE,KDE}, and this indicates we
must restore the state.

Compared to what the guest does, we don't flag the state as dirty when
we write to any of the debug registers (only MDSCR_EL1 can be used to
enter the "dirty" state). It is not really a problem, as this is only a
perfermance optimisation (as soon as the guest starts using debug
registers, we want to disable trapping).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
