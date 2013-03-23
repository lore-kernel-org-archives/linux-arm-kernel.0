From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Mar 2013 15:43:18 +0000
Subject: [PATCH 1/2] gpio: mvebu: add dbg_show function
In-Reply-To: <20130323162118.7bb6bbe3@skate>
References: <1363978188-31200-1-git-send-email-simon.guinot@sequanux.org>
 <1363978188-31200-2-git-send-email-simon.guinot@sequanux.org>
 <20130323162118.7bb6bbe3@skate>
Message-ID: <20130323154317.GN4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 04:21:18PM +0100, Thomas Petazzoni wrote:
> Dear Simon Guinot,
> 
> On Fri, 22 Mar 2013 19:49:47 +0100, Simon Guinot wrote:
> > +	for (i = 0; i < chip->ngpio; i++) {
> > +		const char *label;
> > +		int msk;
> > +		bool is_out;
> > +
> > +		label = gpiochip_is_requested(chip, i);
> > +		if (!label)
> > +			continue;
> > +
> > +		msk = 1 << i;
> > +		is_out = !(io_conf & msk);
> 
> Maybe instead of using 'msk' you could use test_bit() ?
> 
> 		is_out = !test_bit(i, io_conf);
> 
> > +		seq_printf(s, " gpio-%-3d (%-20.20s)", chip->base + i, label);
> > +
> > +		if (is_out) {
> > +			seq_printf(s, " out %s %s\n",
> > +				   out & msk ? "hi" : "lo",
> 
> 				   test_bit(i, out) ? "hi" : "lo",
> 
> > +				   blink & msk ? "(blink )" : "");
> 
> 				   test_bit(i, blink) ? "(blink )" : ""

I don't think this is a good idea - and it's wrong.  test_bit() operates
on an array of bits, and needs to be passed an unsigned long pointer.
blink etc are "u32"s which aren't unsigned long.

Moreover, what if ngpio becomes greater than 32 (for whatever reason)?
test_bit(), when used correctly, will access the following word, which
is probably a bad thing.  The original won't have that behaviour,
which is safer.

Last point on the original - msk wants to also be of type 'u32' as well
to match io_conf/out/blink.
