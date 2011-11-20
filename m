From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 20 Nov 2011 12:28:09 +0100
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <20111117141706.GI4748@arm.com>
References: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111117141706.GI4748@arm.com>
Message-ID: <20111120112809.GZ30612@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 02:17:06PM +0000, Catalin Marinas wrote:
> On Thu, Nov 17, 2011 at 01:40:00PM +0000, Uwe Kleine-K?nig wrote:
> > The linker places the unwind tables in readonly sections. So when using
> > an XIP kernel these are located in ROM and cannot be modified.
> > 
> > For that reason don't convert the symbol addresses during boot (or
> > module loading) but only when interpreting them in search_index().
> > Moreover several consts are added to catch future writes and rename the
> > member "addr" of struct unwind_idx to "addr_offset" to better match the
> > new semantic.
> > 
> > This fixes unwinding on XIP which compared prel31 offsets to absolute
> > addresses because the initial conversion from prel31 to absolute failed.
> 
> My only worry - does this increase the index search by doing the prel31
> conversion every time? It could affect tools like lockdep that need to
> get the backtrace regularly at run-time.
I did a first test now using 

	static int __init unwind_test(void)
	{
	      unsigned long flags;
	      u64 start, end;
	      register unsigned long current_sp asm ("sp");
	      int i;

	      struct stackframe init_frame;

	      init_frame.fp = (unsigned long)__builtin_frame_address(0);
	      init_frame.sp = current_sp;
	      init_frame.lr = (unsigned long)__builtin_return_address(0);
	      init_frame.pc = (unsigned long)unwind_test;

	      local_irq_save(flags);
	      start = timestamp();
	      for (i = 0; i < 100; ++i) {
		      struct stackframe frame = init_frame;
		      while (!unwind_frame(&frame));
	      }
	      end = timestamp();
	      local_irq_restore(flags);

	      pr_info("%s: ************************ unwind test took %llu\n",
			      __func__, (unsigned long long)(end - start));
	      return 0;
	}
	late_initcall(unwind_test);

where timestamp reads and returns the value of a cpu counter on an mx35
machine.

The increase in runtime of my patch is@approx 7% for the above test
case.

I will try later to optimise a bit more as I wrote earlier in this
thread.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
