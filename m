From: pavel@denx.de (Pavel Machek)
Date: Wed, 21 Aug 2013 21:07:29 +0200
Subject: [PATCHv2 2/2] clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <CACRpkda9oyb2mr6PR1dfMpoxbzj3vUp7hKiQtN1oWH6aG_N96w@mail.gmail.com>
References: <1376522956-14960-1-git-send-email-dinguyen@altera.com>
 <1376522956-14960-2-git-send-email-dinguyen@altera.com>
 <CACRpkda9oyb2mr6PR1dfMpoxbzj3vUp7hKiQtN1oWH6aG_N96w@mail.gmail.com>
Message-ID: <20130821190729.GA9657@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2013-08-21 09:04:07, Linus Walleij wrote:
> On Thu, Aug 15, 2013 at 1:29 AM,  <dinguyen@altera.com> wrote:
> 
> > -       sched_io_base = iobase + 0x04;
> > +       sched_io_base = iobase;
> >         sched_rate = rate;
> >  }
> >
> >  static u32 read_sched_clock(void)
> >  {
> > -       return __raw_readl(sched_io_base);
> > +       return ~__raw_readl(sched_io_base + 0x4);
> 
> So what about #define what 0x04 is?
> 
> #define MY_FOO_REGISTER_OFFSET 0x04
> 
> raw_readl(sched_io_base + MY_FOO_REGISTER_OFFSET);

That define is already there, #define APBTMR_N_CURRENT_VALUE 0x04, but
it is in .c file, not in header.

Actually I believe I had patch that did that, and it was even applied,
but it clashed with same other patches, and was dropped. (It is below,
for reference).

Currently, the code _does not work_, and we have three platforms using
it. It would be good to solve this now, and polish it later.

								Pavel
