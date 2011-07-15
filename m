From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 15 Jul 2011 17:34:50 +0200
Subject: [alsa-devel] [PATCH V2 06/10] ARM: mxs: add saif device
In-Reply-To: <CAA+hA=TtBrDoAMfv0fqj30_heEJuZJFH=QjTUG8zTys0G+vgvA@mail.gmail.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-7-git-send-email-b29396@freescale.com>
	<20110715133241.GG2021@pengutronix.de>
	<CAA+hA=TtBrDoAMfv0fqj30_heEJuZJFH=QjTUG8zTys0G+vgvA@mail.gmail.com>
Message-ID: <20110715153450.GA31640@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 11:02:36PM +0800, Dong Aisheng wrote:
> 2011/7/15 Wolfram Sang <w.sang@pengutronix.de>:
> >> +#define DIGCTRL_BASE_ADDR ? ? ?MX28_IO_ADDRESS(MX28_DIGCTL_BASE_ADDR)
> >> +
> >
> > Hmm, maybe define a function mx28_set_saif_clkmux(val)?
> >
> >> + ? ? mx28_add_saif(0);
> >> + ? ? mx28_add_saif(1);
> >> +
> >> + ? ? /*set the saif clk mux, both saif0/saif1 use saif0 clk*/
> >> + ? ? __raw_writel(0x2 << 10, DIGCTRL_BASE_ADDR);
> >
> > You might overwrite previous settings here. The hardcoded numbers need
> > defines, too.
> 
> It's correct.
> I'm originally going to do that when implement record because this
> setting may affect both
> machine driver and saif driver on recording.
> Since currently we only implement playback, so i just hardcode it.
> Do you think if that's ok?
> Or i need to do it now?

If you just do playback, do you need to mux SAIF1-clk to SAIF0-clk ? If not
(what I'd think), just leave changing DIGCTL out completely since the
reset-default for that register should work. If you do need changing DIGCTL,
some helper function like mentioned above would be better, I think.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110715/6fb7d837/attachment.sig>
