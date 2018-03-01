From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 1 Mar 2018 11:32:59 +0100
Subject: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
In-Reply-To: <fdf86770-6f45-3b3c-50ea-7a8363894639@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
 <20180228083214.h4oi2kmjjqmoyfhn@flea>
 <fdf86770-6f45-3b3c-50ea-7a8363894639@sholland.org>
Message-ID: <20180301103259.nomjbwkw4xbvhbfv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 11:19:11AM -0600, Samuel Holland wrote:
> Hi,
> 
> On 02/28/18 02:32, Maxime Ripard wrote:
> > On Tue, Feb 27, 2018 at 08:27:14PM -0600, Samuel Holland wrote:
> >> +	/*
> >> +	 * The failure path should not disable the clock or assert the reset,
> >> +	 * because the PSCI implementation in firmware relies on this device
> >> +	 * being functional. Claiming the clock in this driver is required to
> >> +	 * prevent Linux from turning it off.
> >> +	 */
> >> +	ret = clk_prepare_enable(clk);
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
> >> +		return ret;
> >> +	}
> > 
> > You don't need it to be always on though. You only need it to be
> > enabled when you access the registers (on both sides I guess?). So you
> > could very well enable the clock in your registers accessors in Linux,
> > and do the same in the ARISC firmware. That should work.
> 
> It does need to always be on because the *PSCI* implementation (ATF) also uses
> SCPI concurrently with Linux (on a separate channel). Turning off the clock
> anywhere in Linux could turn it off in the middle of a PSCI SCPI call on a
> different CPU, causing ATF to hang in EL3 (which would be very bad).

Then the above code doesn't fix anything. You should mark the clock
critical, otherwise that clock will be turned off if the driver is
compiled as a module and not loaded (or loaded later), or if the
driver is not even compiled in.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/a6441894/attachment.sig>
