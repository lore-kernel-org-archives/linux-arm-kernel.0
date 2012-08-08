From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Aug 2012 14:52:53 +0100
Subject: [PATCH 04/11] MFD: twl4030-audio: Add DT support
In-Reply-To: <50226CF4.1010202@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <20120808131356.GS16861@opensource.wolfsonmicro.com>
 <50226CF4.1010202@ti.com>
Message-ID: <20120808135253.GC16861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 04:43:16PM +0300, Peter Ujfalusi wrote:
> On 08/08/2012 04:13 PM, Mark Brown wrote:

> > This doesn't seem like something that should be in the CODEC driver
> > really, there's a general need for something which can unmute controls
> > at the end of the power up sequence and mute before power down.  Also,
> > if this is going to be part of the binding shouldn't we just omit the
> > first property and simply check for the presence of the property which
> > specifies the GPIO?

> The hs_extmute is used for reducing pop noise on the headset. The sequence is
> described in the TRM and it need to be done within the codec driver since it
> is within the sequence.

Is the point it's at in the sequence the end?

> >> +#ifdef CONFIG_OF
> >> +	if (of_find_node_by_name(node, "codec"))
> >> +		return true;
> >> +#endif

> > This really seems like we should be stubbing out of_find_node_by_name()
> > to return false in non-OF cases.

> Yes, most likely the of_find_node_by_name() deserves the same treatment as
> some selected of_* function in case CONFIG_OF is not selected.
> But at the moment this is not the case, we need to protect with ifdef since we
> might break other randconfigs where CONFIG_OF is not set.

We can always add a patch stubbing it out as part of the series, or in a
branch in the OF tree that we can pull in.

> 
> >> +#ifdef CONFIG_OF
> >> +	if (!of_property_read_u32(node, "ti,enable-vibra", &vibra) && vibra)
> >> +		return true;
> >> +#endif
> > 
> > Similarly here.
> 
> Here the ifdef is no needed. of_property_read_u32() return -ENOSYS in case
> CONFIG_OF is not selected.
> 
> -- 
> P?ter
