From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 15 Jun 2018 17:12:26 +0200
Subject: [PATCH v3 6/7] mmc: sunxi: Add runtime_pm support
In-Reply-To: <CAOi56cX4B=meWmRJz=qvmpxooiWQ+fADRZ4pSd=iimTiWUdRAw@mail.gmail.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
 <4514368de4ef7b4224be455f2d9e6090b464e819.1523888566.git-series.maxime.ripard@bootlin.com>
 <1caa07d2-17ad-18aa-9216-037c06b36281@arm.com>
 <CAPDyKFqc-+cr64DW0r_2V_vM=r45CuFrx5z4_fYf=sebb5EfQg@mail.gmail.com>
 <CAOi56cX4B=meWmRJz=qvmpxooiWQ+fADRZ4pSd=iimTiWUdRAw@mail.gmail.com>
Message-ID: <20180615151226.6752hykfyr367qho@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 07:45:03AM -0700, Kevin Hilman wrote:
> > >
> > > With a working kernel, I see SATA and the wifi SDIO being probed.
> > >
> > > Happy to help testing stuff if you have any idea.
> >
> > In principle I would start with avoiding having the sunxi-mmc driver
> > to probe. Or bail out early in probe, whichever is the easiest for
> > you.
> >
> > The point is, if the sunxi-mmc driver doesn't even enable its clock,
> > it would be interesting to see if there are other that depends on it.
> >
> > One could also play with clk_disable_unused(), the
> > late_initcall_sync(), which can be turned off with the module
> > parameter "clk_ignore_unused".
> 
> I added clk_ignore_unused to the kernel command-line, and that didn't
> help, so it's not just an init-time clock that's causing the problem.
> 
> > Anyway, to hide/fix the problem for now, we could add a call to
> > pm_runtime_get_noresume() before the sunxi-driver calls
> > pm_runtime_enable().
> 
> I tried that and it makes the kernel finish booting, so that smells
> definitely like the MMC is disabling a clock when it goes idle that
> some other device (or CPU) depends on.

I quickly looked at the A10 and A20 clock driver and I have not seen
any obvious mishap.

If you have ftrace enabled, could you add the trace_clk_disable*
events (along with tp_printk since the kernel seems to break the
entire boot).

That will allow us to see which clock is disabled and shouldn't.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180615/9d42e687/attachment.sig>
