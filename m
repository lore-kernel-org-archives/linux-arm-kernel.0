From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 03 May 2013 09:30:18 -0400
Subject: [PATCH, RFC 14/22] oprofile: always enable IRQ_WORK
In-Reply-To: <20130503115332.GT8356@rric.localhost>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-15-git-send-email-arnd@arndb.de>
 <20130503115332.GT8356@rric.localhost>
Message-ID: <1367587818.7373.12.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-05-03 at 13:53 +0200, Robert Richter wrote:
> On 02.05.13 17:16:18, Arnd Bergmann wrote:
> > oprofile fails to build if CONFIG_IRQ_WORK is not already enabled,
> > because of the dependency on the RING_BUFFER code that now uses
> > the irq work library.
> > 
> > kernel/built-in.o: In function `ring_buffer_unlock_commit':
> > :(.text+0x5b8f0): undefined reference to `irq_work_queue'
> > kernel/built-in.o: In function `ring_buffer_write':
> > :(.text+0x5bd10): undefined reference to `irq_work_queue'
> 
> Shouldn't this be fixed in the ring_buffer implementation?

Hmm, I thought I had ring buffer select irq work. I must have not have
done that.

> 
> I also do not see, where this comes from. I was successfully compiling
> a kernel with OPROFILE and RING_BUFFER enabled but IRQ_WORK disabled.
> Do you have that config still available?
> 

The ring buffer code can now wake up waiters, and to do so it requires
irq_work. I'll send a patch.

Thanks,

-- Steve
