From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 16 Jan 2017 18:40:43 +0100
Subject: [PATCH] rtc: sun6i: Switch to the external oscillator
In-Reply-To: <20170116161349.5btadrfmqbxhrb2c@lukather>
References: <20170116152148.27439-1-maxime.ripard@free-electrons.com>
 <20170116153959.7qhahevikxzai664@piout.net>
 <20170116161349.5btadrfmqbxhrb2c@lukather>
Message-ID: <20170116174043.hgqbnmdnsfbnxl3m@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/2017 at 17:13:49 +0100, Maxime Ripard wrote :
> On Mon, Jan 16, 2017 at 04:39:59PM +0100, Alexandre Belloni wrote:
> > On 16/01/2017 at 16:21:48 +0100, Maxime Ripard wrote :
> > > The RTC is clocked from either an internal, imprecise, oscillator or an
> > > external one, which is usually much more accurate.
> > > 
> > > The difference perceived between the time elapsed and the time reported by
> > > the RTC is in a 10% scale, which prevents the RTC from being useful at all.
> > > 
> > > Fortunately, the external oscillator is reported to be mandatory in the
> > > Allwinner datasheet, so we can just switch to it.
> > > 
> > 
> > Still, I'm wondering whether the external clock should be taken.
> > 
> > We've had issues with at91 and tegra where this external clock was
> > suddenly able to be stopped, breaking the RTC because the CCF was not
> > aware the RTC was using it.
> 
> That's a very good point...
> 
> > See:
> > http://patchwork.ozlabs.org/patch/502459/
> > http://patchwork.ozlabs.org/patch/714517/
> > 
> > Your reply can be that you don't care now and this has a low probability
> > and you'll handle the case when it happens and that will be fine.
> 
> This is a bit more complicated for us.
> 
> The internal oscillator is running at 667kHz, with a 30% accuracy. The
> external oscillator is supposed to run at 32768Hz, with a maximum
> tolerance of 50ppm.
> 
> The RTC has an internal mux, between the internal and external
> oscillators. If the internal is picked, a (variable) divider of 20 is
> applied by default.
> 
> The output of that mux is also one of the parent of many of our clocks
> in our main clock unit (for example the CPU one), so we need to have
> that parenthood relationship expressed. I guess we could rework the
> driver to first register the clock through the early clock probing
> stuff, and then have the rest of the RTC to probe.
> 
> However, we also need to do so while remaining backward compatible
> from a DT point of view.
> 
> I guess we could:
>   - Add the two oscillators to the DTSI, with their proper accuracy
>   - Put them both as parent clocks of the RTC node
>   - Split the clock part and the RTC part in the driver, and have the
>     clock part, if there is a clocks property in the node (which
>     covers the backward case), register the mux, and pick the clock
>     with the best accuracy. We don't change anything at the RTC level.
>   - Change the parent clock of the CCU for the RTC.
> 
> That would work for you?

That would definitively be better. If the 667kHz oscillator is not an
input to any other IP, you may as well register it directly from the
driver instead of representing it as a node.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
