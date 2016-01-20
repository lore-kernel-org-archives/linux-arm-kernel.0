From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jan 2016 19:57:22 +0000
Subject: CONFIG_CPU_SW_DOMAIN_PAN breakage on ARM11 MPCore
In-Reply-To: <20160119162328.GM19062@n2100.arm.linux.org.uk>
References: <569D71F3.7000408@openwrt.org>
 <20160119093845.GJ19062@n2100.arm.linux.org.uk>
 <569E0796.9000302@openwrt.org> <12866783.yJ1maoGsrz@wuerfel>
 <20160119162328.GM19062@n2100.arm.linux.org.uk>
Message-ID: <20160120195722.GU19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 04:23:28PM +0000, Russell King - ARM Linux wrote:
> However, the SMP vs UP mode thing does have an effect on the fix
> too - if we have MPcore systems operating in UP mode, we're going
> to need a much more complex and hideous fix - we're likely going
> to need to out-of-line _all_ the TLB flushing which is going to
> be nasty for the vast majority not affected by this. :(

Having thought about this some more, I'm coming to the conclusion that
the only sane solution here is to change the help text for SW_PAN such
that if you want to run a kernel on ARM11 MPcore, you must disable
SW_PAN.

Unless that approach is taken, we're into a rewrite the ARM TLB flushing
(as mentioned above) and I really don't want to do that just for the
sake of one relatively rare early SMP CPU.

For those who think we can simply apply my patch, consider the CNS3xxx
situation, which is not a SMP system in mainline kernels, but uses ARM11
MPcore CPUs (and thus fails when SMP is disabled, even with my patch.)

So I'm going to suggest that this option's help text is changed to:

config CPU_SW_DOMAIN_PAN
	bool "Enable use of CPU domains to implement privileged no-access"
	depends on MMU && !ARM_LPAE
	default y
	help
	  Increase kernel security by ensuring that normal kernel accesses
	  are unable to access userspace addresses.  This can help prevent
	  use-after-free bugs becoming an exploitable privilege escalation
	  by ensuring that magic values (such as LIST_POISON) will always
	  fault when dereferenced.

	  Note: This option is incompatible with ARM11 MPcore and must not
	  be used with kernels which are to run on this CPU, whether in SMP
	  or UP mode.

	  CPUs with low-vector mappings use a best-efforts implementation.
	  Their lower 1MB needs to remain accessible for the vectors, but
	  the remainder of userspace will become appropriately inaccessible.

Unfortunately, that's still going to lead to people hitting this, and
possibly wasting a long time debugging it needlessly - but I don't
have any better solution for this.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
