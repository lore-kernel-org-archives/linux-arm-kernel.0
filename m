From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Feb 2015 18:11:37 +0000
Subject: [PATCH] arm64: annotate psci invoke functions as notrace
In-Reply-To: <20150224175950.GA28145@redhat.com>
References: <20150218172638.GB1772@redacted.bos.redhat.com>
 <20150224175950.GA28145@redhat.com>
Message-ID: <20150224181137.GY9714@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 05:59:50PM +0000, Richard W.M. Jones wrote:
> On Wed, Feb 18, 2015 at 12:26:38PM -0500, Kyle McMartin wrote:
> > Using GCC 5 to build the kernel with ftrace enabled, we encounter the
> > following error as a result of the mcount prologue changing the expected
> > register use of the function parameters,
> > 
> > /tmp/cc8Kpn7A.s: Assembler messages:
> > /tmp/cc8Kpn7A.s:41: Error: .err encountered
> > /tmp/cc8Kpn7A.s:42: Error: .err encountered
> > /tmp/cc8Kpn7A.s:43: Error: .err encountered
> > /tmp/cc8Kpn7A.s:101: Error: .err encountered
> > /tmp/cc8Kpn7A.s:102: Error: .err encountered
> > /tmp/cc8Kpn7A.s:103: Error: .err encountered
> > scripts/Makefile.build:257: recipe for target 'arch/arm64/kernel/psci.o' failed
> > 
> > Fix this by annotating the function as notrace, to suppress the
> > generation of profiling prologues and epilogues on the function.
> > 
> > Signed-off-by: Kyle McMartin <kyle@redhat.com>
> > 
> > --- a/arch/arm64/kernel/psci.c
> > +++ b/arch/arm64/kernel/psci.c
> > @@ -113,7 +113,7 @@ static void psci_power_state_unpack(u32 power_state,
> >   * The following two functions are invoked via the invoke_psci_fn pointer
> >   * and will not be inlined, allowing us to piggyback on the AAPCS.
> >   */
> > -static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
> > +static noinline notrace int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
> >  					 u64 arg2)
> >  {
> >  	asm volatile(
> > @@ -128,7 +128,7 @@ static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
> >  	return function_id;
> >  }
> >  
> > -static noinline int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
> > +static noinline notrace int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
> >  					 u64 arg2)
> >  {
> >  	asm volatile(
> 
> I need this patch in order to compile the upstream kernel on aarch64
> using gcc 5.  Can it not be added temporarily while the longer term
> fix, whatever that is, is worked out?

As I mentioned in my reply, Will was waiting for -rc1 to post our
patches (which move this out to asm for arm and arm64). He's out of the
office today, but I expect they will be posted tomorrow (and hopefully
queued shortly thereafter).

Mark.
