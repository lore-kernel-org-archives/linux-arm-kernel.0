From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 May 2015 16:23:46 +0100
Subject: [PATCH v4 10/12] KVM: arm64: guest debug, HW assisted debug
 support
In-Reply-To: <1431700035-23479-11-git-send-email-alex.bennee@linaro.org>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-11-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150515152346.GB23652@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Fri, May 15, 2015 at 03:27:13PM +0100, Alex Benn?e wrote:
> This adds support for userspace to control the HW debug registers for
> guest debug. In the debug ioctl we copy the IMPDEF defined number of
> registers into a new register set called host_debug_state. There is now
> a new vcpu parameter called debug_ptr which selects which register set
> is to copied into the real registers when world switch occurs.
> 
> I've moved some helper functions into the hw_breakpoint.h header for
> re-use.
> 
> As with single step we need to tweak the guest registers to enable the
> exceptions so we need to save and restore those bits.
> 
> Two new capabilities have been added to the KVM_EXTENSION ioctl to allow
> userspace to query the number of hardware break and watch points
> available on the host hardware.

There's the unfortunate possibility that these could vary across cores
in a big.LITTLE system (though we haven't seen that thus far). The
kernel sanity checks should currently explode if such a case is
encountered, but I don't know what we'd do were that to happen.

This gets more fun when you consider the context-aware breakpoints are
the highest numbered. So the set of (context-aware) breakpoints might
not intersect across all CPUs.

I'm not sure what the best thing to do is w.r.t. exposing that to
userspace.

Thanks,
Mark.
