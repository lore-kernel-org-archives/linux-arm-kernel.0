From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 2 Nov 2009 10:29:09 +0100
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <771cded00911020122o3bb5cc96q957c8be1ce7cae46@mail.gmail.com>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
	<20091101205449.GT14091@buzzloop.caiaq.de>
	<20091101213343.GA31345@elf.ucw.cz>
	<20091101220341.GA16698@elf.ucw.cz>
	<771cded00911020122o3bb5cc96q957c8be1ce7cae46@mail.gmail.com>
Message-ID: <20091102092909.GW14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2009 at 05:22:30AM -0400, Haojian Zhuang wrote:
> >> > Ok, got it. The culprit is commit d2c37068 ("[ARM] pxa: initialize
> >> > default interrupt priority and use ICHP for IRQ handling"). Reverting it
> >> > make suspend/resume work again on my board.
> >> >
> >> > Haojian, Eric, could you have a look at this?
> >>
> >> Okay, patch is this one: I'll test reverting it shortly.
> >>
> >> commit d2c37068429b29d6549cf3486fc84b836689e122
> >> Author: Haojian Zhuang <haojian.zhuang@marvell.com>
> >> Date: ? Wed Aug 19 19:49:31 2009 +0800
> >>
> >> ? ? [ARM] pxa: initialize default interrupt priority and use ICHP for IRQ handling
> >>
> >> ? ? Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> >> ? ? Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> >
> > And yes, reverting it _does_ fix suspend on spitz.
> >
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Pavel
> 
> Em, it's not caused by the IRQ patch.
> 
> The kernel is blocked in resume path. When console is resumed, IRQ is
> already disabled and system is blocked. Actually, IRQ shouldn't be
> disabled at here. Up to now, I only find which patch will cause this
> issue. But I can't find the best solution on it. The patch with issue
> is pasted in below.
> 
> So this issue is only occused when console suspend is enabled. If you
> enable no_console_suspend in command, you won't meet this issue. It
> seems that it's caused by removing termios setting in
> uart_resume_port() in the below patch. If I add these code back, the
> issue doesn't occur any more.

Well no, not confirmed. I tested with no_console_suspend, and it still
hit me. And without too, btw.

Daniel
