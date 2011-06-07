From: khilman@ti.com (Kevin Hilman)
Date: Tue, 07 Jun 2011 09:23:59 -0700
Subject: [PATCH V2] davinci: da850: move input frequency to board
	specific	files
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D383AA8@dbde02.ent.ti.com>
	(Sekhar Nori's message of "Tue, 7 Jun 2011 16:09:33 +0530")
References: <1306312622-4901-1-git-send-email-christian.riesch@omicron.at>
	<1306488053-27978-1-git-send-email-christian.riesch@omicron.at>
	<874o42wpec.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D383AA8@dbde02.ent.ti.com>
Message-ID: <877h8xr4o0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Nori, Sekhar" <nsekhar@ti.com> writes:

> Hi Kevin,
>
> On Tue, Jun 07, 2011 at 04:14:59, Hilman, Kevin wrote:
>> Christian Riesch <christian.riesch@omicron.at> writes:
>> 
>> > From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
>> >
>> > Currently the input frequency of the SoC is hardcoded in the SoC specific
>> > da850.c file to 24 MHz. Since the SoC accepts input frequencies in a wide
>> > range from 12 to 50 MHz, boards with different oscillator/crystal
>> > frequencies may be built.
>> >
>> > This patch allows setting a different input frequency in the board
>> > specific files to support boards with oscillator/crystal frequencies other
>> > than 24 MHz.
>> >
>> > Signed-off-by: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
>> > Signed-off-by: Christian Riesch <christian.riesch@omicron.at>
>> 
>> Why not allow board code to just do a clk_set_rate()?
>> 
>> Currently the ref_clk struct clk does not have a .set_rate method
>> implemented, but that should be easy enough to add.  
>> 
>> Then the default ref_clk.rate would stay the 24MHz, but any boards that
>> want to override that simply use clk_get(), clk_set_rate(), clk_put()
>
> That's certainly much more elegant, but this would mean the whole
> clock tree is traversed again on each boot.
>
> I am doing some measurements to see if there is any big difference
> in boot-time if this is done. Will get back with results.

I don't expect this to be a big boot-time impact.

However, some of the clock.c assumptions might need to be updated as it
currently is written from the perspective that the PLL clocks are the
"root" clocks.

Setting (and propagating) clock rates is what the clock framework is
for, so adding a new interface to set a custom clock rate just doesn't
seem right.  I understand that the reference oscillator might be
considered a special case, but if this can be done with the clock
framework, it is much preferred.

Kevin
