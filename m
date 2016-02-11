From: harba@codeaurora.org (Abdulhamid, Harb)
Date: Wed, 10 Feb 2016 21:40:44 -0500
Subject: [PATCH V1 4/6] arm64: exception: handle Synchronous External Abort
In-Reply-To: <20160210180344.GV1052@arm.com>
References: <1454699608-22760-1-git-send-email-tbaicar@codeaurora.org>
 <1454699608-22760-5-git-send-email-tbaicar@codeaurora.org>
 <20160210180344.GV1052@arm.com>
Message-ID: <56BBF4AC.7000208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/10/2016 1:03 PM, Will Deacon wrote:
> On Fri, Feb 05, 2016 at 12:13:26PM -0700, Tyler Baicar wrote:

<snip>

>> +static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>> +{
>> +	struct siginfo info;
>> +
>> +	atomic_notifier_call_chain(&sea_handler_chain, 0, NULL);
>> +
>> +	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
>> +		 fault_name(esr), esr, addr);
>> +
>> +	info.si_signo = SIGBUS;
>> +	info.si_errno = 0;
>> +	info.si_code  = 0;
>> +	info.si_addr  = (void __user *)addr;
>> +	arm64_notify_die("", regs, &info, esr);
> 
> Surely we don't want to call this if the notifier chain handled the
> exception?
You are correct, Ideally you should not die if the notifier chain
handled the exception (e.g. via memory fault handling).  However, this
patch was intended as a first step to provide the user with more useful
information about the hardware error (e.g. details of a cache error, bus
error, or memory error that led to the SEA).

The thought was to do what your suggesting as a next step (i.e. adding
actually recovery mechanisms in the SEA handler). However, there are a
couple of questions enumerated below that I think need more discussion.

First, you need a way to get information returned from the notifier
chain to understand whether or not it recovered from the error. (If this
easier than I'm making it out to be, please set me straight here, as it
was not clear to me at first glance on how to do that)

Second, you need a way to kill/abort the thread that encountered this
error, which (I assume) would only be valid/possible thing to do if it
was a user thread that encountered the hardware error.

For example, let's say we encounter an SEA due to a memory error that
was successfully handled by the memory fault handling code (e.g. offline
a page owned by some user application).  Since this is a synchronous
error that may have occurred either on a load, store, or instruction
fetch, the SEA handler must also know to kill the user thread that
encountered that hardware error.  It is not clear to me how we do that
cleanly, and what the repercussions would be. Would it get handled
naturally after the page has become invalid (e.g. it would just result
in a translation fault when attempting to continue the thread, existing
kernel software error handling takes it from there)?

Also, keep in mind that our current assumption is that *all* kernel data
and threads should be considered critical, and any
corruption/termination of kernel data/threads should always be treated
as fatal.  Please let us know if you disagree.

Harb
-- 
Qualcomm Technologies, Inc.
on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
