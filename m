From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu, 18 Aug 2016 07:33:19 +0000
Subject: [PATCH v3 1/4] ARM: davinci: da8xx-dt: Add ti-aemif lookup for
 clock matching
In-Reply-To: <9e47844e-413b-4f85-5fbc-6b73cdd7fade@ti.com>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
 <20160816223338.20776-2-kbeldan@baylibre.com>
 <9e47844e-413b-4f85-5fbc-6b73cdd7fade@ti.com>
Message-ID: <20160818073319.GA18481@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 08:15:41PM +0530, Sekhar Nori wrote:
> On Wednesday 17 August 2016 04:03 AM, Karl Beldan wrote:
> > Many davinci boards (da830 and da850 families) don't have their clocks
> > in DT yet and won't be successful in getting an unnamed aemif clock
> 
> Actually none of DaVinci platforms have clocks in DT yet.
> 

Indeed, I haven't got used to the TI platforms, I mistook some omap SoCs
for davinci ones.

> > without explicitly registering them via clk_lookups, failing the
> > ti-aemif memory driver probe.
> 
> I am happy with the patch itself. But I think the terminology used in
> the commit message can be made more accurate. clk_get() does not look up
> a clock by name. It looks up a clock by consumer device and a consumer
> id (used for multiple clocks used by same consumer device). The AEMIF
> clock in DaVinci has a name already. Its assigned in da850.c as "aemif".
> But the clock name itself does not matter in clock lookup.
> 

I will be happy to send a more accurate comment, here is my case for the
record and the feedback, although I try to keep my distance from
comments of comments ;).

Checking clk_get:

struct clk *clk_get(struct device *dev, const char *con_id)
{       
	[...]
	if (dev) {
		struct clk *__of_clk_get_by_name(struct device_node *np,
						 const char *dev_id,
						 const char *name)
		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
		[...]
	}
	return clk_get_sys(dev_id, con_id);
}

In DT case the con_id _is_ the clock name, so the assertion "clk_get()
does not look up a clock by name" would be false ?
Also, numerous commits refer to *clk_get(*, NULL) as getting an unnamed
clock, although it only really is accurate to the point in DT cases.

> So, IMO, saying "won't be successful in getting an unnamed aemif clock"
> is inaccurate.
> 

You are right, it is innacurate, because in that case it won't try
getting such a clock, ie. by name. Instead it will resort to looking it
up by dev_id / con_id, connecting back with your point.

I will resend the series with this commit message reworded.

Rgds, 
Karl

> > The current aemif lookup entry resolving to the same clock:
> >     'CLK(NULL,               "aemif",        &aemif_clk)'
> > remains, as it is currently used (davinci_nand is getting a named clock
> > "aemif").
> 
> So the existing look-up does not recognize the AEMIF as a device (NULL
> device name) and is using a "global" consumer id to look-up
> "device-less" clocks. As you noted, this entry should remain for non-DT
> mode and for backward compatibility.
> 
> > This change will allow to switch from the mach-davinci aemif code to
> > the ti-aemif memory driver.
> > 
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> 
> Thanks,
> Sekhar
