From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jan 2012 19:36:39 +0000
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <4F0EF119.3000605@atmel.com>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
 <20120111165508.GC1068@n2100.arm.linux.org.uk>
 <201201111827.18890.arnd.bergmann@linaro.org>
 <20120111194334.GF1068@n2100.arm.linux.org.uk> <4F0EF119.3000605@atmel.com>
Message-ID: <20120112193639.GL1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 03:41:29PM +0100, Nicolas Ferre wrote:
> On 01/11/2012 08:43 PM, Russell King - ARM Linux :
> > On the other hand, we have another DWB in cpu_arm926_do_idle itself.
> > 
> > Whether any of this matters depends on _why_ that DWB is in the AT91
> > code itself - is it something that needs to be done before placing the
> > SDRAM into self-refresh mode, or is it being done merely because the
> > ARM926 docs say that a DWB is needed before WFI?
> 
> We have two cases here:
> 
> For the venerable at91rm9200: DWB is needed before putting SDRAM into
> self-refresh because any subsequent access to SDRAM will force it to
> resume from self-refresh state. Of course for this case, it is important
> to make sure that no access to SDRAM is made before the
> wait-for-interrupt instruction.
> 
> For all other SAM9 SoCs: no additional DWB is needed because RAM
> controller manages self-refresh state even if accesses are still done to
> the memory.

Okay, that makes sense (because everything but rm9200 branches out to
one of the cpu idle functions.)

It also supports my second idea described in
http://lists.arm.linux.org.uk/lurker/message/20120109.144443.3626e5a6.en.html
See the paragraph starting "So, what I suggest instead" at that URL and
following text.

The reason I think this is the best solution is:
(a) we move the CPU dependencies into each CPU file
(b) we localize the quirks needed for each CPU into its own specific code
(c) we can select at run time between the various standby functions

These are all AT91 specific wins.  What it also gets us is _much_ less
exported code from arch/arm/mach-at91 when the CPU idle stuff moves out,
reducing it down to just a mere function pointer, and, because the AT91
specific idle stuff is hidden behind this it potentially opens the door
towards some consolidation in this area between different SoCs.
