From: noodles@earth.li (Jonathan McDowell)
Date: Sat, 7 Aug 2010 14:03:54 +0100
Subject: [PATCH 07/11] [ARM] pxa/balloon3: Machine file cleanup
In-Reply-To: <201008062347.30423.marek.vasut@gmail.com>
References: <1280920933-3820-1-git-send-email-marek.vasut@gmail.com>
	<201008060949.29366.marek.vasut@gmail.com>
	<20100806195218.GU9577@earth.li>
	<201008062347.30423.marek.vasut@gmail.com>
Message-ID: <20100807130354.GV9577@earth.li>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 06, 2010 at 11:47:30PM +0200, Marek Vasut wrote:
> Dne P? 6. srpna 2010 21:52:18 Jonathan McDowell napsal(a):
> > On Fri, Aug 06, 2010 at 09:49:29AM +0200, Marek Vasut wrote:
> > > Dne P? 6. srpna 2010 01:25:06 Jonathan McDowell napsal(a):
> > > > On Wed, Aug 04, 2010 at 01:22:09PM +0200, Marek Vasut wrote: You
> > > > have put all of the pin definitions into balloon3_pin_config and
> > > > negated the work that was done to ensure that a single kernel
> > > > could run on different variants of the balloon3.
> > > 
> > > I have only this one, but read on.
> > 
> > I suspect you have a similar board to me; a double sided board
> > fairly well populated (sound, CF, USB host + slave, LCD). The
> > Lightwriter, for example, is a single sided board using fewer
> > peripherals. The CUED variant I believe is different again for their
> > needs.
> 
> That's just great.

I'll happily agree it's far from perfect; what I've suggested as an
improvement is either a board configuration register which would
indicate the features on the board, or potentially the use of device
tree when/if that hits. Until that point what we've got, while a kludge,
does allow a single kernel to run on all board types.

(In Balloon's defence a lack of probability is hardly unique to that
platform.)

> > > > If a feature isn't configured on the board you shouldn't
> > > > configure the MFPs for that feature.
> > > 
> > > That's not true. You should configure them as inputs. The big plan
> > > (in another patch) is to do this the same way colibri270 is done
> > > (balloon3 baseboard + expansion boards).
> > 
> > I don't have a copy of the PXA reference to hand, so I'm happy to
> > accept best practise is to set unused pins to be inputs. However the
> > changes in this patch don't do this and may end up setting some pins
> > that are used for something else to an unexpected output.
> 
> The changes in this patch should not screw up anything. If they do
> break something, it'll be eventually found out. Do you have any
> trouble with this patch on your board?

I don't envisage any problems with my board, which as I said is I
suspect identical to yours. Unfortunately I'm currently at DebConf and
so don't have any access to it to confirm. My worry is about the boards
I don't have but know exist.

> > I'm failing to understand the motivation for these changes,
> > especially if you have a plan to later do more appropriate cleanup.
> 
> Because you can't do everything at once. I prepared the ground for
> further changes.

Let me be clear about the bits of this patch I have a problem with; I'm
fully in favour of the bits that wrap up config in CONFIG_[FEATURE].
It's the removal of doing the pxa2xx_mfp_config based on the
balloon3_has feature bits that I think is mistaken.

> I wonder why noone actually sent a better patch ever since balloon3
> was pushed mainline ... that's like 15 kernel versions already, isn't
> it?

The base balloon3 support patch didn't go in to Eric's devel tree until
September; 2.6.32 is the first release with it present.

With regards to the out of tree patches that haven't been pushed that's
largely due to a complete lack of time on my part; getting the base
support in took a lot longer than I expected and there have also been
VHDL changes I haven't had a chance to fully discuss with the author to
determine the effect on existing patches. It's great you've picked up
this work, but please don't think there's any lack of desire to get
things pushed upstream; it mostly comes down to a lack of manpower.

J.

-- 
/-\                             |   Mac system message: Like, dude,
|@/  Debian GNU/Linux Developer |        something went wrong.
\-                              |
