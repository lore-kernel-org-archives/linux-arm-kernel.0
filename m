From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Nov 2015 10:08:19 +0000
Subject: PSCI_CPU_ON flow
In-Reply-To: <20151104193142.GM8644@n2100.arm.linux.org.uk>
References: <BY1PR0301MB1303B5D1A8CD0B7FA07AA40A822A0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <20151104171048.GE23860@leverpostej>
 <20151104193142.GM8644@n2100.arm.linux.org.uk>
Message-ID: <20151105100819.GO7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 07:31:42PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 04, 2015 at 05:10:49PM +0000, Mark Rutland wrote:
> > Yes, the CPU should start at __pa(secondary_entry) in head.S. From there
> > it will branch to secondary_startup:
> > 
> > ENTRY(secondary_entry)
> > 	bl      el2_setup                       // Drop to EL1
> > 	bl      set_cpu_boot_mode_flag
> > 	b       secondary_startup
> > ENDPROC(secondary_entry)
> 
> We've been busy telling people to implement errata workarounds in firmware,
> and we're also busy telling people that their secondary CPUs should start
> in the kernel.  The two are incompatible with each other...

I think this could have been worded better, something like: the CPU
should enter the non-secure EL2 or EL1 at __pa(secondary_entry).
Avoiding the word "start" means that we are not excluding the firmware.
On arm64 we can't skip secure firmware since all CPUs reset at EL3
anyway.

> I think we need to come up with a clearer statement on both these subjects
> which gives people a good idea about what's required, and doesn't send out
> confusing messages.

I agree, Documentation/{arm/Booting,arm64/booting.txt} should clearly
state the requirements. Not sure many people read them but at least they
can be told about.

-- 
Catalin
