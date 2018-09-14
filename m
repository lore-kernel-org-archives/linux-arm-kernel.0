From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Sep 2018 11:41:49 +0100
Subject: [PATCH 1/2] staging/vc04_services: Derive g_cache_line_size
In-Reply-To: <107b707e-1f8c-1305-2582-0a131011758d@i2se.com>
References: <1536770554-107314-1-git-send-email-phil@raspberrypi.org>
 <1536770554-107314-2-git-send-email-phil@raspberrypi.org>
 <107b707e-1f8c-1305-2582-0a131011758d@i2se.com>
Message-ID: <20180914104148.GB30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 12:11:54PM +0200, Stefan Wahren wrote:
> Hi Phil,
> 
> Am 12.09.2018 um 18:42 schrieb Phil Elwell:
> > +	/*
> > +	 * The tempting L1_CACHE_BYTES macro doesn't work in the case of
> > +	 * a kernel built with bcm2835_defconfig running on a BCM2836/7
> > +	 * processor, hence the need for a runtime check. The dcache line size
> > +	 * is encoded in one of the coprocessor registers, but there is no
> > +	 * convenient way to access it short of embedded assembler, hence
> > +	 * the use of read_cpuid_id(). The following test evaluates to true
> > +	 * on a BCM2835 showing that it is ARMv6-ish, whereas
> > +	 * cpu_architecture() will indicate that it is an ARMv7.
> > +	 */
> > +	g_cache_line_size = ((read_cpuid_id() & 0x7f000) == 0x7b000) ? 32 : 64;
> 
> is there a chance to use ARM_CPU_PART_ARM1176 or something else instead
> of this magic numbers?

In any case, reading the CPU ID and masking it in this way is really
not on.

The above checks that the ID _may_ be a "new ID" format, and that the
top four bits of the CPU part number are 11.  However, there are three
formats of the CPU ID register which can conflict if you do this kind
of trivial mask-and-test.

The relevant cases for are:

bits 19:16 inclusive being all ones define whether the ID is "new ID"
format with the additional CPU ID registers.  This is used for all
modern CPUs.

Otherwise, if bit 19 is clear, it is an older ID format, and bits
18:16 may contain '7'.

The value of bits 15:4 depend on the implementer - "1011" in 15:12 are
used by Intel for StrongARM1110 (though they won't have '7' in 18:16),
ARM Ltd for ARM1136, ARM1156, ARM1176 and ARM11MPCore (which will have
'7' in 18:16) - and hence will match this test.

So, the above code does not match just BCM2835, but also matches other
CPUs.

There is a reason why the old macros that allow the part number to be
fetched in asm/cputype.h are marked as deprecated, and that is to
encourage correct behaviour - to use both the part number and
implementer fields.

The comment is also wrong.  It claims that in order to read the cache
line size, one needs to use assembler.  asm/cputype.h has macros and
inline functions (of which read_cpuid_id() is one of them) to allow
access without having assembler encoded in drivers.  However, there is
a gotcha - the format of the cache type register also depends on the
CPU architecture, so it's not a simple case of grabbing the value of a
bitfield.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
