From: sean@mess.org (Sean Young)
Date: Fri, 13 Apr 2018 10:40:05 +0100
Subject: [PATCH 15/17] media: st_rc: Don't stay on an IRQ handler forever
In-Reply-To: <20180413060646.25b8a19d@vento.lan>
References: <d20ab7176b2af82d6b679211edb5f151629d4033.1523546545.git.mchehab@s-opensource.com>
 <16b1993cde965edc096f0833091002dd05d4da7f.1523546545.git.mchehab@s-opensource.com>
 <20180412222132.z7g5enhin2uodbk7@gofer.mess.org>
 <20180413060646.25b8a19d@vento.lan>
Message-ID: <20180413094005.wudyd2y5efaeimg3@gofer.mess.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2018 at 06:06:46AM -0300, Mauro Carvalho Chehab wrote:
> Hi Sean,
> 
> Em Thu, 12 Apr 2018 23:21:32 +0100
> Sean Young <sean@mess.org> escreveu:
> 
> > On Thu, Apr 12, 2018 at 11:24:07AM -0400, Mauro Carvalho Chehab wrote:
> > > As warned by smatch:
> > > 	drivers/media/rc/st_rc.c:110 st_rc_rx_interrupt() warn: this loop depends on readl() succeeding
> > > 
> > > If something goes wrong at readl(), the logic will stay there
> > > inside an IRQ code forever. This is not the nicest thing to
> > > do :-)
> > > 
> > > So, add a timeout there, preventing staying inside the IRQ
> > > for more than 10ms.  
> > 
> > If we knew how large the fifo was, then we could limit the loop to that many
> > iterations (maybe a few extra in case IR arrives while we a reading, but
> > IR is much slower than a cpu executing this loop of course).
> 
> IR is slower, but this code is called at IRQ time, e. g. when the
> controller already received the IR data. Also, it reads directly
> via a memory mapped register, with should be fast.

There is a chance that a new IR edge occurs whilst reading the fifo. All of
this is academic since we don't know the size of the fifo.

> I suspect that
> 10ms is a lot more time than what would be required to go though
> all the FIFO data.

10ms seems far too much. The serial_ir prints a warning if it loops more
than 255 times (and breaks out of the loop). Since we don't know the size
of the fifo, that will be more than enough. We could also limit it to 
512 times, since the raw IR kfifo is 512 and any more than that would
not fit in the kfifo anyway. This would exit much quicker than 10ms.

At least winbond-cir has a similar loop, there might be other drivers.

Thanks
Sean
