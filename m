From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Feb 2014 16:03:59 +0000
Subject: [PATCH v9 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <20140219113157.GG30457@arm.com>
References: <1390908022-10287-1-git-send-email-vijay.kilari@gmail.com>
 <1390908022-10287-2-git-send-email-vijay.kilari@gmail.com>
 <20140129105546.GC26622@mudshark.cambridge.arm.com>
 <CALicx6uw3En92GhrKpAoavzwwNKWR8C8hHcS5B+eyLX_dC0LBA@mail.gmail.com>
 <20140217130149.GA5856@arm.com>
 <CALicx6uHqyJ-n+b-zfua6P=UsJ+a2_2h-H6krx-DBJYWfF=7jg@mail.gmail.com>
 <20140218120249.GD11049@arm.com>
 <CALicx6v6=WdRPoZ-vcxf7zusooB5r1V9WnjBf3QjOiO7yik3sw@mail.gmail.com>
 <20140219113157.GG30457@arm.com>
Message-ID: <20140219160359.GB22252@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 11:31:57AM +0000, Catalin Marinas wrote:
> On Wed, Feb 19, 2014 at 04:44:05AM +0000, Vijay Kilari wrote:
> >  Reposted v10 version of patches which is rebased on 3.14-rc3 kernel.
> > Test results are as follows on v8 foundation model.
> > 
> >  vda: vda1 vda2
> > kgdb: Registered I/O driver kgdbts.
> > kgdbts:RUN plant and detach test
> > kgdbts:RUN sw breakpoint test
> > kgdbts:RUN bad memory access test
> > kgdbts:RUN singlestep test 1000 iterations
> > kgdbts:RUN singlestep [0/1000]
> > kgdbts:RUN singlestep [100/1000]
> > kgdbts:RUN singlestep [200/1000]
> > kgdbts:RUN singlestep [300/1000]
> > kgdbts:RUN singlestep [400/1000]
> > kgdbts:RUN singlestep [500/1000]
> > kgdbts:RUN singlestep [600/1000]
> > kgdbts:RUN singlestep [700/1000]
> > kgdbts:RUN singlestep [800/1000]
> > kgdbts:RUN singlestep [900/1000]
> > kgdbts:RUN do_fork for 100 breakpoints
> 
> OK, I eventually managed to reproduce this. But by running with two
> CPUs, I get (during the do_fork() tests):
> 
> BUG: scheduling while atomic: kworker/u8:0/6/0x00000002
> Modules linked in:
> CPU: 1 PID: 6 Comm: kworker/u8:0 Not tainted 3.14.0-rc3+ #306
> Workqueue: khelper __call_usermodehelper
> Call trace:
> [<ffffffc000087dbc>] dump_backtrace+0x0/0x12c
> [<ffffffc000087efc>] show_stack+0x14/0x1c
> [<ffffffc00043c224>] dump_stack+0x78/0xc4
> [<ffffffc000439b48>] __schedule_bug+0x40/0x54
> [<ffffffc00043d67c>] __schedule+0x514/0x604
> [<ffffffc00043d794>] schedule+0x28/0x78
> [<ffffffc00043cc90>] schedule_timeout+0x170/0x1bc
> [<ffffffc00043e16c>] wait_for_common+0xc0/0x14c
> [<ffffffc00043e280>] wait_for_completion_killable+0x14/0x28
> [<ffffffc0000942f8>] do_fork+0x158/0x2a8
> [<ffffffc000094478>] kernel_thread+0x30/0x38
> [<ffffffc0000a842c>] __call_usermodehelper+0x34/0xa8
> [<ffffffc0000ab300>] process_one_work+0x118/0x354
> [<ffffffc0000abfcc>] worker_thread+0x13c/0x3c0
> [<ffffffc0000b1e84>] kthread+0xd4/0xe8
> 
> 
> It gets much worse if I run with two CPUs and CONFIG_KGDB_KDB enabled
> (but fine with a single CPU).
> 
> So no need to post another series for now but please check the multi-CPU
> case as well and send a separate fix. I'll dig a bit on my side as well.

So far I'm done with the investigation. It looks to me like one of the
kgdb tests, kgdb core or the arm64 back-end (or maybe more than one) is
not SMP safe. The errors either appear or disappear based on the printks
I put through the kgdb test or other config options which I enable.

Could you please look into making the kgdb back-end SMP-safe?

Thanks.

-- 
Catalin
