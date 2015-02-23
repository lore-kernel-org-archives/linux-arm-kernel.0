From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 23 Feb 2015 13:13:55 +0100
Subject: [RESEND PATCH 2/2] arm: socfpga: Set share override bit of the
 l2 cache controller
In-Reply-To: <CAL_JsqKmbV69Q-hgnvnz-2+2T8k-Q+WcrFmewkfozKk06ZM7OA@mail.gmail.com>
References: <1424365606-19964-1-git-send-email-dinguyen@opensource.altera.com>
 <1424365606-19964-2-git-send-email-dinguyen@opensource.altera.com>
 <CAL_JsqKmbV69Q-hgnvnz-2+2T8k-Q+WcrFmewkfozKk06ZM7OA@mail.gmail.com>
Message-ID: <20150223121355.GA29491@Nokia-N900>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2015-02-19 12:13:13, Rob Herring wrote:
> On Thu, Feb 19, 2015 at 11:06 AM,  <dinguyen@opensource.altera.com> wrote:
> > From: Dinh Nguyen <dinguyen@opensource.altera.com>
> >
> > By not having bit 22 set in the PL310 Auxiliary Control register (shared
> > attribute override enable) has the side effect of transforming Normal
> > Shared Non-cacheable reads into Cacheable no-allocate reads.
> >
> > Coherent DMA buffers in Linux always have a Cacheable alias via the
> > kernel linear mapping and the processor can speculatively load cache
> > lines into the PL310 controller. With bit 22 cleared, Non-cacheable
> > reads would unexpectedly hit such cache lines leading to buffer
> > corruption.
> 
> You really should be doing this in your bootloader.
>

You mean... in all your bootloaders? Because there's more
than one.

And as both bootloaders need it, it makes sense to do it 
in kernel, afaict.
							Pavel
> >  DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
> >         .l2c_aux_val    = L310_AUX_CTRL_DATA_PREFETCH |
> > -                         L310_AUX_CTRL_INSTR_PREFETCH,
> > +                         L310_AUX_CTRL_INSTR_PREFETCH |
> > +                         L2C_AUX_CTRL_SHARED_OVERRIDE,
> >         .l2c_aux_mask   = ~0,
> >         .smp            = smp_ops(socfpga_smp_ops),
> >         .map_io         = socfpga_map_io,
> > --
> > 2.2.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
