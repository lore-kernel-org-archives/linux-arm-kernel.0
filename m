From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Oct 2017 14:56:21 +0100
Subject: [PATCH] rtc: armada38x: add support for trimming the RTC
In-Reply-To: <20171003132433.vkgjxuoeq26x3f47@piout.net>
References: <E1dxsSB-0006RM-08@rmk-PC.armlinux.org.uk>
 <20171003132433.vkgjxuoeq26x3f47@piout.net>
Message-ID: <20171003135620.GN20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 03:24:33PM +0200, Alexandre Belloni wrote:
> Hi Russell,
> 
> On 29/09/2017 at 11:23:31 +0100, Russell King wrote:
> > +/*
> > + * The information given in the Armada 388 functional spec is complex.
> > + * They give two different formulas for calculating the offset value,
> > + * but when considering "Offset" as an 8-bit signed integer, they both
> > + * reduce down to (we shall rename "Offset" as "val" here):
> > + *
> > + *   val = (f_ideal / f_measured - 1) / resolution   where f_ideal = 32768
> > + *
> > + * Converting to time, f = 1/t:
> > + *   val = (t_measured / t_ideal - 1) / resolution   where t_ideal = 1/32768
> > + *
> > + *   =>  t_measured / t_ideal = val * resolution + 1
> > + *
> > + * "offset" in the RTC interface is defined as:
> > + *   t = t0 * (1 + offset * 1e-9)
> > + * where t is the desired period, t0 is the measured period with a zero
> > + * offset, which is t_measured above. With t0 = t_measured and t = t_ideal,
> > + *   offset = (t_ideal / t_measured - 1) / 1e-9
> > + *
> > + *   => t_ideal / t_measured = offset * 1e-9 + 1
> > + *
> > + * so:
> > + *
> > + *   offset * 1e-9 + 1 = 1 / (val * resolution + 1)
> > + *
> > + * We want "resolution" to be an integer, so resolution = R * 1e-9, giving
> > + *   offset = 1e18 / (val * R + 1e9) - 1e9
> > + *   val = (1e18 / (offset + 1e9) - 1e9) / R
> > + * with a common transformation:
> > + *   f(x) = 1e18 / (x + 1e9) - 1e9
> > + *   offset = f(val * R)
> > + *   val = f(offset) / R
> > + *
> > + * Armada 38x supports two modes, fine mode (954ppb) and coarse mode (3815ppb).
> > + */
> > +static long armada38x_ppb_convert(long ppb)
> > +{
> > +	long div = ppb + 1000000000L;
> > +
> > +	return div_s64(1000000000000000000LL + div / 2, div) - 1000000000L;
> 
> The previous comment is perfect but it was not completely obvious to me
> why you are adding div / 2. Maybe you can add a small comment.

It's the standard way to turn a regular integer division into one which
rounds-to-closest - I consider it to be one of the basics which every
programmer should know, and therefore should be obvious.

Integer division in the form of:

	r = (a + b / 2) / b

should be part of the programmers basic knowledge set.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
