From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Nov 2015 11:10:52 +0000
Subject: PSCI_CPU_ON flow
In-Reply-To: <20151104193142.GM8644@n2100.arm.linux.org.uk>
References: <BY1PR0301MB1303B5D1A8CD0B7FA07AA40A822A0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <20151104171048.GE23860@leverpostej>
 <20151104193142.GM8644@n2100.arm.linux.org.uk>
Message-ID: <20151105111051.GA28294@leverpostej>
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

Indeed. The above should have read "having exited the firmware, the CPU
should enter the kernel at __pa(secondary_entry)".

Out of reset all CPUs will go through firmware, where any IMPLEMENTATION
DEFINED initialisation (including errata workarounds and coherency
management) will have taken place, the exception vectors necessary for
the PSCI implementation will be registered, etc.

Thanks,
Mark.
