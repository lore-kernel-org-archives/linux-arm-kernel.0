From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 Mar 2017 08:31:45 -0400 (EDT)
Subject: [PATCH 0/3] minitty: a minimal TTY layer alternative for embedded
 systems
In-Reply-To: <20170324065015.GA17226@kroah.com>
References: <20170323210304.2181-1-nicolas.pitre@linaro.org>
 <20170324065015.GA17226@kroah.com>
Message-ID: <alpine.LFD.2.20.1703240819370.2304@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Mar 2017, Greg Kroah-Hartman wrote:

> meta-comment, any reason you didn't cc: linux-serial at vger as well?

I didn't realize such a list even existed. I looked up "TTY LAYER" in 
the maintainer file.

> On Thu, Mar 23, 2017 at 05:03:01PM -0400, Nicolas Pitre wrote:
> > Many embedded systems don't need the full TTY layer support. Most of the
> > time, the TTY layer is only a conduit for outputting debugging messages
> > over a serial port. The TTY layer also implements many features that are
> > very unlikely to ever be used in such a setup. There is great potential
> > for both code and dynamic memory size reduction on small systems. This is
> > what this patch series is achieving.
> > 
> > The existing TTY code is quite large and complex. Trying to shrink it is
> > rather risky as the potential for breakage is non negligeable. Therefore,
> > the approach used here consists in the creation of the minimal code that
> > interface with the existing UART drivers and provide TTY-like character
> > devices to user space. When the regular TTY layer is disabled, then the
> > minitty layer replacement is proposed by Kconfig.
> > 
> > Of course, making it "mini" means there are limitations to what it does:
> > 
> > - This supports serial ports only. No VT's, no PTY's.
> > 
> > - The default n_tty line discipline is hardcoded and no other line
> >   discipline are supported.
> > 
> > - The line discipline features are not all implemented. Notably, XON/XOFF
> >   is currently not implemented (although this might not require a lot of
> >   code to do it).
> > 
> > - Hung-up state is not implemented.
> > 
> > - No error handling on RX bytes other than counting them.
> > 
> > - Behavior in the presence of overflows is most likely different from the
> >   full TTY code.
> > 
> > - Job control is currently not supported (this may change in the future and 
> >   be configurable).
> > 
> > But again, most small embedded systems simply don't need those things.
> 
> This is true, and I like the overall idea, but I don't like all of the
> code duplication.  Also, who is going to maintain this?  I'm not going
> to be able to even build it, let alone test it, for the systems I
> normally use, and now you have tagged me as maintaining it for forever
> :(

I'll maintain it.  Will put the needed entry in MAINTAINERS.

Why do you say you won't be able to build it? I didn't try but it is 
meant to build with any serial driver.

> > Here's some numbers using a minimal ARM config.
> > 
> > When CONFIG_TTY=y, the following files are linked into the kernel:
> > 
> >    text    data     bss     dec     hex filename
> >    8796     128       0    8924    22dc drivers/tty/n_tty.o
> >   12846     276      44   13166    336e drivers/tty/serial/serial_core.o
> >    4852     489      49    5390    150e drivers/tty/sysrq.o
> >    1376       0       0    1376     560 drivers/tty/tty_buffer.o
> >   13571     172     132   13875    3633 drivers/tty/tty_io.o
> >    3072       0       0    3072     c00 drivers/tty/tty_ioctl.o
> >    2457       2     120    2579     a13 drivers/tty/tty_ldisc.o
> >    1328       0       0    1328     530 drivers/tty/tty_ldsem.o
> >     316       0       0     316     13c drivers/tty/tty_mutex.o
> >    2516       0       0    2516     9d4 drivers/tty/tty_port.o
> >   51130    1067     345   52542    cd3e (TOTALS)
> > 
> > With CONFIG_TTY=n and CONFIG_MINITTY_SERIAL=y, the above is replaced by:
> > 
> >    text    data     bss     dec     hex filename
> >    8776       8     108    8892    22bc drivers/tty/serial/minitty_serial.o
> > 
> > That's it!  And the runtime buffer usage is much less as well.
> 
> Is there some way to just reorginize the existing code to get you almost
> this same size?  Make ptys and other line diciplines options to select,
> and slim down the io path by removing features there.
> 
> And that serial core looks huge from what you are showing is really
> needed, any way to slim that down by just making features in it
> configurable?
> 
> Again, I like the idea, but worry that with this change, we would have
> two different tty layers we have to maintain for the next 20+ years, and
> we have a hard time keeping one stable and working today :)

That's the crux of the argument: touching the current TTY layer is NOT 
going to help keeping it stable. Here, not only I did remove features, 
but the ones I kept were reimplemented to be much smaller and 
potentially less scalable and performant too.  The ultimate goal here is 
to have the smallest code possible with very simple locking and not 
necessarily the most scalable code. That in itself is contradictory with 
the regular TTY code and warrants a separate implementation. And because 
it is so small, it is much easier to understand and much easier to 
maintain.

Where code sharing made sense, I did factor out common parts already, 
such as the baudrate handling. I intend to do the same to add job 
control support.


Nicolas
