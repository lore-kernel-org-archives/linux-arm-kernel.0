From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 4 Oct 2017 16:19:34 +0200
Subject: [PATCH 3/3] arm64: kvm: Fix single step for guest skipped
 instructions
In-Reply-To: <87infvxk30.fsf@linaro.org>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
 <CAMJs5B9u_s_wOoR7tyOV7t67aWmmgA6KavEWhDuDN98+z5rACg@mail.gmail.com>
 <3c249a68-45e3-a3a5-7d05-4cfc2d97713b@arm.com>
 <CAMJs5B8hYTJBxKa8Wu3Bw7EjaG4UZ56QQyVYx1E_4kJzkPhN+Q@mail.gmail.com>
 <ab00b377-c42d-d920-237f-9b30c9de5044@arm.com>
 <CAMJs5B-i4h63Hx68b6z-DxDphXieoNGJcLTfi2zLuq0CnU_S3g@mail.gmail.com>
 <3d7d2b36-da2f-04dc-611e-d7aab7666c29@arm.com>
 <CAMJs5B8F9VffM3pDQxbk-qfUmvvqdvbVOt8WZgFX2Q4Ud3eJrA@mail.gmail.com>
 <9bc5abc2-ab03-3137-82bd-e8afa62624eb@arm.com>
 <CAMJs5B9iVYGE2mODE1raHzGQ+Mz7V_kT+bJiWm0zUHfmLN1-DQ@mail.gmail.com>
 <861b4e4f-0fbe-cbc6-39ad-4660065449de@arm.com> <877ewcz3bv.fsf@linaro.org>
 <4d9fc0a2-bcf9-ca26-8646-037c2dcc6545@arm.com> <873770yz1o.fsf@linaro.org>
 <5a4f0493-6d3d-85de-fc45-030d4b03b5a8@arm.com> <871smkywgn.fsf@linaro.org>
 <db80e858-0127-af96-e09b-865893f927cb@arm.com> <87k20bxm13.fsf@linaro.org>
 <93d7d64e-e32c-0c6b-5d02-68704c1d45ba@redhat.com> <87infvxk30.fsf@linaro.org>
Message-ID: <94f821e3-feb7-d4b5-137c-84f7deb897ec@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2017 12:50, Alex Benn?e wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 04/10/2017 12:08, Alex Benn?e wrote:
>>>
>>> From 2e8fcea695a9eca67fbeb331d3104d1d9e7e337a Mon Sep 17 00:00:00 2001
>>> From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
>>> Date: Wed, 4 Oct 2017 09:49:41 +0000
>>> Subject: [PATCH] kvm: exit run loop after emulating IO when single stepping
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset=UTF-8
>>> Content-Transfer-Encoding: 8bit
>>>
>>> If single-stepping is enabled we should exit the run-loop after
>>> emulating the access. Otherwise single-stepping across emulated IO
>>> accesses may skip an instruction.
>>>
>>> This only addresses user-space emulation. Stuff done in kernel-mode
>>> should be handled there.
>>>
>>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>>> ---
>>>  accel/kvm/kvm-all.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 90c88b517d..85bcb2b0d4 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -1940,7 +1940,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>>                            run->io.direction,
>>>                            run->io.size,
>>>                            run->io.count);
>>> -            ret = 0;
>>> +            ret = cpu->singlestep_enabled ? EXCP_DEBUG : 0;
>>>              break;
>>>          case KVM_EXIT_MMIO:
>>>              DPRINTF("handle_mmio\n");
>>> @@ -1950,7 +1950,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>>                               run->mmio.data,
>>>                               run->mmio.len,
>>>                               run->mmio.is_write);
>>> -            ret = 0;
>>> +            ret = cpu->singlestep_enabled ? EXCP_DEBUG : 0;
>>>              break;
>>>          case KVM_EXIT_IRQ_WINDOW_OPEN:
>>>              DPRINTF("irq_window_open\n");
>>
>> Singlestep mode doesn't make much sense for KVM.  For TCG the purpose is
>> to build one-instruction translation blocks, but what would it mean for KVM?
> 
> It's used by the kvm_arch_handle_debug() code to verify single-stepping
> is enabled when processing debug exceptions. And also kvm_update_debug:
> 
>     if (cpu->singlestep_enabled) {
>         data.dbg.control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
>     }
> 
> We also have an aliased singlestep_enabled in our disas_context for the
> translator.

Nevermind, I was confusing cpu->singlestep_enabled with the "singlestep"
global.

Paolo
