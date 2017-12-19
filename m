From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 19 Dec 2017 15:51:41 -0800
Subject: [PATCH v2] IPI performance benchmark
In-Reply-To: <20171219085010.4081-1-ynorov@caviumnetworks.com>
References: <20171219085010.4081-1-ynorov@caviumnetworks.com>
Message-ID: <20171219155141.889253fe797ca838da71e88f@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Dec 2017 11:50:10 +0300 Yury Norov <ynorov@caviumnetworks.com> wrote:

> This benchmark sends many IPIs in different modes and measures
> time for IPI delivery (first column), and total time, ie including
> time to acknowledge the receive by sender (second column).
> 
> The scenarios are:
> Dry-run:	do everything except actually sending IPI. Useful
> 		to estimate system overhead.
> Self-IPI:	Send IPI to self CPU.
> Normal IPI:	Send IPI to some other CPU.
> Broadcast IPI:	Send broadcast IPI to all online CPUs.
> Broadcast lock:	Send broadcast IPI to all online CPUs and force them
>                 acquire/release spinlock.
> 
> The raw output looks like this:
> [  155.363374] Dry-run:                         0,            2999696 ns
> [  155.429162] Self-IPI:                 30385328,           65589392 ns
> [  156.060821] Normal IPI:              566914128,          631453008 ns
> [  158.384427] Broadcast IPI:                   0,         2323368720 ns
> [  160.831850] Broadcast lock:                  0,         2447000544 ns
> 
> For virtualized guests, sending and reveiving IPIs causes guest exit.
> I used this test to measure performance impact on KVM subsystem of
> Christoffer Dall's series "Optimize KVM/ARM for VHE systems" [1].
> 
> Test machine is ThunderX2, 112 online CPUs. Below the results normalized
> to host dry-run time, broadcast lock results omitted. Smaller - better.
> 
> Host, v4.14:
> Dry-run:	  0	    1
> Self-IPI:         9	   18
> Normal IPI:      81	  110
> Broadcast IPI:    0	 2106
> 
> Guest, v4.14:
> Dry-run:          0	    1
> Self-IPI:        10	   18
> Normal IPI:     305	  525
> Broadcast IPI:    0    	 9729
> 
> Guest, v4.14 + [1]:
> Dry-run:          0	    1
> Self-IPI:         9	   18
> Normal IPI:     176	  343
> Broadcast IPI:    0	 9885
> 

That looks handy.  Peter and Ingo might be interested.

I wonder if it should be in kernel/.  Perhaps it's better to accumulate
these things in lib/test_*.c, rather than cluttering up other top-level
directories.

> +static ktime_t __init send_ipi(int flags)
> +{
> +	ktime_t time = 0;
> +	DEFINE_SPINLOCK(lock);

I have some vague historical memory that an on-stack spinlock can cause
problems, perhaps with debugging code.  Can't remember, maybe I dreamed it.
