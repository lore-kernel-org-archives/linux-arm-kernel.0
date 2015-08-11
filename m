From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 11 Aug 2015 15:41:52 -0400 (EDT)
Subject: arm kernel oops in highmem.c with 4.2
In-Reply-To: <20150811181008.GA7557@n2100.arm.linux.org.uk>
References: <CALeDE9Ox3=sh3AXQ0NUG6BBfU5i5YrMY=LDpcTHQWqz2=60F2g@mail.gmail.com>
 <20150805100701.GV7557@n2100.arm.linux.org.uk>
 <CALeDE9PXF=gQCaBCiHpHy2nXOooQOmsCQvSgOv+wQw3mta=P6A@mail.gmail.com>
 <20150805112713.GY7557@n2100.arm.linux.org.uk>
 <1439315290.3153.11.camel@redhat.com>
 <20150811181008.GA7557@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1508111501130.1515@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Aug 2015, Russell King - ARM Linux wrote:

> On Tue, Aug 11, 2015 at 01:48:10PM -0400, Mark Salter wrote:
> > On Wed, 2015-08-05 at 12:27 +0100, Russell King - ARM Linux wrote:
> > > It helps if I look at 4.2 rather than an older kernel :)
> > > 
> > > However, I've checked that I have DEBUG_HIGHMEM enabled, which I do, and
> > > I'm unable to reproduce this here.  My kernels are built with gcc 4.7.4.
> > > 
> > > What it looks like from your oops is that the address which was passed
> > > in was 0xffedf000, but the address we calculated via the following for
> > > the current index was 0xfff00000:
> > > 
> > > type = kmap_atomic_idx();
> > > idx = type + KM_TYPE_NR * smp_processor_id();
> > > __fix_to_virt(idx)
> > > 
> > > Doing a bit of maths... the address 0xffedf000 corresponds to a fixmap
> > > index of... (0xffeff000 - 0xffedf000) >> 12 = 32.  KM_TYPE_NR is 16 on
> > > ARM, so the mapping was created by CPU 2, and type was zero.
> > > 
> > > On unmap, 0xfff00000 gives... (0xffeff000 - 0xfff00000) >> 12 = -1.
> > > That suggests we're on CPU 0, and type is -1 - in other words, there
> > > are no atomically mapped mappings on CPU 0.
> > > 
> > > Since kmap_atomic() disables preemption and page faults, how did your
> > > kernel migrate this thread from CPU 2 to CPU 0... and I can't see how
> > > that happened.
> > > 
> > 
> > The fedora kernel is using PREEMPT_VOLUNTARY with !PREEMPT and
> > !PREEMPT_CPOUNT. So preempt_disable() is a nop. I added some code
> > to catch the kernel scheduling between kmap_atomic() and
> > kunmap_atomic() and got this straightaway:
> 
> Looking at the backtrace, and grepping for __copy_to_user_memcpy, it
> seems to imply that you're using the uaccess-with-memcpy code.
> 
> This code is relatively unmaintained, and probably mostly unused by
> people today, so I doubt it gets much in the way of testing - and
> you've certainly found a bug in there.
> 
>         /* the mmap semaphore is taken only if not in an atomic context */
>         atomic = in_atomic();
> 
>         if (!atomic)
>                 down_read(&current->mm->mmap_sem);
> 
> is not sufficient to tell whether we can take the semaphore.
> 
> We _could_ replace the above with:
> 
> 	int ret;
> 
> 	ret = down_read_trylock(&current->mm->mmap_sem);
> 	if (!ret) {
> 		__copy_to_user_std(to, from, n);
> 		return;
> 	}
> 
> but that's just a guess.  I'm not a big fan of this code, and given
> that it probably doesn't get much use, we may be better off deleting
> it so it doesn't sit around rotting...  Code like this really needs
> regular testing.

I'd agree.  But first I'd like to know why the fedora kernel is using 
CONFIG_UACCESS_WITH_MEMCPY?  If it's just because it sounded cool then 
that's a bad reason.

That code was created to work around inneficiency in the Orion CPU core 
that didn't coalesce writes from STRT instructions, and by using plain 
STR and/or STM the actual throughput was more than doubled.  This was 
fixed in later cores. However Orion users (if they still exist) might 
like the added performance. I don't have Orion-based targets anymore 
(they took the way of the recycling facility a while ago).

To be sure you really need it, you may try something like:

	dd if=/dev/zero of=/dev/null bs=4k

and compare the reported speed with and without 
CONFIG_UACCESS_WITH_MEMCPY.


Nicolas
