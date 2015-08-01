From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 1 Aug 2015 11:18:30 +0200
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: dts: sun7i: Add dts file for
 Wits Pro A20 DKT
In-Reply-To: <55BBB840.80107@redhat.com>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
 <1438333194-21181-6-git-send-email-hdegoede@redhat.com>
 <20150731102028.GE2564@lukather>
 <CAGb2v65TEogqYFAfen1VnOaiepvez5t8Oh+Q=OYsRS_aZUMO3A@mail.gmail.com>
 <20150731165655.GG2564@lukather> <55BBB840.80107@redhat.com>
Message-ID: <20150801091830.GV2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 08:02:40PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 31-07-15 18:56, Maxime Ripard wrote:
> >On Fri, Jul 31, 2015 at 06:25:29PM +0800, Chen-Yu Tsai wrote:
> >>>Note that it's a bit of a pain for now to support such cases, as
> >>>there's nothing to tie something from the DT to an SDIO device. I
> >>>don't have a better solution than marking it always-on at the moment,
> >>>with a big FIXME comment on top... :/
> >>
> >>One could use the mmc-pwr-seq stuff. I don't know if it has been
> >>extended for multiple GPIOs, not that you would need it in this use
> >>case.
> >
> >It doesn't really improve the situation. It doesn't handle the
> >regulators,
> 
> The regulator(s) are already handled by the vmmc and vqmcc regulators
> of the mmc controller binding.

Except that vmmc and vqmmc are regulators to power up the SD bus
itself, not the chip at the other end.

> If more regulators are needed, we can easily extend mmc-pwrseq-simple
> to support them, or define a whole new powerseq driver.
> 
> > it doesn't allow the real driver to get its resources
> >either, basically, it's just a hack.
> 
> Not involving the real driver is by design really, the real driver
> cannot bind / have its probe function called until its sdio interface
> has been probed which is where the pwrseq driver comes in.

Except that you might need to handle these resources later on, to shut
down or change the voltage or current of its regulator, adjust a clock
rate, whatever, which is clearly not possible right now. The only
thing that it allows is to setup the resources we want beside the
drivers back, even though he's the more knowledgeable about how to
manage its resources.

And the fact that it doesn't enumerate until some resources have been
enabled is not really an argument. Writing to memory-mapped devices
without enabling the clocks or the power domain first generates aborts
on some SoCs, yet the driver is still the one in charge of its
resources.

> This also allows re-using existing sdio drivers without needing
> them to be aware of certain board perculiarities

I don't really get what the board does here. reg-on, vbat and so on is
this case are pins of the WiFi chip. It doesn't change from one board
to another.

What does change is what these pins are tied to, but we do already
have a way to abstract that for every devices. Only the SDIO devices
seem to be special.

> If a special power on (or suspend) order is nescessary a custom
> pwrseq driver can be created for this, even one which is meant
> to work in tandem with a specific sdio device driver. The idea
> is that the device driver will ask the mmc core to powerdown the
> device for powersaving in certain cases (e.g. suspend) and then
> the mmc core will call into the powerseq driver.

Which effectively duplicate the logic between the real driver and a
power-seq one.

> Granted there may be more complex scenarios where thighter control
> over the resources is needed, but for now this seems to work really
> well and it is much better then the deadlock we had before were
> all solutions were shot down as not flexible enough.

I know.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150801/5d0fab97/attachment.sig>
