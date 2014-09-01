From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 1 Sep 2014 10:30:17 +0100
Subject: [PATCH 06/16] KVM: Add KVM_EXIT_SYSTEM_EVENT to user space API
 header
In-Reply-To: <20140901092017.GC19836@cbox>
References: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
 <1401041942-23471-7-git-send-email-christoffer.dall@linaro.org>
 <CAFEAcA-yWadPiE4v7f-C1-V71=QHYLB=fzC78xhNMnNkVSJAhg@mail.gmail.com>
 <20140901092017.GC19836@cbox>
Message-ID: <CAFEAcA_S9dHbYVDrkr7X+cTcg-TC0nRWd4zLaUTX2zBjr+TKGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 September 2014 10:20, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Fri, Aug 29, 2014 at 06:39:09PM +0100, Peter Maydell wrote:
>> Talking with Ard I realised that there's actually a hole in the
>> specification of this new ABI. Did we intend these shutdown
>> and reset exits to be:
>>  (1) requests from the guest for the shutdown/reset to be
>>    scheduled in the near future (and we'll continue to execute
>>    the guest until the shutdown actually happens)
>>  (2) requests for shutdown/reset right now, with no further
>>    guest instructions to be executed
>>
>> ?
>>
>> As currently implemented in QEMU we get behaviour (1),
>> but I think the kernel PSCI implementation assumes
>> behaviour (2). Who's right?
>>
> For the arm/arm64 use of this API (currently the only one?) the host
> would not break or anything like that if you keep executing the VM, but
> the guest will expect that no other instructions are executed after this
> call.

Well, if we do that then between QEMU and KVM we've
violated the PSCI ABI we're supposed to provide, so somebody
is wrong :-)

I guess that since the kernel already implements "assume
userspace won't resume the guest vcpu" the path of least
resistance is to make userspace follow that.

What does kvmtool do here (if it implements PSCI shutdown
and reset at all)?

thanks
-- PMM
