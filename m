From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 23 Mar 2013 16:21:18 +0100
Subject: [PATCH 1/2] gpio: mvebu: add dbg_show function
In-Reply-To: <1363978188-31200-2-git-send-email-simon.guinot@sequanux.org>
References: <1363978188-31200-1-git-send-email-simon.guinot@sequanux.org>
 <1363978188-31200-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130323162118.7bb6bbe3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Guinot,

On Fri, 22 Mar 2013 19:49:47 +0100, Simon Guinot wrote:
> +	for (i = 0; i < chip->ngpio; i++) {
> +		const char *label;
> +		int msk;
> +		bool is_out;
> +
> +		label = gpiochip_is_requested(chip, i);
> +		if (!label)
> +			continue;
> +
> +		msk = 1 << i;
> +		is_out = !(io_conf & msk);

Maybe instead of using 'msk' you could use test_bit() ?

		is_out = !test_bit(i, io_conf);

> +		seq_printf(s, " gpio-%-3d (%-20.20s)", chip->base + i, label);
> +
> +		if (is_out) {
> +			seq_printf(s, " out %s %s\n",
> +				   out & msk ? "hi" : "lo",

				   test_bit(i, out) ? "hi" : "lo",

> +				   blink & msk ? "(blink )" : "");

				   test_bit(i, blink) ? "(blink )" : ""

etc.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
