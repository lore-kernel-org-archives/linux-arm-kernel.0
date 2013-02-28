From: walken@google.com (Michel Lespinasse)
Date: Thu, 28 Feb 2013 19:34:31 +0800
Subject: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
In-Reply-To: <20130227192551.GA8333@redhat.com>
References: <51226F91.7000108@linux.vnet.ibm.com>
 <CACvQF53bdh4_BxF0y1fnTVR+T2OmRc0jmWQYftsvx92-fg-Lug@mail.gmail.com>
 <512BBAD8.8010006@linux.vnet.ibm.com>
 <CACvQF51jCxk5jUqmhD=QBBtUsBkQWZzakacrKO4Gsk=w61rNwQ@mail.gmail.com>
 <512C7A38.8060906@linux.vnet.ibm.com>
 <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CANN689FuuEb9wpV43DkTtgv6syvBYL-LQxByWznyAq8dkrhzBw@mail.gmail.com>
 <20130227192551.GA8333@redhat.com>
Message-ID: <CANN689EhqoQAKALR7WhT3YrQh3=VDA2Dq3QX1yLuYU_gZAo_Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 3:25 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 02/27, Michel Lespinasse wrote:
>>
>> +void lg_rwlock_local_read_lock(struct lgrwlock *lgrw)
>> +{
>> +       preempt_disable();
>> +
>> +       if (__this_cpu_read(*lgrw->local_refcnt) ||
>> +           arch_spin_trylock(this_cpu_ptr(lgrw->lglock->lock))) {
>> +               __this_cpu_inc(*lgrw->local_refcnt);
>
> Please look at __this_cpu_generic_to_op(). You need this_cpu_inc()
> to avoid the race with irs. The same for _read_unlock.

Hmmm, I was thinking that this was safe because while interrupts might
modify local_refcnt to acquire a nested read lock, they are expected
to release that lock as well which would set local_refcnt back to its
original value ???

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
