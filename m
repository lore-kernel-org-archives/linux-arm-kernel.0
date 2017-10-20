From: dvyukov@google.com (Dmitry Vyukov)
Date: Fri, 20 Oct 2017 17:14:55 +0200
Subject: v4.14-rc3/arm64 DABT exception in atomic_inc() / __skb_clone()
In-Reply-To: <960D71EC-C1E9-4898-ACBE-543FC09483FF@gmail.com>
References: <EAA60182-6F08-412E-8F8B-FD4B0309A858@gmail.com>
 <20171020111408.edj24tztxdptte5r@lakrids.cambridge.arm.com>
 <960D71EC-C1E9-4898-ACBE-543FC09483FF@gmail.com>
Message-ID: <CACT4Y+bjzzCv3LSxK12C1xB8GfR3UYCrX_5phRYJ8fpxh9vcvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 4:40 PM, Wei Wei <dotweiba@gmail.com> wrote:
> Sadly, the syzkaller characterized it as a non-reproducible bug and there were empty
>  repro files. But if manually executing in VM like this ?./syz-execprog -executor=
> ./syz-executor -repeat=0 -procs=16 -cover=0 crash-log?, it crashed when executing exactly
> program 1056 using log0 provided.
>
> I failed to generate the C reproducer with syz-repro as it said ?no target compiler?
> in the final step. I would appreciate if you could give some hints.

syzkaller tries to use aarch64-linux-gnu-gcc when cross-compiling to arm64:
https://github.com/google/syzkaller/blob/master/sys/targets/targets.go#L62
Try to install g++-aarch64-linux-gnu.
Or how should it be done on your system?


> Thanks,
> Wei
>> On 20 Oct 2017, at 7:14 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Thu, Oct 19, 2017 at 10:16:08PM -0400, Wei Wei wrote:
>>> Hi all,
>>
>> Hi,
>>
>>> I have fuzzed v4.14-rc3 using syzkaller and found a bug similar to that one [1].
>>> But the call trace isn?t the same. The atomic_inc() might handle a corrupted
>>> skb_buff.
>>>
>>> The logs and config have been uploaded to my github repo [2].
>>>
>>> [1] https://lkml.org/lkml/2017/10/2/216
>>> [2] https://github.com/dotweiba/skb_clone_atomic_inc_bug
>>
>> These do look very similar to what I was hitting; all appear to be
>> misaligned atomics in the same path.
>>
>> I see that you have some empty repro files in [2]. If you have any
>> reproducers, would you mind sharing them?
>>
>> If any of those are smaller or more reliable than the one I was able to
>> generate [3], it might make it more obvious what's going on, and/or make
>> it simpler to come up with a plain C reproducer.
>>
>> Thanks,
>> Mark.
>>
>> [3] https://www.kernel.org/pub/linux/kernel/people/mark/bugs/20171002-skb_clone-misaligned-atomic/syzkaller.repro
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
