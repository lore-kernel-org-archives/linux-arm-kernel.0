From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 9 Sep 2016 16:21:27 +0100
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
In-Reply-To: <dad2e7cc-f8cb-4e33-99c7-66effa7a6f5e@redhat.com>
References: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
 <dad2e7cc-f8cb-4e33-99c7-66effa7a6f5e@redhat.com>
Message-ID: <20160909152047.GA3958@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 04:39:14PM +0200, Florian Weimer wrote:
> On 09/09/2016 04:15 PM, Dave Martin wrote:
> >This new record can be added in sigframe.__reserved[] if there is a
> >need to allocate extra space beyond the standard signal frame.  The
> >extra block of memory referenced by extra_context can then be parsed in
> >the same way as sigcontext.__reserved[].  Old code should just ignore
> >the whole thing as an unrecognised record.  To maintain backward
> >compatibility, signal context records defined today are always placed
> >directly in __reserved[], never in the block referenced by
> >extra_context.
> 
> Do you add this extra information only if the stack is sufficiently large?
> 
> x86_64 adds the new information even for small stacks set up with
> sigaltstack, leading to memory corruption on bleeding-edge hardware:
> 
>   <https://bugzilla.kernel.org/show_bug.cgi?id=153531>

Hmmm, not yet.  We already check that the whole frame is writable user
memory, but this isn't sufficient to avoid user corruption in the case
of alternate signal stacks.  I'll fix this -- thanks for flagging it.

If the stack isn't large enough, we'll still have to SEGV the task
though.


We can (and should) bump up the SIG{,MIN}STKSZ constants when adding
the SVE support proper to the kernel, but this doesn't solve the
problem of existing binaries.  For backwards compatibility the kernel
would still have to permit the historical (too-small) values of
these constants for calls to sigaltstack(2) though, which is not ideal.

I wonder whether we should make the signal stack size runtime
discoverable through sysconf() instead...

Cheers
---Dave
