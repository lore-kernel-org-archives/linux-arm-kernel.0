From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 8 Jun 2011 17:38:25 +0530
Subject: [PATCH V2] davinci: da850: move input frequency to board
	specific	files
In-Reply-To: <877h8xr4o0.fsf@ti.com>
References: <1306312622-4901-1-git-send-email-christian.riesch@omicron.at>
	<1306488053-27978-1-git-send-email-christian.riesch@omicron.at>
	<874o42wpec.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D383AA8@dbde02.ent.ti.com>
	<877h8xr4o0.fsf@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D425AD7@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 21:53:59, Hilman, Kevin wrote:

> I don't expect this to be a big boot-time impact.

You are right. Using PRINTK_TIME on DM365 I saw no noticeable boot-time
change. When I profiled the code using do_gettimeofday(), I saw it
was taking ~95 usecs to complete the propagation. I was mainly worried
about all the recursion and reading of PLL and sysclk registers. Seems
its not so bad.

> However, some of the clock.c assumptions might need to be updated as it
> currently is written from the perspective that the PLL clocks are the
> "root" clocks.

Hmm, just calling clk_set_rate() on refclk propagated the rate
nicely across the tree. It seems DaVinci clock code is not in
such a bad shape :) Or did I miss the concern?

> Setting (and propagating) clock rates is what the clock framework is
> for, so adding a new interface to set a custom clock rate just doesn't
> seem right.  I understand that the reference oscillator might be
> considered a special case, but if this can be done with the clock
> framework, it is much preferred.

Okay. Will modify the DM6467/T EVM code to use this method
instead.

Thanks,
Sekhar
