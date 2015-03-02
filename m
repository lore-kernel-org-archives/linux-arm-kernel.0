From: geoff@infradead.org (Geoff Levand)
Date: Mon, 02 Mar 2015 15:22:16 -0800
Subject: [PATCH v2 2/8] arm64: Convert hcalls to use ISS field
In-Reply-To: <20150302221355.GA12902@lvm>
References: <cover.1421449714.git.geoff@infradead.org>
 <6719b2520095926ae0e8ac888663b87f2098f565.1421449714.git.geoff@infradead.org>
 <1422660828.21823.40.camel@infradead.org> <20150219205714.GC24460@cbox>
 <1424902170.17282.9.camel@infradead.org> <20150302221355.GA12902@lvm>
Message-ID: <1425338536.9265.2.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Mon, 2015-03-02 at 14:13 -0800, Christoffer Dall wrote:
> On Wed, Feb 25, 2015 at 02:09:30PM -0800, Geoff Levand wrote:
> > The current hyp-stub vector implementation, which uses x0, is limited
> > to two hyper calls; __hyp_get_vectors and __hyp_set_vectors.  To
> > support cpu_soft_restart() we need a third hyper call, one which
> > allows for code to be executed at EL2.  My proposed use of the
> > immediate value of the hvc instruction will allow for 2^16 distinct
> > hyper calls.  
> 
> right, but using x0 allows for 2^64 distinct hypercalls.  Just to be
> clear, I'm fine with using immediate field if there are no good reasons
> not to, I was just curious as to what direct benefit it has.  After
> thinking about it a bit, from my point of view, the benefit would be the
> clarity that x0 is first argument like a normal procedure call, so no
> need to shift things around.  Is this part of the equation or am I
> missing the overall purpose here?

Yes, in general it will make marshaling of args, etc. easier.  Also,
to me, if we are going to change the implementation it seems to be
the most natural way.
 
> > > > + * The arm64 hcall implementation uses the ISS field of the ESR_EL2 register to
> > > > + * specify the hcall type.  The exception handlers are allowed to use registers
> > > > + * x17 and x18 in their implementation.  Any routine issuing an hcall must not
> > > > + * expect these registers to be preserved.
> > > > + */
> > > 
> > > I thought the existing use of registers were based on the arm procedure
> > > call standard so we didn't have to worry about adding more caller-save
> > > registers.
> > > 
> > > Don't we now have to start adding code around callers to make sure
> > > callers know that x17 and x18 may be clobbered?
> > 
> > We use x17 and x18 to allow hyper calls to work without a stack, which
> > is needed for cpu_soft_restart(). The procedure call standard says that
> > these are temporary registers, so a C compiler should not expect these
> > to be preserved.
> > 
> Then why not use r9-15 or r0-r7 as the AACPS clearly specifies as
> caller preserve instead of the registers which may have special meaning
> etc.?

OK, I will change these to x9, x10.  I'll post a v8 patch set soon.

-Geoff
