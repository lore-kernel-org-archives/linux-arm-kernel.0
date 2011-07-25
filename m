From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Jul 2011 18:34:07 +0530
Subject: [PATCH 0/4] Fix CPU hotplug IRQ migration
In-Reply-To: <4E290C05.7020209@ti.com>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
	<4E290C05.7020209@ti.com>
Message-ID: <4E2D69C7.4040609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
On 7/22/2011 11:05 AM, Santosh Shilimkar wrote:
> + Colin,
>
> On 7/21/2011 8:44 PM, Russell King - ARM Linux wrote:
>> This series fixes a bunch of issues with IRQ migration:
>>
>> 1. Preventing affinity changes causing IRQs to be directed to off-line
>> CPUs.
>> 2. Preventing oopses with non-GIC interrupt controllers.
>> 3. Preventing per-CPU IRQs being candidates for migration.
>> 4. Removing the abuse of irqdesc's node member.
>>
>> This prevents crashes on OMAP4430 SDP when non-default IRQ affinity
>> settings are used and a CPU which owns some IRQs is offlined.
>>
> Firstly thanks for fixing the IRQ migration and affinity issues
> with hotplug code. Colin found the hotplug irq affinity issue
> last week.
>
I have tested and revtested this series on OMAP4. Though I made one 
interesting observations while testing.

# cat /proc/irq/44/smp_affinity
3
# echo 2 > /proc/irq/44/smp_affinity
# cat /proc/irq/44/smp_affinity
2

# cat /proc/interrupts
            CPU0       CPU1
  44:       5179         38       GIC  DMA

# echo 0 > /sys/devices/system/cpu/cpu1/online
[  137.663208] CPU1: shutdown
#
# cat /proc/interrupts
            CPU0
  44:       5241       GIC  DMA

After CPU1 offline, the IRQ is handled by CPU0
even though masks say's it's CPU0. Mask should have
been corrected by hotplug code but as per your comments
this is just userspace settings and shouldn't dictate
which CPU handles the IRQ.

The interesting part is once you online CPU now,
IRQ44 continues to be on CPU0.

You think above behavior is fine? My i686 UBUNTU box,
I don't see above behaviour. The hotplug code updates
the IRQ mask to available CPU.

Secondly, GIC smp_set_affinity is kind of set_target_cpu
function. How can we relay the target CPU information to
gic_arch_extn, so that they can update their settings as
per GIC.

And lastly, we need to ensure that migrate_irq()
should be relayed to gic_arch_extn(), so that all
the interrupt on dying CPU can be masked.

Apart from one comment in patch 3/4, and above observations,
this series looks good to me.

If you need one, can add my
Reviewedd-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
