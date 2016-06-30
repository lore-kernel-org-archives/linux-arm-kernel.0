From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Jun 2016 19:54:56 +0200
Subject: Boot failure on emev2/kzm9d (was: Re: [PATCH v2 11/11] mm/slab:
 lockless decision to grow cache)
In-Reply-To: <20160630165248.GB4650@linux.vnet.ibm.com>
References: <CAMuHMdVqNV5ZbR3_NV5ZsLxoNQUXXGpfAcaoMJffaJbRPUb6-A@mail.gmail.com>
 <20160629164415.GG4650@linux.vnet.ibm.com>
 <CAMuHMdUfQ-gBqjZGvawf5zxgb-0UnWb+fzD-kcWU+kavwvadgQ@mail.gmail.com>
 <20160629181208.GP4650@linux.vnet.ibm.com>
 <20160630074710.GC30114@js1304-P5Q-DELUXE>
 <CAMuHMdVx4p9=CNCwZuuUyxsYZGN7VPs7F+RbysQjYGSY25TPQA@mail.gmail.com>
 <20160630132401.GT4650@linux.vnet.ibm.com>
 <CAMuHMdVTX3ojMsO5Mv++pA5r+st4yBTTo39QTbV-FxPmJ7fbkQ@mail.gmail.com>
 <20160630151838.GW4650@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1606301752410.6474@ayla.of.borg>
 <20160630165248.GB4650@linux.vnet.ibm.com>
Message-ID: <CAMuHMdVRpbVSJmVqqwEiZUJq+q5vt6Me+O72i_8Y2pAPtkLY7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, Jun 30, 2016 at 6:52 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Thu, Jun 30, 2016 at 05:53:42PM +0200, Geert Uytterhoeven wrote:
>> +void rcu_dump_rcu_sched_tree(void)
>> +{
>> +     struct rcu_head rh;
>> +     unsigned long flags;
>> +
>> +     rcu_dump_rcu_node_tree(&rcu_sched_state);  /* Initial state. */
>> +     local_irq_save(flags);
>> +     // call_rcu(&rh, do_nothing_cb);
>> +     local_irq_restore(flags);
>> +     // schedule_timeout_uninterruptible(5 * HZ);  /* Or whatever delay. */
>> +     rcu_dump_rcu_node_tree(&rcu_sched_state); /* GP state. */
>> +     //synchronize_sched();  /* Probably hangs. */
>> +     //rcu_barrier();  /* Drop RCU's references to rh before return. */
>> +}

>>
>> When enabling any of the 4 commented-out lines in rcu_dump_rcu_sched_tree(),
>> it will lock up.
>
> OK, but that includes schedule_timeout_uninterruptible(5 * HZ), right?

Yes it does.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
