From: HenryC.Chen@mediatek.com (Henry Chen)
Date: Wed, 22 Jul 2015 22:31:34 +0800
Subject: [PATCH] regmap: Add function check before called format_val
In-Reply-To: <20150721172550.GY11162@sirena.org.uk>
References: <1437396110-5192-1-git-send-email-henryc.chen@mediatek.com>
 <20150720150254.GC11162@sirena.org.uk>
 <1437458845.30329.51.camel@mtksdaap41>
 <20150721172550.GY11162@sirena.org.uk>
Message-ID: <1437575494.30329.80.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-07-21 at 18:25 +0100, Mark Brown wrote:
> On Tue, Jul 21, 2015 at 02:07:25PM +0800, Henry Chen wrote:
> 
> > Then in driver rtc-mt6397.c, it used regmap_bulk_read() to get the time
> > of PMIC, and hit the null function of format_val(), because the
> > regmap_bus was null.
> 
> > It skipped the initialization of format_val() because bus == null, but
> > called the format_val() at regmap_bulk_read() if bus == null.
> 
> OK, so the issue here is that when we fall back to regmap_read() we may
> do so because we have reg_read() and reg_write() functions which in turn
> imply no formatting.  The expectation here is that val must be an array
> of int.  The code doesn't completely take that into account though and
> the user you're pointing at is assuming it's an array of 16 bit values
> which isn't totally unreasonable if it did specify val_bits (we don't
> check for that).
So, could I call regmap_bulk_read() on rtc-mt6307.c, should I need to
change it ?
> 
> > Maybe it was not the good fix for this, but should be a problem need to
> > be reported, or should I need to give the regmap_bus on mtk_pmic_wrap.c?
> 
> That file isn't in mainline...

oh...it's mtk-pmic-wrap.c, sorry about that.
> 
> memcpy() is definitely not a safe way to move from an unsigned int to a
> u16 which is what your specific use case is trying to do.  I'll need to
> do an audit of existing users (or someone else will!) to figure out what
> people are doing with .val_bits in drivers using reg_read() and
> reg_write() but I think what we should be doing here is probably
> providing appropriate conversion functions based on val_bits on init.

Ok, got it, memcpy() should not be used here anymore.

Thanks,
Henry
