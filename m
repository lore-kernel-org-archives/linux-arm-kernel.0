From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 15 Apr 2013 01:54:30 -0700
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <d47697abd39a0d5d41f5ac110a40e261@localhost>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <d455f2823b9639af8d38d30f2c3234bd@localhost>
 <CAEDV+gJuFG49oQ=BEaCHcTP=nHVyX8ALw6076dR_C1s7TuyqXQ@mail.gmail.com>
 <d47697abd39a0d5d41f5ac110a40e261@localhost>
Message-ID: <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 1:43 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Mon, 15 Apr 2013 01:28:25 -0700, Christoffer Dall
> <cdall@cs.columbia.edu> wrote:
>> On Mon, Apr 15, 2013 at 12:50 AM, Marc Zyngier <marc.zyngier@arm.com>
>> wrote:
>>> On Sun, 14 Apr 2013 21:57:36 -0700, Christoffer Dall
>>> <cdall@cs.columbia.edu> wrote:
>>>> On Fri, Apr 12, 2013 at 6:24 AM, Marc Zyngier <marc.zyngier@arm.com>
>>> wrote:
>>>>> On 12/04/13 14:04, Andre Przywara wrote:
>>>>>> kvm_target_cpus() checks the compatibility of the used CPU with
>>>>>> KVM, which is currently limited to ARM Cortex-A15 cores.
>>>>>> However by calling it only once on any random CPU it assumes that
>>>>>> all cores are the same, which is not true for big.LITTLE parts.
>>>>>>
>>>>>> After doing about 40 boots on a TC-2 core tile, I found it running
>>>>>> in all but one case on one of the A7 cores (which correctly denied
>>>>>> KVM initialization). On the 39th boot however the code ran on
>>>>>> an A15, leading to a hang after returning success:
>>>>>>
>>>>>> ...
>>>>>> TCP: reno registered
>>>>>> UDP hash table entries: 512 (order: 2, 16384 bytes)
>>>>>> UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
>>>>>> NET: Registered protocol family 1
>>>>>> kvm_target_cpu() on CPU #1, part is c0f0
>>>>>>  ... (pause for a while) ...
>>>>>> INFO: rcu_sched self-detected stall on CPUINFO: rcu_sched detected
>>>>>> stalls on CPU
>>>>>> s/tasks: { 1} (detected by 0, t=6002 jiffies, g=4294966999,
>>>>>> c=4294966998, q=15)
>>>>>> Task dump for CPU 1:
>>>>>> swapper/0       R running      0     1      0 0x00000002
>>>>>>
>>>>>> So iterate over every CPU to correctly determine the capability of
>>>>>> the system to run the current KVM implementation.
>>>>>> In case a big.LITTLE configuration is the reason for denial, give
>>>>>> the user a hint how to get it running anyway (maxcpus= on the kernel
>>>>>> command line).
>>>>>>
>>>>>> Please push this still into 3.9.
>>>>>>
>>>>>> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>>>>>
>>>>> [...]
>>>>>
>>>>> Nak. The fact that one of the CPUs seem to hang is a sure sign that
>>>>> something is severely broken, and you definitely want to fix that
>>> issue,
>>>>> instead of blindly ignoring it.
>>>>>
>>>>> Additionally, it seems you're just papering over the issue. You
> should
>>>>> be able to exclude the A7 processors, but not completely deny KVM
> from
>>>>> running on the hardware.
>>>>>
>>>> Marc, I disagree with this nak. If the current kernel breaks boot on a
>>>> Big.Little system, we need to take care of that first, and the
>>>> proposed patch is a quick way to do so, and it does not stand in the
>>>> way of introducing proper Big.Little support in any way, which I'm
>>>> sure is going to open up a lot of other interesting questions.
>>>>
>>>> I'm going to take this one.
>>>
>>> That's your privilege.
>>>
>>> Now, my objections about this patch still stand:
>>> - It papers over what looks like a serious bug (CPU hanging? bah, let's
>>> not bother with that). It is an A15 hanging here by the way, not an A7.
>>
>> I missed that part. Are we even sure then that this is related to
>> running on Big.Little?
>
> The log is way to terse to tell. I asked Andre to investigate this in a
> separate email (I'm away from my TC2 for a while).
>
>>> - It forces the user to choose between 5 CPUs and KVM (while simply
>>> setting thread affinity would solve the problem this patch tries to
>>> solve).
>>
>> But this happens during boot, so thread affinity won't really be a
>> valid work around for this...
>
> Just refuse to initialize KVM on the A7s, display a warning indicating the
> *valid* CPUs, and let the user use taskset to run their KVM guest. And/or
> enforce this in the kernel when hitting vcpu initialisation (using
> sched_setaffinity).
>
>>> - It reports potentially wrong information (setting maxcpus= will
>>> probably
>>> do the wrong thing if cluster 0 is A7 based).
>>
>> ok, fair enough.
>>
>>>
>>> For these reasons, I'm still strongly opposed to this patch being
> merged.
>>> Yes, this is a quick way to hide a (much) bigger problem, but in no way
> a
>>> fix.
>>>
>>
>> I'm not claiming this to be a fix for the underlying problem, and I
>> would much rather see a proper fix. But, I also don't want kernels
>> configured with KVM to cause systems not to boot and if we can prevent
>> that from happening for now, in whichever rough possible way, I think
>> that takes priority.
>
> I agree with this. I disagree with the method.
>
>> Right now all the code is written with the inherent assumption that
>> we're running on an A15, and while I did not scrutinize if some of our
>> code can break the host if run on an A7, we should probably make sure
>> that doesn't happen until we actively support Big.Little and A7.  I
>> think relying on users not to crash their kernels by setting CPU
>> affinities is also a big mistake.
>
> KVM initialization on A7 should really already work as it is. If it
> doesn't, then it is a bug that is waiting to occur on A15. And the above
> hang may just be a sign that the problem is actually occurring already.
>
> As for the affinity, we can enforce this very easily.
>
OK, but let's not go down this road until we've verified that this is
really an issue that needs to be handled by excluding A7s.  Andre, can
you give us some more details?
