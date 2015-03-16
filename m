From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 16 Mar 2015 17:47:46 +0000
Subject: Versatile Express randomly fails to boot - Versatile Express
 to be removed from nightly testing
In-Reply-To: <20150316130419.GI8656@n2100.arm.linux.org.uk>
References: <20150315213330.GB8656@n2100.arm.linux.org.uk>
 <20150316000438.GD8656@n2100.arm.linux.org.uk>
 <20150316004239.GE8656@n2100.arm.linux.org.uk>
 <20150316093553.GF8656@n2100.arm.linux.org.uk>
 <20150316130419.GI8656@n2100.arm.linux.org.uk>
Message-ID: <55071742.6000405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 16/03/15 13:04, Russell King - ARM Linux wrote:
> On Mon, Mar 16, 2015 at 09:35:53AM +0000, Russell King - ARM Linux wrote:
>> On Mon, Mar 16, 2015 at 12:42:39AM +0000, Russell King - ARM Linux wrote:
>>> On Mon, Mar 16, 2015 at 12:04:38AM +0000, Russell King - ARM Linux wrote:
>>>> On Sun, Mar 15, 2015 at 09:33:30PM +0000, Russell King - ARM Linux wrote:
>>>>> I'm going to try a few other kernels to try and track down what's going
>>>>> on - whether something from arm-soc or my tree is responsible for this
>>>>> really weird behaviour.
>>>>
>>>> Okay, this is weird - it seems that it's caused by the FIQ oops
>>>> dumping code/FIQ changes which I've carried for many months
>>>> unchanged in my tree.
>>>
>>> More weirdness.  Progressing forwards through my development code
>>> showed that when I merged the patch I mentioned in the previous mail,
>>> things started to fail.
>>>
>>> As I also mentioned, I'd drop that branch (two patches, one adding
>>> the IPI backtrace stuff and the second one updating the GIC to allow
>>> it to raise FIQs on suitably equipped platforms.)  I would have
>>> expected that to have worked, but it just failed after four boot
>>> iterations.  So either it's not the FIQ, or it is the FIQ code _and_
>>> also something else.  Or it has something to do with the placement
>>> of functions in the kernel.
>>>
>>> I'll try more stuff tomorrow, working from where I presently am
>>> (which is basically last night's code minus the FIQ changes) by
>>> removing other changes to see what brings us back to a working
>>> system.
>>>
>>> As I've already said - this is really weird because all of these
>>> changes were also tested against -rc1... those which weren't are:
>>>
>>> mm: fold arch_randomize_brk into ARCH_HAS_ELF_RANDOMIZE
>>> mm: split ET_DYN ASLR from mmap ASLR
>>> mm: move randomize_et_dyn into ELF_ET_DYN_BASE
>>> mm: expose arch_mmap_rnd when available
>>> arm: factor out mmap ASLR into mmap_rnd
>>>
>>> and a number of clkdev rework patches (to make it use clk_hw
>>> internally.)  Neither of these should be affecting it, but that's
>>> something I will be testing tomorrow.
>>
>> Okay, reverting the ASLR changes and the clkdev changes annoyingly still
>> results in random failure.
>
> After ruling out ASLR and clkdev, I started progressively reverting other
> stuff in the build tree.  Eventually, I got down to reverting the L2C
> change I've been carrying since the L2C cleanups.
>
> With that lot reverted, which is slightly more than the previously known
> good test, it booted five times without issue.
>
> So, I thought I'd add that L2C change to the list of bad commits, and try
> omitting _just_ the L2C and FIQ changes... and it still fails - on the
> first test boot iteration.
>
> I think I'm going to declare that this is all down to some obscure
> hardware problem with Versatile Express, which is tickled by the layout
> of the kernel against the cache, and take it out of the nightly system
> (it's pointless having unstable hardware being tested; random failures
> are completely meaningless.)
>

I was able to see exact behaviour on my VExpress setup with CA9X4 
core-tile. Few observations from my side:

1. This issue can be reproduced even on v3.19
2. As you suspected L2C, I tried disabling L2C and it seems to solve
    the issue
3. Since it's very random and enabling LL_DEBUG made it difficult to
    reproduce the issue, I tried to dump the stack using DS5 debugger
4. The stack is exactly same always both on v4.0-rc* and v3.19 kernel
    and on multiple runs
5. Connecting to h/w debugger, stopping and re-starting the CPUs,
    solves the issue. It's helping CPUs to get out of __radix_tree_lookup
    somehow

Stacktrace
==========
(sorry it's looks different from std. Linux backtrace as this one id 
dump from DS5)

CPU 0
----
#0 __radix_tree_lookup( root = <Value currently has no location>, index 
= 16, nodep = (struct radix_tree_node**) 0x0, slotp = (void***) 0x0 ) at 
radix-tree.c:517
#1 generic_handle_irq( irq = 16 ) at irqdesc.c:349
#2 __handle_domain_irq( domain = (struct irq_domain*) 0xBF004400, hwirq 
= 16, lookup = <Value currently has no location>, regs = <Value 
currently has no location> ) at irqdesc.c:391
#3 __raw_readl( addr = <Value optimised away by compiler> ) at io.h:121
#4 gic_handle_irq( regs = (struct pt_regs*) 0x805F1F40 ) at irq-gic.c:277
#5 [__irq_svc+0x40]


CPU1
----
#0 __radix_tree_lookup( root = <Value currently has no location>, index 
= 16, nodep = (struct radix_tree_node**) 0x0, slotp = (void***) 0x0 ) at 
radix-tree.c:517
#1 __irq_get_desc_lock( irq = <Value currently has no location>, flags = 
(long unsigned int*) 0xBF08BF94, bus = false, check = 3 ) at irqdesc.c:544
#2 enable_percpu_irq( irq = 16, type = 0 ) at manage.c:1583
#3 twd_timer_cpu_notify( self = <Value not available : Undefined value 
in stack frame for register R0>, action = <Value currently has no 
location>, hcpu = <Value not available : Undefined value in stack frame 
for register R2> ) at smp_twd.c:322
#4 notifier_call_chain( nl = <Value currently has no location>, val = 
<Value not available : Undefined value in stack frame for register R1>, 
v = <Value not available : Undefined value in stack frame for register 
R2>, nr_to_call = <Value not available : Undefined value in stack frame 
for register R3>, nr_calls = (int*) 0x0 ) at notifier.c:95
#5 notifier_to_errno( ret = <Value currently has no location> ) at 
notifier.h:179
#6 cpu_notify( val = <Value currently has no location>, v = <Value 
currently has no location> ) at cpu.c:234
#7 secondary_start_kernel() at smp.c:367

CPU2 & CPU3
-----------
Not booted yet, still waiting in bootloader
