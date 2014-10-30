From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Oct 2014 07:45:29 -0700
Subject: [PATCH 06/10] ARM: OMAP2+: Show bootloader GPMC timings to allow
 configuring the .dts file
In-Reply-To: <545248FA.7040201@ti.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
 <1414628948-30702-7-git-send-email-tony@atomide.com>
 <545248FA.7040201@ti.com>
Message-ID: <20141030144529.GG2542@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [141030 07:21]:
> On 10/30/2014 02:29 AM, Tony Lindgren wrote:
> > +static void gpmc_cs_show_timings(int cs, const char *desc)
> > +{
> > +	gpmc_show_regs(cs, desc);
> > +
> > +	pr_info("gpmc cs%i access configuration:\n", cs);
> > +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
> > +	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
> > +	GPMC_GET_RAW(GPMC_CS_CONFIG1, 12, 13, "device-width");
> > +	GPMC_GET_RAW(GPMC_CS_CONFIG1, 16, 17, "wait-pin");
> > +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 21, 21, "wait-on-write");
> > +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 22, 22, "wait-on-read");
> > +	GPMC_GET_RAW_SHIFT(GPMC_CS_CONFIG1, 23, 24, 3, "burst-length");
> 
> how does this work with shift = 3?
> Possible values of burst length are
> 0 -> 4
> 1 -> 8
> 2 -> 16

Hmm sounds like a bug..

In general, if you a chance to test this patch with a few
devices that would be great. Assuming you have working timings
in the bootloader, just remove the gpmc,* entries temporarily
from the .dts file for a device, and see if the values printed
by this patch make sense. I've used this to generate the values
for the 2430sdp smc91x and zoom 8250 but I don't think I've tried
anything with a burst mode so far.

> Shouldn't all the above functions except gpmc_show_regs() be defined within #ifdef DEBUG?

Yes let's do that to avoid bloat. Let's do a warning if no timings
are specified so people know to enable DEBUG.

BTW, I'm hoping we can start using gpmc_probe_generic_child()
for all the devices and get rid of gpmc_probe_nand_child() and
gpmc_probe_onenand_child(). We can now use gpmc_cs_get_name()
to call helpers from gpmc_probe_generic_child() for NAND and
OneNAND if really needed.

Regards,

Tony
