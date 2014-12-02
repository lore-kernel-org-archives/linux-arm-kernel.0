From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 2 Dec 2014 15:42:20 +0000
Subject: [PATCH 5/5] arm/arm64: KVM: Turn off vcpus and flush stage-2
 pgtables on sytem exit events
In-Reply-To: <20141202150112.GJ545@cbox>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
 <1417113660-23610-6-git-send-email-christoffer.dall@linaro.org>
 <CAFEAcA9hRvaWZiXOjTQP3+4B+r7h7W7oqRm6y=cxw+EJKNk-0w@mail.gmail.com>
 <20141202150112.GJ545@cbox>
Message-ID: <CAFEAcA9kvKejc==0s5Xm7owo59v7+5vEEjU=9FTHBnX9rMnJ2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2014 at 15:01, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Nov 27, 2014 at 11:10:14PM +0000, Peter Maydell wrote:
>> Also, the clarification we want here should not I think be architecture
>> specific -- the handling of the exit system event in QEMU is in common
>> code. What you want to say is something like:
>>
>> "Valid values for 'type' are:
>>   KVM_SYSTEM_EVENT_SHUTDOWN -- the guest has requested a shutdown of the
>>    VM. Userspace is not obliged to honour this, and if it does honour
>>    this does not need to destroy the VM synchronously (ie it may call
>>    KVM_RUN again before shutdown finally occurs).
>>   KVM_SYSTEM_EVENT_RESET -- the guest has requested a reset of the VM.
>>    As with SHUTDOWN, userspace is permitted to ignore the request, or
>>    to schedule the reset to occur in the future and may call KVM_RUN again."
>
> ok, this is pretty good, but do we need to say that userspace is
> permitted to do this or that?  The kernel never relies on user space for
> correct functionality, so do you mean 'for the run a vm semantics to
> still otherwise be functional'?

I meant "permitted" in the sense of "the kernel won't kill the VM,
return errnos to subsequent KVM_RUN requests or otherwise treat
this userspace behaviour as buggy". If you want to rephrase it
somehow I don't object, as long as the docs make it clear that
it's a valid implementation strategy for userspace to do that.

-- PMM
