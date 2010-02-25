From: Foster_Brian@emc.com (Foster_Brian at emc.com)
Date: Thu, 25 Feb 2010 08:38:49 -0500
Subject: ARM 2.6.30.9 OOPS question -- stack limit?
In-Reply-To: <20100225125611.GB3101@n2100.arm.linux.org.uk>
References: <D27CA15508148C428A25104ADEFAAC81057281E1@CORPUSMX50C.corp.emc.com>
	<20100225125611.GB3101@n2100.arm.linux.org.uk>
Message-ID: <D27CA15508148C428A25104ADEFAAC810572821A@CORPUSMX50C.corp.emc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I don't think it's overflowed.  Please try to ensure that dumps
> are formatted as they came out of the kernel - this one is horribly
> line wrapped - so I've undone that to read it.
> 

Apologies, thanks for reformatting.

> > Unable to handle kernel paging request at virtual address 000b9a34
> > pgd = cb2e8000 [000b9a34]
> > *pgd=0f021031, *pte=055de34f, *ppte=055deaae
> > Internal error: Oops: 81f
> > [#1] PREEMPT Modules linked in: sr_mod cdrom usblp usbhid
> rt3090sta(P)
> > msdos udf crc_itu_t isofs ufsd(P)
> > CPU: 0    Tainted: P        W   (2.6.30.9 #1)
> > PC is at 0x40a95d60
> > LR is at 0x40a95d5c
> > pc : [<40a95d60>]    lr : [<40a95d5c>]    psr: 80000010
> > sp : bec6a388  ip : 40aa216c  fp : 40aa21b0
> > r10: 40aa2000  r9 : 000001b4  r8 : 000b9a34
> > r7 : 000b9a34  r6 : bec6a5c8  r5 : 00000000  r4 : 00000000
> > r3 : 00000000  r2 : 00000002  r1 : 00000081  r0 : 00000000
> > Flags: Nzcv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user
> > Control: 0005397f  Table: 0b2e8000  DAC: 00000015
> > Process appweb (pid: 26569, stack limit = 0xcb206268)
> > Stack: (0xbec6a388 to 0xcb208000)
> 
> Hmm, we really shouldn't be dumping this much stack.
> 
> In any case:
> 1. PC is in userspace, not kernel.
> 2. PSR is telling us we were in 'user_32' mode.
> 3. SP is a userspace pointer
> 4. Error code 81f (FSR value) tells us that it was a page permission
>    fault (0x00f) in domain 1 (0x010) due to a write (0x800).
> 

Thanks again for breaking/narrowing that down.

> Now, this style of message is produced by __do_kernel_fault(), which
is
> called when:
> 
> 1. we receive a page fault while in an atomic context
> 2. we receive a page fault when there is no mm_struct for the thread
> 3. not in user_32 mode and we have no exception fixup handler for the
>    faulting instruction
> 4. not in user_32 mode and we have no mapping information for the
> address
>    being accessed (iow, address being accessed wasn't mmap'd or part
of
>    the application bss)
> 
> (3) and (4) don't apply because you are in user_32 mode.  (2) is
> highly unlikely, so that leaves (1) - I suspect the futex code is
> issuing this WARN_ON() and then returning to userspace leaving the
> kernel in an atomic state - and the next page fault causes this oops.
> 
> I don't have 2.6.30.9 sources to hand to see what the futex code is
> doing around line 1003 to know what it's complaining about...

Line 1003 is inside the unqueue_me() function (in turn, called as part
of futex_wait()), the specific line is as follows:

static int unqueue_me(struct futex_q *q)
{
...
        if (lock_ptr != NULL) {
                spin_lock(lock_ptr);
                ...
1003 --->       WARN_ON(plist_node_empty(&q->list));
                plist_del(&q->list, &q->list.plist);

                BUG_ON(q->pi_state);

                spin_unlock(lock_ptr);
                ret = 1;
        }

        drop_futex_key_refs(&q->key);
        return ret;
}

I'm not familiar with this area of code, but I can see that q->list is
init'd in queue_me() and added to hb->chain. I don't see any clear
reason why this list would have become empty between the two calls
(which I assume involves a context switch), but in any event, it sounds
like the best approach is to dig into this area and figure out what's
happening here..? Thanks again.

Brian
