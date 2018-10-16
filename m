From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 16 Oct 2018 10:23:50 +0200
Subject: [PATCH 1/2] arm64: dts: meson: fix reserve memory regions
In-Reply-To: <20181015164214.hpqz7zear2c44ijd@lakrids.cambridge.arm.com>
References: <20181015162833.7544-1-jbrunet@baylibre.com>
 <20181015162833.7544-2-jbrunet@baylibre.com>
 <20181015164214.hpqz7zear2c44ijd@lakrids.cambridge.arm.com>
Message-ID: <06a189c5-d5b0-d5cd-d3b2-e2ed21721aeb@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 15/10/2018 18:42, Mark Rutland wrote:
> On Mon, Oct 15, 2018 at 06:28:32PM +0200, Jerome Brunet wrote:
>> Since commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")
>> was merged Amlogic's boards using mainline u-boot started showing the
>> following warning:
>>
>> WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_reserved_regions+0xd8/0x144
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-00263-g385684b3eb27-dirty #254
>> pstate: 40000005 (nZcv daif -PAN -UAO)
>> pc : reserve_memblock_reserved_regions+0xd8/0x144
>> lr : reserve_memblock_reserved_regions+0xd0/0x144
>> [...]
>>
>> This is due to u-boot setting some /reservedmem/ region while our
>> dts declares reserved memory on the same region with no-map.
>>
>> The conflict produce the warning. This is fixed by using /reservedmem/
>> in our dts as well, which is probably something we should have done from
>> the beginning.
> 
> A /memreserve/ does not ensure no-map, and the kernel will map regions
> which are described in a memory node and only protected with a
> /memreserve/ entry.
> 
> Is it safe for the kernel to map these? e.g. speculative fetches won't
> trigger a TrustZone controller to reboot the system?
> 
> ... or are they not in memory nodes to begin with?

Do you ask if these memory zones are protected by an Hardware Protection on the AXI bus
instead of simply protected by the ARM TZ MMU entries ?

In the later case, a speculative fetch won't fail, is that right ?
These zones are mapped on the DDR, and seems to be simply protected by the MMU
from the ATF code, there are other HW protected RAM zones we haven't modeled.

BTW Can the Cortex-A53 do speculative fetches ? I thought no.

Neil

> 
> Thanks,
> Mark.
> 
>>
>> Cc: stable at vger.kernel.org
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>
>> Hi Kevin,
>>
>> I would have liked to put a Fixes tag above but I could not figure out
>> which commit to pick, considering how much we changed those regions in
>> the past. If you have suggestion, I'll be happy to repost this patch.
>> If you prefer, feel free to amend this patch directly.
>>
>> Cheers
>> Jerome
>>
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 24 +++++--------------
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 27 ++++++++--------------
>>  2 files changed, 15 insertions(+), 36 deletions(-)
>>
[...]
