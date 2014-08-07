From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Aug 2014 18:33:16 +0100
Subject: [PATCH V2 1/4] ARM: perf: Set suniden bit.
In-Reply-To: <53E22E0B.7080907@parkeon.com>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144833.25462.46011.stgit@localhost>
 <20140806104947.GD25953@arm.com> <53E22E0B.7080907@parkeon.com>
Message-ID: <20140807173316.GH31101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 02:30:51PM +0100, Martin Fuzzey wrote:
> On 06/08/14 12:49, Will Deacon wrote:
> > +	/*
> > +	 * Bits indicating any CPU or platform specific activations that have
> > +	 * been done so we can undo them when stopping
> > +	 */
> > +	struct {
> > +		unsigned int secure_regs_available : 1;
> > +		unsigned int secure_debug_requested : 1;
> > +		unsigned int platform_enabled : 1;
> > +	} activated_flags;
> > This should be a single bool secure_access; field.
> 
> The idea was to only actually modify the security settings while someone 
> actually uses perf rather than just anytime the driver is loaded.
> But I didn't want to disable the bit when exiting perf mode if it had 
> already been enabled elsewhere (eg by the bootloader).
> Hence the first two bits.
> 
> I'm not sure how important this really is but it seemed sensible and not 
> too hard.

I think it's unnecessary complication. We've booted secure, we're not
spawning a non-secure OS and we're not doing any strange
soft-virtualisation. This means that we own the PMU and can configure it
once during probe.

Will
