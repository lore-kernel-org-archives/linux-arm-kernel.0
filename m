From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 May 2011 18:40:54 +0200
Subject: [RFC PATCH 2/2] omap: switch to ioremap function pointer
In-Reply-To: <20110522130955.GE17672@n2100.arm.linux.org.uk>
References: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
	<201105221335.03688.arnd@arndb.de>
	<20110522130955.GE17672@n2100.arm.linux.org.uk>
Message-ID: <201105221840.54528.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 May 2011 15:09:55 Russell King - ARM Linux wrote:
> On Sun, May 22, 2011 at 01:35:03PM +0200, Arnd Bergmann wrote:
> > I mean don't call iotable_init() for regions that is ioremapped
> > into a device driver. Having both iotable_init and ioremap
> > on the same area is a bit fishy anyway,
> 
> That's how things used to be done.  What your proposal causes is people
> defining virtual address constants in platform header files, and using
> those constants directly in drivers.

My first proposal was to remove the fixed mapping in the cases where a
driver uses ioremap, not the other way round. The other proposal was
to handle the static mappings in the common ioremap code.

> Does it make sense to individually ioremap(), where each ioremap() creates
> 16 page table entries and therefore potentially consumes up to 16 TLB
> entries, resulting in 256 TLB entries to cover all 16 devices, or does it
> make sense to map the entire region as one section at boot time, thereby
> only consuming one TLB entry for the entire lot?
> 
> I believe TI have done some testing in this area, and have showed that
> this kind of optimization is reflected in the performance figures.

Ok, good to know. Can anyone point to the specific results? TLB pressure
is the obvious concern, but I didn't expect it to be measurable in this
scenario.
 
> Given that people are worrying about 0.2% performance gains through
> _elimination_ of the list prefetching due to TLB misses (see the linux-arch
> thread, and the proposed removal of prefetching from the list macros) I
> don't think anyone can justify avoiding the above kind of optimization.

The main reason the TLB miss for the list walk hurts so much is that it's
in the hot path for important workloads and that certain CPUs fail to install
an invalid TLB entry, so the pointless page walk gets exectuted all the time.

For the device mappings, I would assume that the accesses are typically
going to the most active devices, which consequently are still present in
the TLB. My na?ve expectation would be that there is more to gain from
using large pages ioremap (which we don't do AFAICT) whenever we map more
than a page than by pre-mapping some of the devices using large pages.

	Arnd
