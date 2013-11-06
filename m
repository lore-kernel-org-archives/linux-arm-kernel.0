From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Nov 2013 11:07:51 +0000
Subject: mm: get_user_pages_fast()
In-Reply-To: <20131106105400.GV16735@n2100.arm.linux.org.uk>
References: <52797483.2000105@cs.bris.ac.uk>
 <20131106105400.GV16735@n2100.arm.linux.org.uk>
Message-ID: <20131106110751.GE21074@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:54:00AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 05, 2013 at 10:43:15PM +0000, Michael McTernan wrote:
> > I think there's a problem on ARM with futex calls to FUTEX_WAIT and  
> > similar for addresses that have been mapped to userspace from /dev/mem  
> > or a device which sets VM_IO or VM_PFNMAP.  This can break  
> > pthread_mutex_lock() if placed on such mapped memory and attributed as  
> > process-shared.
> 
> Firstly, please stop this madness.  Placing futexes in IO memory is not
> supported, period.  You can't map random bits of /dev/mem and expect
> this stuff to work.

Yikes, I didn't notice that when I read the original post!

> (a) you're generally not allowed to map kernel memory via /dev/mem, so
> that rules out all kernel managed memory.
> (b) you are allowed to map memory outside of that, but you get it as
> strongly ordered memory.
> 
> (b) means that the load/store exclusives, which userspace mutexes will
> use on ARMv6+, will not work correctly.  (they're not supported to
> strongly ordered memory by the architecture.)
> 
> In other words, don't put mutexes in memory you've remapped from /dev/mem.
> In fact, as an application, you should not be mapping /dev/mem at all.

Completely agreed.

As an aside, fastgup is still something we want on ARM (it is required to
support futexes on transparent huge pages, which is what I originally
assumed this was about), so my previous comments about Steve's patches still
stand.

Will
