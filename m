From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 26 Jul 2013 11:10:53 -0400 (EDT)
Subject: [PATCH 03/13] ARM: b.L: core switcher code
In-Reply-To: <20130726145317.GT24642@n2100.arm.linux.org.uk>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-4-git-send-email-nicolas.pitre@linaro.org>
 <20130726145317.GT24642@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1307261101550.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Jul 2013, Russell King - ARM Linux wrote:

> On Mon, Jul 22, 2013 at 11:31:19PM -0400, Nicolas Pitre wrote:
> > To solve both issues, we borrow some of the task space belonging to
> > the init/idle task which, by its nature, is lightly used and therefore
> > is unlikely to clash with our usage.  The init task is also never going
> > away.
> 
> That is... quite a horrid hack - and it is a hack.  You claim that
> the idle task is not likely to clash, but with 8 CPUs each of
> 256 bytes of stack, that's 2k of stack.  With the thread data
> structure at over 512 bytes, that's 2.5k of 8k.

It is a hack indeed.  This way of doing things does not survive until 
the end of the patch series either.  But doing this for the actual first 
switcher patch makes the code much simpler to review.

> Don't forget that the amount of kernel stack used depends on many
> things - not just what the thread does (in the case of the idle
> thread, that includes cpuidle stuff) but also the function call
> depth of any interrupt in the system, as well as the path used to
> get into the idle thread.
> 
> If you want to do this, it would be much better to use the bottom
> of the stack space for the idle thread associated with the CPU.  The
> idle threads are all forked at boot for any possible CPUs before the
> secondaries are brought online, and so are persistent.  That would
> reduce the additional required space to 256 bytes on the stack, not
> 2k on a single stack.

What I do in a later patch is to use dedicated switcher threads per 
logical CPU, and the separate stack is taken from each thread's stack.  
That also means that only 2 special stack areas are needed instead of 8 
or more.

But kernel threads are introduced as a separate patch to ease review.


Nicolas
