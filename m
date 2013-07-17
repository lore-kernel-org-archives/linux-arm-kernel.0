From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jul 2013 13:52:45 -0600
Subject: preempted dup_mm misses TLB invalidate
In-Reply-To: <20130717192746.GE16496@MacBook-Pro.local>
References: <51E43D2B.9090709@nvidia.com>
 <20130717192746.GE16496@MacBook-Pro.local>
Message-ID: <51E6F60D.6060804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 01:27 PM, Catalin Marinas wrote:
> On Mon, Jul 15, 2013 at 07:19:23PM +0100, Nickolas Fortino wrote:
>> I?ve noticed an issue in simulation where the Linux kernel is executing 
>> a user process when the page tables and TLBs have gotten out of sync. 
>> The page tables have a page marked as user read only, but the TLB has 
>> the page marked as user read/write.
> 
> This happens during fork() for the current process. I think mprotect()
> as well. The caller is supposed not to have threads that write its
> memory while another thread does a fork().

Hmmm. That sounds like a plausible explanation, but I'm not convinced
it's true.

I would guess that the only way to prevent threads of an application
from writing to its memory while a fork() happens in another thread is
to prevent those threads from running at all; almost any code is going
to do some writes e.g. to the stack at least. That would imply the
kernel must prevent the scheduling of the other threads, not the
user-space application.

I quickly searched and couldn't see anything that agreed with your
statement about this being a user-space bug. There are plenty of
articles pointing out potential problems if a threaded app forks, but I
didn't see anything that said it's no legal. I also note that pthreads
explicitly specifies what happens if a threaded app forks (just the
thread calling fork is duplicated into the child process), what
functions can be called after a fork ("async-safe" functions), and the
function pthread_at_fork() exists, all of which tend to imply that
forking-and-threading can be legally used together.
