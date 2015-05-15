From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 15 May 2015 17:16:26 +0100
Subject: [PATCH v4 10/12] KVM: arm64: guest debug,
 HW assisted debug support
In-Reply-To: <20150515152346.GB23652@leverpostej>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-11-git-send-email-alex.bennee@linaro.org>
 <20150515152346.GB23652@leverpostej>
Message-ID: <87y4kpke91.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Mark Rutland <mark.rutland@arm.com> writes:

> Hi Alex,
>
> On Fri, May 15, 2015 at 03:27:13PM +0100, Alex Benn?e wrote:
>> This adds support for userspace to control the HW debug registers for
>> guest debug. In the debug ioctl we copy the IMPDEF defined number of
>> registers into a new register set called host_debug_state. There is now
>> a new vcpu parameter called debug_ptr which selects which register set
>> is to copied into the real registers when world switch occurs.
>> 
>> I've moved some helper functions into the hw_breakpoint.h header for
>> re-use.
>> 
>> As with single step we need to tweak the guest registers to enable the
>> exceptions so we need to save and restore those bits.
>> 
>> Two new capabilities have been added to the KVM_EXTENSION ioctl to allow
>> userspace to query the number of hardware break and watch points
>> available on the host hardware.
>
> There's the unfortunate possibility that these could vary across cores
> in a big.LITTLE system (though we haven't seen that thus far). The
> kernel sanity checks should currently explode if such a case is
> encountered, but I don't know what we'd do were that to happen.

I suspect we would have to disable HW assisted breakpoints or return the
lowest common denominator if we can tell which cores we shall every be
scheduled on.

>
> This gets more fun when you consider the context-aware breakpoints are
> the highest numbered. So the set of (context-aware) breakpoints might
> not intersect across all CPUs.

I didn't see a reference to that in the ARM ARM. It seemed to imply any
breakpoint could be context aware is .BT was appropriately set and
linked to the VR.  

As it happens the gdb stub interface in QEMU is fairly limited so while
I expose the full debug registers I don't think there is currently a way
to expose any of the fancy linking/context stuff to the userspace
debugger. However I did make the ABI pass full raw values in so this
could become a possibility later without having to expand the ABI.


> I'm not sure what the best thing to do is w.r.t. exposing that to
> userspace.
>
> Thanks,
> Mark.

-- 
Alex Benn?e
