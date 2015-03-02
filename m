From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 2 Mar 2015 14:13:55 -0800
Subject: [PATCH v2 2/8] arm64: Convert hcalls to use ISS field
In-Reply-To: <1424902170.17282.9.camel@infradead.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <6719b2520095926ae0e8ac888663b87f2098f565.1421449714.git.geoff@infradead.org>
 <1422660828.21823.40.camel@infradead.org>
 <20150219205714.GC24460@cbox>
 <1424902170.17282.9.camel@infradead.org>
Message-ID: <20150302221355.GA12902@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 02:09:30PM -0800, Geoff Levand wrote:
> Hi Christoffer,
> 
> On Thu, 2015-02-19 at 21:57 +0100, Christoffer Dall wrote:
> > On Fri, Jan 30, 2015 at 03:33:48PM -0800, Geoff Levand wrote:
> > > To allow for additional hcalls to be defined and to make the arm64 hcall API
> > > more consistent across exception vector routines, change the hcall implementations
> > > to use the ISS field of the ESR_EL2 register to specify the hcall type.
> > 
> > how does this make things more consistent?  Do we have other examples of
> > things using the immediate field which I'm missing?
> 
> As I detail in the next paragraph, by consistent I mean in the API exposed,
> not in the implementation.  This point is really secondary to the need for
> more hyper calls as I discuss below.
> 
> > > The existing arm64 hcall implementations are limited in that they only allow
> > > for two distinct hcalls; with the x0 register either zero, or not zero.  Also,
> > > the API of the hyp-stub exception vector routines and the KVM exception vector
> > > routines differ; hyp-stub uses a non-zero value in x0 to implement
> > > __hyp_set_vectors, whereas KVM uses it to implement kvm_call_hyp.
> > 
> > this seems orthogonal to the use of the immediate field vs. x0 though,
> > so why it the immediate field preferred again?
> 
> When a CPU is reset via cpu_soft_restart() we need to execute the caller
> supplied reset routine at the exception level the kernel was entered at.
> So, for a kernel entered at EL2, we need a way to execute that routine at
> EL2.
> 
> The current hyp-stub vector implementation, which uses x0, is limited
> to two hyper calls; __hyp_get_vectors and __hyp_set_vectors.  To
> support cpu_soft_restart() we need a third hyper call, one which
> allows for code to be executed at EL2.  My proposed use of the
> immediate value of the hvc instruction will allow for 2^16 distinct
> hyper calls.
>  

right, but using x0 allows for 2^64 distinct hypercalls.  Just to be
clear, I'm fine with using immediate field if there are no good reasons
not to, I was just curious as to what direct benefit it has.  After
thinking about it a bit, from my point of view, the benefit would be the
clarity that x0 is first argument like a normal procedure call, so no
need to shift things around.  Is this part of the equation or am I
missing the overall purpose here?

> > > Define three new preprocessor macros HVC_CALL_HYP, HVC_GET_VECTORS, and
> > > HVC_SET_VECTORS to be used as hcall type specifiers and convert the
> > > existing __hyp_get_vectors(), __hyp_set_vectors() and kvm_call_hyp() routines
> > > to use these new macros when executing an HVC call.  Also change the
> > > corresponding hyp-stub and KVM el1_sync exception vector routines to use these
> > > new macros.
> > > 
> > > Signed-off-by: Geoff Levand <geoff@infradead.org>
> > > ---
> > >  arch/arm64/include/asm/virt.h | 27 +++++++++++++++++++++++++++
> > >  arch/arm64/kernel/hyp-stub.S  | 32 +++++++++++++++++++++-----------
> > >  arch/arm64/kernel/psci.c      |  3 ++-
> > >  arch/arm64/kvm/hyp.S          | 16 +++++++++-------
> > >  4 files changed, 59 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> > > index 7a5df52..eb10368 100644
> > > --- a/arch/arm64/include/asm/virt.h
> > > +++ b/arch/arm64/include/asm/virt.h
> > > @@ -18,6 +18,33 @@
> > >  #ifndef __ASM__VIRT_H
> > >  #define __ASM__VIRT_H
> > >  
> > > +/*
> > > + * The arm64 hcall implementation uses the ISS field of the ESR_EL2 register to
> > > + * specify the hcall type.  The exception handlers are allowed to use registers
> > > + * x17 and x18 in their implementation.  Any routine issuing an hcall must not
> > > + * expect these registers to be preserved.
> > > + */
> > 
> > I thought the existing use of registers were based on the arm procedure
> > call standard so we didn't have to worry about adding more caller-save
> > registers.
> > 
> > Don't we now have to start adding code around callers to make sure
> > callers know that x17 and x18 may be clobbered?
> 
> We use x17 and x18 to allow hyper calls to work without a stack, which
> is needed for cpu_soft_restart(). The procedure call standard says that
> these are temporary registers, so a C compiler should not expect these
> to be preserved.
> 
Then why not use r9-15 or r0-r7 as the AACPS clearly specifies as
caller preserve instead of the registers which may have special meaning
etc.?

-Christoffer
