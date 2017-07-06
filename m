From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 6 Jul 2017 18:08:31 +0200
Subject: [PATCH v2 6/9] clk: at91: clk-generated: make gclk determine
 audio_pll rate
In-Reply-To: <ab11f002-b761-cdb4-eb0c-ce24dcb9c5d4@microchip.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
 <20170704115927.32662-7-quentin.schulz@free-electrons.com>
 <ab11f002-b761-cdb4-eb0c-ce24dcb9c5d4@microchip.com>
Message-ID: <20170706160831.4ire6kbfqswo337d@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2017 at 17:29:22 +0200, Nicolas Ferre wrote:
> > +	/*
> > +	 * The audio_pll rate can be modified, unlike the five others clocks
> > +	 * that should never be altered.
> > +	 * The audio_pll can technically be used by multiple consumers. However,
> > +	 * with the rate locking, the first consumer to enable to clock will be
> > +	 * the one definitely setting the rate of the clock.
> > +	 * Since audio IPs are most likely to request the same rate, we enforce
> > +	 * that the only clks able to modify gck rate are those of audio IPs.
> > +	 */
> > +
> > +	if (gck->id != GCK_ID_SSC0 && gck->id != GCK_ID_SSC1 &&
> > +	    gck->id != GCK_ID_I2S0 && gck->id != GCK_ID_I2S1 &&
> > +	    gck->id != GCK_ID_CLASSD)
> > +		goto end;
> 
> ...well... maybe for a temporary solution, but what about the next
> product that will also have such feature but without the same set of IDs?
> 

It will have a different compatible and that can be used to encode the
difference.

> I know that the main use of this clock is the "audio" subsystem (so its
> name) but in a machine without audio needs, it can be interesting to use
> this fractional PLL for other devices that can handle a GCK (and I'm
> thinking about the SDHCI interface that then could be configured with
> maximum clock speed).
> 
> > +	parent = clk_hw_get_parent_by_index(hw, GCK_INDEX_DT_AUDIO_PLL);
> > +	if (!parent)
> > +		goto end;
> 
> Here, if the audio pll id changes in the DT, we don't retrieve the
> proper parent... And again, not very future proof.
> 

One more reason to remove all the crap we have in the DT, as suggested
by RobH.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
