From: richard@nod.at (Richard Weinberger)
Date: Tue, 04 Feb 2014 21:07:03 +0100
Subject: UBI leb_write_unlock NULL pointer Oops (continuation) on ARM926
In-Reply-To: <87ha8e3b34.fsf@nbsps.com>
References: <D7B1B5F4F3F27A4CB073BF422331203F2A18997F1F@Exchange1.lawo.de>	<CAFLxGvya5WXoKcYmOgeM_SmVVEht1jEzeLG9vHhwFudFU+Ny8A@mail.gmail.com>	<D7B1B5F4F3F27A4CB073BF422331203F2A18997F8B@Exchange1.lawo.de>	<52EF772D.8080207@nod.at>	<D7B1B5F4F3F27A4CB073BF422331203F2A18DD7989@Exchange1.lawo.de>	<52EF9FFE.4020405@nod.at>	<1391498545.1795.29.camel@sauron.fi.intel.com>	<52F09AC9.6090604@nod.at>	<1391500492.1795.36.camel@sauron.fi.intel.com>	<878utq51b4.fsf@nbsps.com>
 <874n4e4xml.fsf@nbsps.com> <87ha8e3b34.fsf@nbsps.com>
Message-ID: <52F14867.8010602@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.02.2014 20:57, schrieb Bill Pringlemeir:
> On  4 Feb 2014, bpringlemeir at nbsps.com wrote:
> 
>> http://lists.infradead.org/pipermail/linux-mtd/2013-May/046907.html
>>
>> at91sam9g20 - arm926, different MTD driver. Linux 3.6.9
>>
>> Code: e5903004 e58d2004 e1560003 0a00002a (e593200c)
>>
>> 0:   e5903004        ldr     r3, [r0, #4]
>> 4:   e58d2004        str     r2, [sp, #4]
>> 8:   e1560003        cmp     r6, r3
>> c:   0a00002a        beq     0xbc
>> 10:   e593200c        ldr     r2, [r3, #12]
>>
>> The code sequence looks identical and the Oops trace, etc is the same.
>> People from Pengutronix also indicated seeing the same type of Opps; I
>> think they deal with the IMX, but maybe this was on another board.
> 
>>>>> schrieb Wiedemer, Thorsten (Lawo AG):
> 
>> Ehmm, OK, OK, even with the changes in kernel, ubi_assert() in
>> leb_write_unlock() wouldn't have triggered ...
> 
> Another up_read() crash,
> 
>  http://lists.infradead.org/pipermail/linux-mtd/2013-July/047512.html
> 
>  Code: e1530001 0a000016 e3e01000 e5801000 (e8930003)
> 
>  00000000 <.data>:
>     0:   e1530001        cmp     r3, r1
>     4:   0a000016        beq     0x64
>     8:   e3e01000        mvn     r1, #0
>     c:   e5801000        str     r1, [r0]
>    10:   e8930003        ldm     r3, {r0, r1}
> 
> Thorsten's Oops,
> 
>  Code: e3e02000 e5842000 e59fc084 e59f0084 (e8930006)
> 
>  00000000 <.data>:
>     0:   e3e02000        mvn     r2, #0
>     4:   e5842000        str     r2, [r4]
>     8:   e59fc084        ldr     ip, [pc, #132]  ; 0x94
>     c:   e59f0084        ldr     r0, [pc, #132]  ; 0x98
>    10:   e8930006        ldm     r3, {r1, r2}
> 
> The registers are different, but the instruction sequence is similar.
> In my ARM926 build, the __up_read() is,
> 
> static inline int list_empty(const struct list_head *head)
> {
>         return head->next == head;
>  250:   e1a01000        mov     r1, r0
>  254:   e5b12004        ldr     r2, [r1, #4]!
>  258:   e1520001        cmp     r2, r1
>  25c:   0a000017        beq     2c0 <__up_read+0xb0>
> __rwsem_wake_one_writer(struct rw_semaphore *sem)
> {
>         struct rwsem_waiter *waiter;
>         struct task_struct *tsk;
> 
>         sem->activity = -1;
>  260:   e3e01000        mvn     r1, #0
>  264:   e5801000        str     r1, [r0]
>  * in an undefined state.
>  */
> #ifndef CONFIG_DEBUG_LIST
> static inline void list_del(struct list_head *entry)
> {
>         __list_del(entry->prev, entry->next);
>  268:   e8920003        ldm     r2, {r0, r1}
>  * This is only for internal list manipulation where we know
>  * the prev/next entries already!
>  */
> static inline void __list_del(struct list_head * prev, struct list_head * next)
> {
>         next->prev = prev;
>  26c:   e5801004        str     r1, [r0, #4]
>         prev->next = next;
>  270:   e5810000        str     r0, [r1]
> 
> 
> This is the same symptom,
> 
>   __rwsem_wake_one_writer(struct rw_semaphore *sem)
>   {
> ...
> 	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
> 	list_del(&waiter->list);
> 
> The sem->wait_list is non-NULL, but the 'sem->wait_list.next' is NULL. I
> would suggest you try with 'DEBUG_LOCK_ALLOC' or something like this.
> The crash points are not the failure, it is when we insert a
> rw_semaphore of 'NULL' or use some memory that is already freed.

CONFIG_DEBUG_LIST please.

Thanks,
//richard
