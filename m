From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Oct 2018 13:18:23 +0100
Subject: [RESEND PATCH v3 3/3] sh: add the sh_ prefix to early platform
 symbols
In-Reply-To: <CAMuHMdWPPr56j3z4-eamtavt7cZ2jkKyE3W5_XiK1HNim8qXBg@mail.gmail.com>
References: <20180827090651.25062-1-brgl@bgdev.pl>
 <20180827090651.25062-4-brgl@bgdev.pl>
 <8636swude1.wl-marc.zyngier@arm.com>
 <CAMuHMdWPPr56j3z4-eamtavt7cZ2jkKyE3W5_XiK1HNim8qXBg@mail.gmail.com>
Message-ID: <861s8gua9c.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Tue, 23 Oct 2018 12:32:16 +0100,
Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> Hi Marc,
> 
> On Tue, Oct 23, 2018 at 1:11 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On Mon, 27 Aug 2018 10:06:51 +0100,
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > As for the whole "early device" debate, my take is that we'd be much
> > better off making the device model available early, rather than trying
> > to architect something that is simply papering over the issue.
> 
> The device model itself can be made available earlier, but the big
> blocker is mainly the use of everything related to the scheduler
> (threads, msleep()), which depends on the "early" timer.

I agree this is an annoying dependency, as I've myself been down that
particular rabbit hole... ;-)

> I think it can be made to work if msleep() and all thread-related
> functions would return -EPROBE_DEFER, but that should be handled in
> every single driver, which may be already the case for
> thread-related functions, but not for e.g. msleep(), which currently
> returns void.

That would be massively invasive...

One way of solving this would be to make the device model available
early, but then preserve the ordering required by other subsystems
such as the scheduler: interrupts, timers and clocks have to be
available first, as they are basically at the root of all
dependencies.

This is a different kind of "early" though, as having the device model
early means all its functionalities are available early, and that
includes being able to allocate DMA buffers, which some interrupt
controllers require. The current proposal doesn't help with DMA, and
still leaves these devices in a state where drivers have to reinvent
their own square wheel.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
