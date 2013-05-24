From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 24 May 2013 12:53:38 -0400
Subject: [PATCH 2/2] net: mv643xx_eth: proper initialization for
 Kirkwood SoCs
In-Reply-To: <519E9ADA.3040204@gmail.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
 <20130523160111.GP31290@titan.lakedaemon.net>
 <20130523171112.GB31281@obsidianresearch.com>
 <20130523172339.GQ31290@titan.lakedaemon.net>
 <20130523175357.GB2821@obsidianresearch.com>
 <20130523184028.GU31290@titan.lakedaemon.net>
 <519E9ADA.3040204@gmail.com>
Message-ID: <20130524165338.GW31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 12:40:26AM +0200, Sebastian Hesselbarth wrote:
> On 05/23/2013 08:40 PM, Jason Cooper wrote:
> >On Thu, May 23, 2013 at 11:53:57AM -0600, Jason Gunthorpe wrote:
> >>On Thu, May 23, 2013 at 01:23:39PM -0400, Jason Cooper wrote:
> >>>Shouldn't it rather be
> >>>
> >>>	compatible = "marvell,kirkwood-eth", "marvell,orion-eth";
> >>
> >>Not sure about orion-eth?

Sorry, yep, one or the other.

> Jason, Jason,

For a second, I read this as "tsk tsk tsk..." ;-)

> sorry I didn't came back to this conversation earlier. I already
> reworked the patch to rely on
> of_device_is_compatible(.."marvell,kirkwood-eth"..). This is a
> kirkwood only thing as other Orions cannot do clock gating or
> retain critcal register content (Dove). I will stick with orion-eth
> for all other and maybe introduce new compatible strings (and new
> fixes) as soon as issues surface.

Okay, as I mentioned to Jason, I would like to test 6282 before we
settle on this path.  Other than that, I'm fine with it.

> >>>I'm inclined to go with of_machine_is_compatible() since the only
> >>>concrete difference we know is that the tweak is needed on kirkwood and
> >>>nowhere else.
> >>
> >>But there is a larger problem here then just this one bit.
> >>
> >>The PSC1 register must be set properly for the board layout, and today
> >>we rely on the bootloader to set it. In fact, even with Sebastian's
> >>change the ethernet port won't work without bootloader
> >>intervention. The PortReset bit should also be cleared by the driver
> >>(and it is only present on some variants of this IP block,
> >>apparently).
> 
> Actually, fixing modular scenarios is only for the sake of multiarch
> someday. I don't see the point in running current kernel without eth
> compiled in _on a NAS SoC_ ;)

Good point, but if the eth can be gated to save power, we shouldn't
limit the user's ability just because the SoC is primarily in NAS's.

thx,

Jason.
