From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 7 Jun 2010 23:10:47 +0100
Subject: your mail
In-Reply-To: <AANLkTikxfktI7Heocg8kaBFziT3CXMzRzr-RJcXSQhbG@mail.gmail.com>
References: <AANLkTikxfktI7Heocg8kaBFziT3CXMzRzr-RJcXSQhbG@mail.gmail.com>
Message-ID: <20100607221047.GA27304@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Hylands wrote:
> I'm trying to understand what I need to be concerned about with SMP
> processors and sharing global data (in particular a dual Cortex-A9)
> 
> I'm familiar with spinlocks, but in this case I'm trying to work with
> some lockless data structures.
> 
> What I'm not sure is whether the following would work. Suppose I have
> a couple of 8-bit get/put indicies which are in adjacent memory
> locations (within the same 32-bit word).
> 
> If I have an ISR and a thread running on an SMP core, and the ISR is
> running on one core and the thread is running on a second core, if the
> ISR were to only write to the put pointer and the thread were only to
> write to the get pointer, does the cache maintain consistency? Or do
> the get and put pointers need to be in separate cache lines?
> 
> Another way of asking this: If both cores are writing to the same
> 32-bit word (but different bytes) do the writes collide?

I'm pretty sure any system compatible with pthreads has to be fine
with the variables being independent, because the bytes could be
variables protected by separate mutexes.

However, other questions for your lockless structures are whether
writes by one processor are seen in a reasonable or even bounded time
by reads on another processor (write buffering), and which barrier
instructions to use between the index accesses and accessing some
array they might indexing (only a problem for userspace, because the
kernel already provides barriers).

-- Jamie
