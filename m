From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Mon, 03 Oct 2016 15:20:57 -0400
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <20161001181101.GA17554@remoulade>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
 <20160930193231.GA2521@remoulade>
 <66a031ac2405e352ab0d5f19d7ddb8e9@codeaurora.org>
 <20161001181101.GA17554@remoulade>
Message-ID: <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-10-01 14:11, Mark Rutland wrote:
> Hi Brent,
> 
> Evidently my questions weren't sufficiently clear; even with your 
> answers it's
> not clear to me what precise issue you're attempting to solve. I've 
> tried to be
> more specific this time.
> 
> At a high-level, can you clarify whether you're attempting to solve is:
> 
> (a) a functional correctness issue (e.g. data corruption)
> (b) a performance issue
> 
> And whether this was seen in practice, or found through code 
> inspection?
> 
> On Sat, Oct 01, 2016 at 12:11:36PM -0400, bdegraaf at codeaurora.org 
> wrote:
>> On 2016-09-30 15:32, Mark Rutland wrote:
>> >On Fri, Sep 30, 2016 at 01:40:57PM -0400, Brent DeGraaf wrote:
>> >>+	 * so LSE needs an explicit barrier here as well.  Without this, the
>> >>+	 * changed contents of the area protected by the spinlock could be
>> >>+	 * observed prior to the lock.
>> >>+	 */
>> >
>> >By whom? We generally expect that if data is protected by a lock, you take
>> >the lock before accessing it. If you expect concurrent lockless readers,
>> >then there's a requirement on the writer side to explicitly provide the
>> >ordering it requires -- spinlocks are not expected to provide that.
>> 
>> More details are in my response to Robin, but there is an API arm64 
>> supports
>> in spinlock.h which is used by lockref to determine whether a lock is 
>> free or
>> not.  For that code to work properly without adding these barriers, 
>> that API
>> needs to take the lock.
> 
> Can you please provide a concrete example of a case where things go 
> wrong,
> citing the code (or access pattern) in question? e.g. as in the commit 
> messages
> for:
> 
>   8e86f0b409a44193 ("arm64: atomics: fix use of acquire + release for
> full barrier semantics)
>   859b7a0e89120505 ("mm/slub: fix lockups on PREEMPT && !SMP kernels")
> 
> (for the latter, I messed up the register -> var mapping in one 
> paragraph, but
> the style and reasoning is otherwise sound).
> 
> In the absence of a concrete example as above, it's very difficult to 
> reason
> about what the underlying issue is, and what a valid fix would be for 
> said
> issue.
> 
>> >What pattern of accesses are made by readers and writers such that there is
>> >a problem?
> 
> Please note here I was asking specifically w.r.t. the lockref code, 
> e.g. which
> loads could see stale data, and what does the code do based on this 
> value such
> that there is a problem.
> 
>> I added the barriers to the readers/writers because I do not know 
>> these are
>> not similarly abused.  There is a lot of driver code out there, and 
>> ensuring
>> order is the safest way to be sure we don't get burned by something 
>> similar
>> to the lockref access.
> 
> Making the architecture-provided primitives overly strong harms 
> performance and
> efficiency (in general), makes the code harder to maintain and optimise 
> in
> future, and only masks the issue (which could crop up on other 
> architectures,
> for instance).
> 
> Thanks,
> Mark.


Thinking about this, as the reader/writer code has no known "abuse" 
case, I'll
remove it from the patchset, then provide a v2 patchset with a detailed
explanation for the lockref problem using the commits you provided as an 
example,
as well as performance consideration.

Brent
