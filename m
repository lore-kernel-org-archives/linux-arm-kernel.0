From: fweimer@redhat.com (Florian Weimer)
Date: Fri, 9 Sep 2016 19:01:12 +0200
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
In-Reply-To: <20160909152047.GA3958@e103592.cambridge.arm.com>
References: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
 <dad2e7cc-f8cb-4e33-99c7-66effa7a6f5e@redhat.com>
 <20160909152047.GA3958@e103592.cambridge.arm.com>
Message-ID: <d7fa9069-f952-0642-9668-2fea640cdb20@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2016 05:21 PM, Dave Martin wrote:

>> Do you add this extra information only if the stack is sufficiently large?
>>
>> x86_64 adds the new information even for small stacks set up with
>> sigaltstack, leading to memory corruption on bleeding-edge hardware:
>>
>>   <https://bugzilla.kernel.org/show_bug.cgi?id=153531>
>
> Hmmm, not yet.  We already check that the whole frame is writable user
> memory, but this isn't sufficient to avoid user corruption in the case
> of alternate signal stacks.  I'll fix this -- thanks for flagging it.
>
> If the stack isn't large enough, we'll still have to SEGV the task
> though.

You could skip copying the data and not install a pointer to it in the 
existing signal context.

> We can (and should) bump up the SIG{,MIN}STKSZ constants when adding
> the SVE support proper to the kernel,

That's a userspace ABI change (libraries use these constants to size 
struct members), and not a good idea.  You might get away with at this 
stage, but you can't do this every time you add some new process state 
you want to add to signal handlers.

> I wonder whether we should make the signal stack size runtime
> discoverable through sysconf() instead...

That might be a good idea, yes.

Florian
