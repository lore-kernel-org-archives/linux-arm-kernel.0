From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 9 Nov 2018 09:07:45 -0800
Subject: [PATCH v2 0/5] serial: Finish sysrq on qcom_geni; fix sysrq vs.
 lockdep on 8250
In-Reply-To: <20181030221107.79758-1-dianders@chromium.org>
References: <20181030221107.79758-1-dianders@chromium.org>
Message-ID: <20181109170745.GC14151@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 03:11:02PM -0700, Douglas Anderson wrote:
> I started out this series trying to make sysrq work over the serial
> console on qcom_geni_serial, then fell into a rat's nest.
> 
> To solve the deadlock I faced when enabling sysrq I tried to borrow
> code from '8250_port.c' which avoided grabbing the port lock in
> console_write().  ...but since these days I try to run with lockdep on
> all the time, I found it caused an annoying lockdep splat (which I
> also reproduced on my rk3399 board).  ...so I instead changed my
> qcom_geni_serial solution to borrow code from 'msm_serial.c'
> 
> I wasn't super happy with the solution in 'msm_serial.c' though.  I
> don't like releasing the spinlock there.  Not only is it ugly but it
> means we are unlocking / re-locking _all the time_ even though sysrq
> characters are rare.  ...so I came up with what I think is a better
> solution and then implemented it for qcom_geni_serial.
> 
> Since I had a good way to test 8250-based UARTs, I also fixed that
> driver to use my new method.  When doing so, I ran into a missing
> include in serial_core.h.  NOTE: I didn't have a way to test
> msm_serial.c at all, so I didn't switch that (or all other serial
> drivers for that matter) to the new method.
> 
> NOTE: from a serial point of view v2 is the same as v1 but I've
> removed the extra kgdb-related patches and made it obvious that this
> is really for all sysrq, not just kgdb.  I've also generally tried to
> curate the CCs more properly.

Looks good, thanks for cleaning this up.  All now queued up.

greg k-h
