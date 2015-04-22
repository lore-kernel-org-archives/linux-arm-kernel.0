From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 22 Apr 2015 10:46:47 +0100
Subject: [PATCH v2 06/10] KVM: arm64: guest debug,
 add SW break point support
In-Reply-To: <CADt_bzh=zhSmoQnKxp5cUski3S=riYG5AnmCsm=qeTSjm=cprA@mail.gmail.com>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-7-git-send-email-alex.bennee@linaro.org>
 <CADt_bzh=zhSmoQnKxp5cUski3S=riYG5AnmCsm=qeTSjm=cprA@mail.gmail.com>
Message-ID: <87383s7awo.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Zhichao Huang <zhichao.huang@linaro.org> writes:

> On Tue, Mar 31, 2015 at 04:08:04PM +0100, Alex Benn?e wrote:
>> This adds support for SW breakpoints inserted by userspace.
>>
>> We do this by trapping all BKPT exceptions in the
>> hypervisor (MDCR_EL2_TDE).
>
> why should we trap all debug exceptions?
>
> The trap for cp14 register r/w seems enough to record relevant
> informations to context switch the dbg register while neccessary.

Lets think about this case when the SW breakpoint exception occurs:

If KVM doesn't trap it and pass it back to userspace to handle it would
have to deliver it to the guest. The guest not having inserted the
breakpoint in the first place would get very confused.

So what we actually do is re-route the exception to the hypervisor and
stop the VM and return to userspace with the debug information. Once in
QEMU we check to see if the SW breakpoint was one of the ones we
inserted at which point control is passed back to the host GDB (attached
via the GDB stub in QEMU). If it is not a breakpoint which was set-up by
the host then it must be one for the guest at which point we need to
ensure the exception is delivered to the guest for it to process.

-- 
Alex Benn?e
