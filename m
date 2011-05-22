From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 22 May 2011 18:53:29 +0530
Subject: [RFC PATCH 2/2] omap: switch to ioremap function pointer
In-Reply-To: <20110522130955.GE17672@n2100.arm.linux.org.uk>
References: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
	<201105221154.28211.arnd@arndb.de> <4DD8F177.9020809@ti.com>
	<201105221335.03688.arnd@arndb.de>
	<20110522130955.GE17672@n2100.arm.linux.org.uk>
Message-ID: <4DD90E51.1040901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/22/2011 6:39 PM, Russell King - ARM Linux wrote:
> On Sun, May 22, 2011 at 01:35:03PM +0200, Arnd Bergmann wrote:
>> I mean don't call iotable_init() for regions that is ioremapped
>> into a device driver. Having both iotable_init and ioremap
>> on the same area is a bit fishy anyway,
>
> That's how things used to be done.  What your proposal causes is people
> defining virtual address constants in platform header files, and using
> those constants directly in drivers.
>
> _Thankfully_ we've moved on from that and are now having SoCs intercept
> at the ioremap() level to eliminate that junk.
>
> Consider an SoC where you have a block of devices known at boot time
> to be, lets say at 0x10000000 to 0x10100000.  Lets say there's 16 devices
> in there, each occupying 64K for simplicity.
>
> Does it make sense to individually ioremap(), where each ioremap() creates
> 16 page table entries and therefore potentially consumes up to 16 TLB
> entries, resulting in 256 TLB entries to cover all 16 devices, or does it
> make sense to map the entire region as one section at boot time, thereby
> only consuming one TLB entry for the entire lot?
>
> I believe TI have done some testing in this area, and have showed that
> this kind of optimization is reflected in the performance figures.
>
> Given that people are worrying about 0.2% performance gains through
> _elimination_ of the list prefetching due to TLB misses (see the linux-arch
> thread, and the proposed removal of prefetching from the list macros) I
> don't think anyone can justify avoiding the above kind of optimization.

Thanks Russell for bringing this point. I forgot to mention about TLB
pressure while talking about other bits and flexibility the current
interface gives.

Regards
Santosh
