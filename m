From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Apr 2013 13:15:04 +0100
Subject: [PATCH] ARM: make cpu_init() notrace
In-Reply-To: <1366654116.3989.16.camel@computer5.home>
References: <1366302046.3388.8.camel@linaro1.home>
 <20130422140711.GI14496@n2100.arm.linux.org.uk>
 <1366654116.3989.16.camel@computer5.home>
Message-ID: <20130425121504.GD14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 07:08:36PM +0100, Jon Medhurst (Tixy) wrote:
> On Mon, 2013-04-22 at 15:07 +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 18, 2013 at 05:20:46PM +0100, Jon Medhurst (Tixy) wrote:
> > > On resume from CPU power down any trace hooks enabled in cpu_init()
> > > will get called before that function has done set_my_cpu_offset(),
> > > so any use of per-cpu variables by trace hook code will cause bad
> > > things to happen. Prevent this by marking the function notrace.
> > > 
> > > This fixes lockups/crashes seen when enabling function tracer on TC2
> > > with the not yet mainlined cpuidle driver.
> > 
> > Looks sane.  Needs to go to the patch system though.  Not sure if it'll
> > make 3.9 given its proximity (we're on -rc8).
> 
> Added as patch 7700/1. Don't think there is a big rush as the problem
> has probably been there since 3.8 when commit 14318efb (implement
> optimized percpu variable access) started using TPIDRPRW; which is
> presumably lost over CPU power down.

$ pdb getpatch 7700/1 |tr ' ' '_' |less
diff_--git_a/arch/arm/kernel/setup.c_b/arch/arm/kernel/setup.c
index_d343a6c..943cbf0_100644
---_a/arch/arm/kernel/setup.c
+++_b/arch/arm/kernel/setup.c
@@_-390,7_+390,7_@@_static_void___init_feat_v6_fixup(void)
__*
__*_cpu_init_sets_up_the_per-CPU_stacks.
__*/
-void_cpu_init(void)
+void_notrace_cpu_init(void)
_{
________unsigned_int_cpu_=_smp_processor_id();
________struct_stack_*stk_=_&stacks[cpu];

Can you guess why git has a problem appying the above... you seem to
have sent the patch from your mailer, I guess your mailer thinks it
knows better when it comes to what characters should be in your
message... or maybe its a cut'n'paste issue?
