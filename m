From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Tue, 04 Feb 2014 10:45:35 -0500
Subject: UBI leb_write_unlock NULL pointer Oops (continuation) on ARM926
References: <D7B1B5F4F3F27A4CB073BF422331203F2A18997F1F@Exchange1.lawo.de>
 <CAFLxGvya5WXoKcYmOgeM_SmVVEht1jEzeLG9vHhwFudFU+Ny8A@mail.gmail.com>
 <D7B1B5F4F3F27A4CB073BF422331203F2A18997F8B@Exchange1.lawo.de>
 <52EF772D.8080207@nod.at>
 <D7B1B5F4F3F27A4CB073BF422331203F2A18DD7989@Exchange1.lawo.de>
 <52EF9FFE.4020405@nod.at>
 <1391498545.1795.29.camel@sauron.fi.intel.com>
 <52F09AC9.6090604@nod.at>
 <1391500492.1795.36.camel@sauron.fi.intel.com>
Message-ID: <878utq51b4.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>>> Am 03.02.2014 13:51, schrieb Wiedemer, Thorsten (Lawo AG):

>>>>> I can reproduce it fairly regularly, but not really "quickly". At
>>>>> the moment, I can use a setup of about identical 70 devices.  A
>>>>> test over the last weekend resultet In 6 devices showing the bug.
>>>>> What we have are multiple processes which write in different
>>>>> intervals some data on the device and sync it, because this data
>>>>> should be available after a power cut.  Perhaps I can force the
>>>>> error more often in writing test processes with shorter write/sync
>>>>> intervals.
>>>>>
>>>>> If I have further access to the "big" setup for some days, I will
>>>>> try to make a test without preemption.

>>> On Mon, 2014-02-03 at 14:56 +0100, Richard Weinberger wrote:

>>>> Hmm, ok.
>>>> Please also apply this patch, just in case...

I don't think this patch will help.

On  4 Feb 2014, dedekind1 at gmail.com wrote:

> May be. Although sometimes corruptions are also deterministics - a
> buffer over-run at the same place causes the same side effects etc.

> But in any case, the only way I know to deal with this issues is start
> putting various prints and assertions, and trying to come closer to the
> root-cause. Sometimes bisecting helps, but this case would be difficult
> to bisect because the reproducability is hard. Indeed, one may think
> that there is no failure duding a day, so the commit as 'good' while it
> may be actually 'bad', the bug just happen to not manifest itself
> quickly enough.

I have seen the same crash on a 2.6.36 system with all of the UbiFs/Ubi
backported.  It is also an IMX25 based system.

We have,

 PC is at __up_write+0x3c/0x1a8  
 LR is at __up_write+0x24/0x1a8  
 pc : [<c0229400>]    lr : [<c02293e8>]    psr: a0000093  
 sp : c7225cc8  ip : 00020000  fp : c79fba00  
 r10: 00000523  r9 : 00000001  r8 : c7b33000  
 r7 : c793a800  r6 : c7bd473c  r5 : c7bd4738  r4 : c7bd4720  
 r3 : 00000000  r2 : 00000002  r1 : 00000001  r0 : 00000002  
 Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user  

 Code: e4863004 e5953004 e1560003 0a00002a (e593200c)

I run this,

   $ printf "\x04\x30\x86\xe4"
            "\x04\x30\x95\xe5" 
            "\x03\x00\x56\xe1"
            "\x2a\x00\x00\x0a"
            "\x0c\x20\x93\xe5" > crash.dump 
   $ objdump --disassemble-all -b binary -m arm crash.dump 
   crash.dump:     file format binary


   Disassembly of section .data:

   00000000 <.data>:
      0:   e4863004        str     r3, [r6], #4
      4:   e5953004        ldr     r3, [r5, #4]
      8:   e1560003        cmp     r6, r3
      c:   0a00002a        beq     0xbc
     10:   e593200c        ldr     r2, [r3, #12]

The values 'r6' and 'r5' are pointers and they are far from non-NULL and
look like good kernel data pointers.  Something in the list is 'NULL'.
There is a load of 'r3' as NULL and then the use of '[r3, #12]' which
gives the crash address of '0xc'.

Here is the objdump with source interspersed for my build,

        sem->activity = 0;
 350:   e3a0a000        mov     sl, #0
 354:   e1a05000        mov     r5, r0
 358:   e485a004        str     sl, [r5], #4
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
        return head->next == head;
 35c:   e5903004        ldr     r3, [r0, #4]
        if (!list_empty(&sem->wait_list))
 360:   e1550003        cmp     r5, r3
 364:   0a00002b        beq     418 <__up_write+0xfc>
        /* if we are allowed to wake writers try to grant a single write lock
         * if there's a writer at the front of the queue
         * - we leave the 'waiting count' incremented to signify potential
         *   contention
         */
        if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
 368:   e593200c        ldr     r2, [r3, #12]
 36c:   e2124002        ands    r4, r2, #2
 370:   0a000006        beq     390 <__up_write+0x74>
 374:   ea000034        b       44c <__up_write+0x130>

The compiler picks different registers,

  r3/sl+r3, r5/r0, r6/r5 but the code is the same.

The 'rw_semaphore' is 

    struct rw_semaphore {
            __s32		activity;
            struct list_head	wait_list;
    };

So, the 'wait_list' is non-NULL, the rw_semaphore is non-NULL, but
'wait_list->next' is NULL.  This seems to be very consistent with this
'oops'.

It seems that the "ltree_lock" doesn't protect the use of the
ltree_lookup() versus insertions and deletions?  Ie, ltree_lookup() may
return non-NULL, but an interrupt/pagefault before a 'le->users +/- =
1;' may mean the node is released?  On a UP system, does 'spin_lock()'
actually do anything?  The rw_semaphore uses spin_lock_irqsave().
However, that doesn't make sense as I think this occurs mainly on a
ARM926 system.

The ARM926 systems do not have proper 'lock free' idioms like
'ldrex/strex' and they try to do atomic operations by locking
interrupts.  I think that UbiFs/UBI maybe called on a 'data fault' or
'program fault' (in user space) when memory pressure is present.  I have
seen this occur in some sound drivers where the data source is coming
from disk (or maybe the driver uses vmalloc() or something).  So I think
on occasion, the ltree_lookup() may not work or there is something weird
with the atomic primatives and data/page faults.

Fwiw,
Bill Pringlemeir.
