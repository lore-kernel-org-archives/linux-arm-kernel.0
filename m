From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 2 Jan 2014 11:38:56 -0800
Subject: v3.13-rc6+ regression (ARM board)
In-Reply-To: <m3ppoatwn1.fsf@t19.piap.pl>
References: <m3mwjhux0e.fsf@t19.piap.pl> <20131231104511.GA9688@1wt.eu>
 <m3txdmu2ez.fsf@t19.piap.pl>
 <20140102101455.GG10158@pengutronix.de>
 <m3ppoatwn1.fsf@t19.piap.pl>
Message-ID: <CA+55aFyZ0EXYkHd-BhQo6K++qKJVPdGeDbFTVTs3pAPCHFUpOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 2, 2014 at 4:07 AM, Krzysztof Ha?asa <khalasa@piap.pl> wrote:
>
> This means these two commits don't like each other:
>
>     seqcount: Add lockdep functionality to seqcount/seqlock structures
>     sched_clock: Use seqcount instead of rolling our own

Does something like this fix it for you?

  --- a/kernel/time/sched_clock.c
  +++ b/kernel/time/sched_clock.c
  @@ -36,6 +36,7 @@ core_param(irqtime, irqtime, int, 0400);

   static struct clock_data cd = {
          .mult   = NSEC_PER_SEC / HZ,
  +       .seq = SEQCNT_ZERO(cd.seq),
   };

   static u64 __read_mostly sched_clock_mask;

(The above is not even compile-tested, because x86 doesn't use
GENERIC_SCHED_CLOCK. So I did the patch blindly, but I think you get
the idea..)

            Linus
