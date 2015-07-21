From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Jul 2015 18:25:50 +0100
Subject: [PATCH] regmap: Add function check before called format_val
In-Reply-To: <1437458845.30329.51.camel@mtksdaap41>
References: <1437396110-5192-1-git-send-email-henryc.chen@mediatek.com>
 <20150720150254.GC11162@sirena.org.uk>
 <1437458845.30329.51.camel@mtksdaap41>
Message-ID: <20150721172550.GY11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 02:07:25PM +0800, Henry Chen wrote:

> Then in driver rtc-mt6397.c, it used regmap_bulk_read() to get the time
> of PMIC, and hit the null function of format_val(), because the
> regmap_bus was null.

> It skipped the initialization of format_val() because bus == null, but
> called the format_val() at regmap_bulk_read() if bus == null.

OK, so the issue here is that when we fall back to regmap_read() we may
do so because we have reg_read() and reg_write() functions which in turn
imply no formatting.  The expectation here is that val must be an array
of int.  The code doesn't completely take that into account though and
the user you're pointing at is assuming it's an array of 16 bit values
which isn't totally unreasonable if it did specify val_bits (we don't
check for that).

> Maybe it was not the good fix for this, but should be a problem need to
> be reported, or should I need to give the regmap_bus on mtk_pmic_wrap.c?

That file isn't in mainline...

memcpy() is definitely not a safe way to move from an unsigned int to a
u16 which is what your specific use case is trying to do.  I'll need to
do an audit of existing users (or someone else will!) to figure out what
people are doing with .val_bits in drivers using reg_read() and
reg_write() but I think what we should be doing here is probably
providing appropriate conversion functions based on val_bits on init.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150721/6c01e655/attachment.sig>
