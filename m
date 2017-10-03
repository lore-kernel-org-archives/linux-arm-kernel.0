From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Tue, 03 Oct 2017 16:48:56 +0100
Subject: [PATCH 3/3] arm64: kvm: Fix single step for guest skipped
 instructions
In-Reply-To: <4d9fc0a2-bcf9-ca26-8646-037c2dcc6545@arm.com>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
 <1504083688-48334-4-git-send-email-julien.thierry@arm.com>
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
 <4d9fc0a2-bcf9-ca26-8646-037c2dcc6545@arm.com>
Message-ID: <874lrgz0yf.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Julien Thierry <julien.thierry@arm.com> writes:

> On 03/10/17 15:57, Alex Benn?e wrote:
>>
>> Julien Thierry <julien.thierry@arm.com> writes:
>>
>>> On 31/08/17 15:01, Christoffer Dall wrote:
<snip>
>>>>>>>>>>> On 30/08/17 19:53, Christoffer Dall wrote:
>>>>>>>>>>>> Hi Julien,
>>>>>>>>>>>>
>>>>>>>>>>>> [cc'ing Alex Benn?e here who wrote the debug code for arm64]
>>>>>>>>>>>>
<snip>
>>>>> I can try to detail the comment in kvm_arm_setup_debug when we set SPSR,
>>>>> hopefully making things clearer when seeing that part of the code.
>>>>>
>>>>
>>>> I also think we need to improve the comment in the world-switch return
>>>> path, and I'd like Alex to weigh in here before we merge this.   He's
>>>> back from holiday on Monday.
>>>>
>>>
>>> Ping Alex?
>>
>> Sorry for the delay getting back to you. I had flagged the email but
>> with holidays and conferences in the way it fell off my queue.
>>
>
> No problem, thanks for looking at it.
>
>> So to summarise as I understand things:
>>
>>   Host User Space   |      Host KVM   |   Host Hyp    |  Guest VM      |
>>
>>   Enable Debug(SS)
>>   KVM_RUN ----------->
>>                       Guest SPSR.SS set
>>                                     --> World Switch ->
>>                                                        Insn Trap to Hyp
>>                                         World Switch <-
>>                                         (SS not cleared)
>>                                     <--
>>                       Insn Emulated
>>                       pc += 4
>>                                     -->
>>                                         World Switch
>>                                         (SS still set)
>>                                                       ->
>>                                                        Insn +4 SS
>>                                                      <-
>>                                         World Switch
>>                                         (SS cleared)
>>
>>                                      <--
>>                       Guest exit (debug)
>>                    <--
>>    See SS did 2 insns?
>>
>> Do I understand the problem you are trying to fix correctly?
>
> Yes that's the issue. The debugger is not made aware of the
> emulated/skipped instruction and the hypervisor jumps back into the
> guest.
>
> Clearing SS before jumping back to the guest will simply trigger a
> debug exception as soon as we ERET from EL2 to EL1 (so we end up just
> getting back to EL2).

Why don't we just exit KVM after we've emulated the instruction if we
are under debug? After all at this point whatever needed to be done is
done and the guest debug code can get on with life.

I understand there is the problem of exiting for an MMIO emulation but
maybe that complexity should be handled by userspace ("render unto
userspace the things that are userspaces") and it can decide to lift the
step ioctl if appropriate.

I guess I should have a look at the series. Are you re-basing anytime
soon? It looks like it currently has a few minor merge conflicts with
current master.

--
Alex Benn?e
