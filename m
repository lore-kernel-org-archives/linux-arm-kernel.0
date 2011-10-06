From: gdavis@mvista.com (George G. Davis)
Date: Thu, 6 Oct 2011 00:29:28 -0400
Subject: parallel load of modules on an ARM multicore
In-Reply-To: <CAHkRjk60dZX45DNiHoSd578NVv2G2E+95cfEk3iiUfKS1906HQ@mail.gmail.com>
References: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
	<20110922072959.GA6897@mvista.com>
	<CAHkRjk60dZX45DNiHoSd578NVv2G2E+95cfEk3iiUfKS1906HQ@mail.gmail.com>
Message-ID: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

On Sep 22, 2011, at 4:52 AM, Catalin Marinas wrote:

Ugh, sorry, I've been having problems with fetchmail/POP and did not see your
reply until just now, logged into IMAP finally.  : /

> Hi George,
> 
> On 22 September 2011 08:29, George G. Davis <gdavis@mvista.com> wrote:
>> On Mon, Jun 20, 2011 at 03:43:27PM +0200, EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31) wrote:
>>> I'm getting unexpected results from loading several modules - some
>>> of them in parallel - on an ARM11 MPcore system.
> ...
>> In case anyone missed the subtlety, this report was for an ARM11 MPCore system
>> with CONFIG_PREEMPT enabled.  I've also been looking into this and various other
>> memory corruption issues on ARM11 MPCore with CONFIG_PREEMPT enabled and have
>> come to the conclusion that CONFIG_PREEMPT is broken on ARM11 MPCore.
>> 
>> I added the following instrumentation in 3.1.0-rc4ish to watch for
>> process migration in a few places of interest:
> ...
>> Now with sufficient system stress, I get the following recurring problems
>> (it's a 3-core system : ):
>> 
>> load_module:2858: cpu was 0 but is now 1, memory corruption is possible
>> load_module:2858: cpu was 0 but is now 2, memory corruption is possible
>> load_module:2858: cpu was 1 but is now 0, memory corruption is possible
>> load_module:2858: cpu was 1 but is now 2, memory corruption is possible
>> load_module:2858: cpu was 2 but is now 0, memory corruption is possible
>> load_module:2858: cpu was 2 but is now 1, memory corruption is possible
>> pte_alloc_one:100: cpu was 0 but is now 1, memory corruption is possible
>> pte_alloc_one:100: cpu was 0 but is now 2, memory corruption is possible
>> pte_alloc_one:100: cpu was 1 but is now 0, memory corruption is possible
>> pte_alloc_one:100: cpu was 1 but is now 2, memory corruption is possible
>> pte_alloc_one:100: cpu was 2 but is now 0, memory corruption is possible
>> pte_alloc_one:100: cpu was 2 but is now 1, memory corruption is possible
>> pte_alloc_one_kernel:74: cpu was 2 but is now 1, memory corruption is possible
>> 
>> With sufficient stress and extended run time, the system will eventually
>> hang or oops with non-sensical oops traces - machine state does not
>> make sense relative to the code excuting at the time of the oops.
> 
> I think your analysis is valid and these places are not safe with
> CONFIG_PREEMPT enabled.

Alas, the stress test stability problems persist even with CONFIG_PREEMPT off.
Perhaps the windows are smaller, but they still exist.

>> The interesting point here is that each of the above contain critical
>> sections in which ARM11 MPCore memory is inconsistent, i.e. cache on
>> CPU A contains modified entries but then migration occurs and the
>> cache is flushed on CPU B yet those cache ops called in the above
>> cases do not implement ARM11 MPCore RWFO workarounds.
> 
> I agree, my follow-up patch to implement lazy cache flushing on
> ARM11MPCore was meant for other uses (like drivers not calling
> flush_dcache_page), I never had PREEMPT in mind.
> 
>> Furthermore,
>> the current ARM11 MPCore RWFO workarounds for DMA et al are unsafe
>> as well for the CONFIG_PREEMPT case because, again, process migration
>> can occur during DMA cache maintance operations in between RWFO and
>> cache op instructions resulting in memory inconsistencies for the
>> DMA case - a very narrow but real window.
> 
> Yes, that's correct.
> 
>> So what's the recommendation, don't use CONFIG_PREEMPT on ARM11 MPCore?
>> 
>> Are there any known fixes for CONFIG_PREEMPT on ARM11 MPCore if it
>> is indeed broken as it appears?
> 
> The scenarios you have described look valid to me. I think for now we
> can say that ARM11MPCore and PREEMPT don't go well together.

But it is unreliable even for the !PREEMPT case based on my stress testing,
even with your lazy cache flushing workaound applied.  : /

> This can
> be fixed though by making sure that cache maintenance places with the
> RWFO trick have the preemption disabled. But the RWFO has some
> performance impact as well, so I would only use it where absolutely
> necessary. In this case, I would just disable PREEMPT.

I'll post a series of RFC patches which adress the "low hanging fruit".  I'm still
working on the harder nuts which of course have performance trade offs
between RWFO v. broadcast cache ops to consider...

Thanks and apologies again for lack of follow up reply on my part.  I blame
my fetchmail/POP as I'm still getting at least some LAKML messages, just
not all.  : /

--
Regards,
George

> 
> -- 
> Catalin
