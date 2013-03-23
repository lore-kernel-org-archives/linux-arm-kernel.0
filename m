From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 23 Mar 2013 16:29:26 +0100
Subject: [PATCH 1/2] gpio: mvebu: add dbg_show function
In-Reply-To: <20130323162118.7bb6bbe3@skate>
References: <1363978188-31200-1-git-send-email-simon.guinot@sequanux.org>
 <1363978188-31200-2-git-send-email-simon.guinot@sequanux.org>
 <20130323162118.7bb6bbe3@skate>
Message-ID: <20130323152926.GD16903@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 04:21:18PM +0100, Thomas Petazzoni wrote:
> Dear Simon Guinot,

Hi Thomas,

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

test_bit implies more extra bit shifting which are not needed.
But maybe it makes the function more readable.

Your call :)

Simon

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
> 
> etc.
> 
> Thomas
> -- 
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130323/969ef853/attachment.sig>
