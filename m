From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 19 Apr 2017 19:21:39 +0200
Subject: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
In-Reply-To: <20170419131341.76bc7634@gandalf.local.home>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
Message-ID: <20170419172139.hipylcdsarhvnsby@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 01:13:41PM -0400, Steven Rostedt wrote:
> On Thu, 21 Apr 2016 13:48:42 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > printk() takes some locks and could not be used a safe way in NMI context.
> 
> I just found a problem with this solution. It kills ftrace dumps from
> NMI context :-(
> 
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : do_raw_spin_lock <-_raw_spin_lock
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : sched_stat_runtime: comm=cc1 pid=67423 runtime=96858 [ns] vruntime=11924198270 [ns]
> [ 1295.168496]    <...>-67423  10dNh1 382171111us : lock_acquire: ffffffff81c5c940 read rcu_read_lock
> [ 1295.168497]
> [ 1295.168498] Lost 4890096 message(s)!
> [ 1296.805063] ---[ end Kernel panic - not syncing: Hard LOCKUP
> [ 1296.811553] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff81046fc7 (native_apic_msr_write+0x27/0x40)
> [ 1296.811553] Call Trace:
> [ 1296.811553]  <NMI>
> 
> I was hoping to see a cause of a hard lockup by enabling
> ftrace_dump_on_oops. But as NMIs now have a very small buffer that
> gets flushed, we need to find a new way to print out the full ftrace
> buffer over serial.
> 
> Thoughts?

early_printk ;-)
