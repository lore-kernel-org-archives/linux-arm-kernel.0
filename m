From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 16 Oct 2018 11:15:04 +0100
Subject: [PATCH 1/2] arm64: dts: meson: fix reserve memory regions
In-Reply-To: <06a189c5-d5b0-d5cd-d3b2-e2ed21721aeb@baylibre.com>
References: <20181015162833.7544-1-jbrunet@baylibre.com>
 <20181015162833.7544-2-jbrunet@baylibre.com>
 <20181015164214.hpqz7zear2c44ijd@lakrids.cambridge.arm.com>
 <06a189c5-d5b0-d5cd-d3b2-e2ed21721aeb@baylibre.com>
Message-ID: <20181016101503.ktumdffk4nlxb34t@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 10:23:50AM +0200, Neil Armstrong wrote:
> Hi Mark,
> 
> On 15/10/2018 18:42, Mark Rutland wrote:
> > On Mon, Oct 15, 2018 at 06:28:32PM +0200, Jerome Brunet wrote:
> >> Since commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")
> >> was merged Amlogic's boards using mainline u-boot started showing the
> >> following warning:
> >>
> >> WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_reserved_regions+0xd8/0x144
> >> Modules linked in:
> >> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-00263-g385684b3eb27-dirty #254
> >> pstate: 40000005 (nZcv daif -PAN -UAO)
> >> pc : reserve_memblock_reserved_regions+0xd8/0x144
> >> lr : reserve_memblock_reserved_regions+0xd0/0x144
> >> [...]
> >>
> >> This is due to u-boot setting some /reservedmem/ region while our
> >> dts declares reserved memory on the same region with no-map.
> >>
> >> The conflict produce the warning. This is fixed by using /reservedmem/
> >> in our dts as well, which is probably something we should have done from
> >> the beginning.
> > 
> > A /memreserve/ does not ensure no-map, and the kernel will map regions
> > which are described in a memory node and only protected with a
> > /memreserve/ entry.
> > 
> > Is it safe for the kernel to map these? e.g. speculative fetches won't
> > trigger a TrustZone controller to reboot the system?
> > 
> > ... or are they not in memory nodes to begin with?
> 
> Do you ask if these memory zones are protected by an Hardware
> Protection on the AXI bus

Yes.

> instead of simply protected by the ARM TZ MMU entries ?

The secure world MMU has no impact whatsoever on SW running in the
normal world.

Only the HW (like a TZC on the bus) can enforce restrictions.

> In the later case, a speculative fetch won't fail, is that right ?
> These zones are mapped on the DDR, and seems to be simply protected by the MMU
> from the ATF code, there are other HW protected RAM zones we haven't modeled.

If the bus does not protect these ranges, a speculative fetch from the
normal world will not fail.

However, this means that the normal world can trivially escalate
privilege to the secure world, and any bug in normal world software
could corrupt secure world SW. So I *hope* there is some protection in
place.

> BTW Can the Cortex-A53 do speculative fetches ? I thought no.

I believe COrtex-A53 can prefetch, so yes.

Thanks,
Mark.
