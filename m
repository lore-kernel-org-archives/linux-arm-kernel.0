From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Sep 2015 17:24:51 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56017D04.5010909@free.fr>
References: <56001B78.2090001@free.fr>
 <20150921161341.GP21084@n2100.arm.linux.org.uk>
 <56017D04.5010909@free.fr>
Message-ID: <20150922162451.GB21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 06:08:36PM +0200, Mason wrote:
> On 21/09/2015 18:13, Russell King - ARM Linux wrote:
> > On Mon, Sep 21, 2015 at 05:00:08PM +0200, Mason wrote:
> >> 1) Linux kernel runs in non-secure world. The port used to tweak
> >> L2 cache configuration via custom SMC calls to the OS running in
> >> secure world. I've removed that for now.
> >> Is there a standard solution these days?
> > 
> > While some configuration can be done by the boot loader (and it's
> > preferable for that to happen) not all of it can be.  In particular,
> > the kernel _must_ have the ability to enable and disable the L2
> > cache, and the kernel must not be called with the L2 cache left
> > enabled by the boot loader.
> > 
> > That requires that the L2 control register is writable in some way
> > from the non-secure world.
> 
> There is no agreed-upon method to do that?

Yes there is - there's two solutions, depending on how your secure
firmware operates.  Firstly, you need to make sure that .l2c_aux_mask
or .l2c_aux_val are non-zero in your machine record - preferably the
mask as all-ones and the val as all-zeros.  Then, either:

1. Set .l2c_write_sec in your machine record to point to a function which
   knows how to write to the secure-only L2 cache registers - suitable if
   your firmware has a "write this secure-only L2 register".  See
   arch/arm/mach-omap2/board-generic.c or arch/arm/mach-highbank/highbank.c.

2. Set outer_cache.configure to a function which configures the secure-only
   registers in one go - suitable if your firmware can only program multiple
   L2 cache registers together.  See arch/arm/mach-exynos/firmware.c.

> Is there an easy way to determine how many arch/arm platforms are running
> Linux in non-secure mode? (And thus need to interact with "firmware" or
> trustzone OS for things like L2 cache handling, and secondary core boot-up.)

Not really.  You can only guess based on grep results - as I've done in
providing the examples above.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
