From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 11 Aug 2011 14:10:54 +0100
Subject: [RFC PATCH 0/5] Fix Thumb-2 undef handling for mixed-arch kernels
In-Reply-To: <1312975897.7800.20.camel@computer2>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
	<1312975897.7800.20.camel@computer2>
Message-ID: <20110811131054.GB2336@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 12:31:37PM +0100, Tixy wrote:
> On Wed, 2011-08-10 at 11:13 +0100, Dave Martin wrote:
> > As a side-effect, this also changes cpu_architecture from a
> > function into a global variable initialised at boot-time, which is
> > probably a sensible idea anyway.
> 
> One possible pitfall of this is if the variable didn't get set up before
> it's first use. I have looked at all the uses and this doesn't seem to
> be a problem though.

I thought of that.  I believe the code is safe as-is, but it's not too
maintenance-friendly, so...

> 
> An alternative to defend against this is to make cpu_architecture() an
> inline function returning the value of the global variable like:
> 
> inline int cpu_architecture(void)
> {
> 	BUG_ON(the_cpu_architecture == CPU_ARCH_UNKNOWN);
> 	return the_cpu_architecture;
> }
> 
> This has the bonus of not needing to change users of the the function.

Sounds like a good idea.  I got rid of the function because I didn't like
calling a function from the undef handler entry code, but an inline
function which just reads the variable seems like the best of both worlds.
I would continue to read the variable directly from the undef handler,
but this will not get called until userspace starts -- by which time the
inline C function will have been called a few times from C code.

If cpu_architecture is unexpectedly read as zero from the undef handler,
we will get some unexpected SIGILLs in userspace -- so this will get
noticed (rather than causing silent errors).  However, I think the kernel
should always hit BUG() before that point is reached, if using your
suggested inline function.

As you say, it takes away a lot of the patch churn too.

I'll follow up with a revision based on this suggestion.

This also gets rid of the kprobes- and s3c24xx-specific patches.

Cheers
---Dave
