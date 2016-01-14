From: Leonid.Yegoshin@imgtec.com (Leonid Yegoshin)
Date: Thu, 14 Jan 2016 13:36:50 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160114212913.GF3818@linux.vnet.ibm.com>
References: <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com> <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
Message-ID: <569814F2.50801@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2016 01:29 PM, Paul E. McKenney wrote:
>
>> On 01/14/2016 12:34 PM, Paul E. McKenney wrote:
>>>
>>> The WRC+addr+addr is OK because data dependencies are not required to be
>>> transitive, in other words, they are not required to flow from one CPU to
>>> another without the help of an explicit memory barrier.
>> I don't see any reliable way to fit WRC+addr+addr into "DATA
>> DEPENDENCY BARRIERS" section recommendation to have data dependency
>> barrier between read of a shared pointer/index and read the shared
>> data based on that pointer. If you have this two reads, it doesn't
>> matter the rest of scenario, you should put the dependency barrier
>> in code anyway. If you don't do it in WRC+addr+addr scenario then
>> after years it can be easily changed to different scenario which
>> fits some of scenario in "DATA DEPENDENCY BARRIERS" section and
>> fails.
> The trick is that lockless_dereference() contains an
> smp_read_barrier_depends():
>
> #define lockless_dereference(p) \
> ({ \
> 	typeof(p) _________p1 = READ_ONCE(p); \
> 	smp_read_barrier_depends(); /* Dependency order vs. p above. */ \
> 	(_________p1); \
> })
>
> Or am I missing your point?

WRC+addr+addr has no any barrier. lockless_dereference() has a barrier. 
I don't see a common points between this and that in your answer, sorry.

- Leonid.
