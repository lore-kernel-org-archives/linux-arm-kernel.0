From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 15:47:39 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141117152624.GF20652@localhost>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117143905.GQ4042@n2100.arm.linux.org.uk>
 <20141117152624.GF20652@localhost>
Message-ID: <20141117154739.GT4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 03:26:25PM +0000, Catalin Marinas wrote:
> On Mon, Nov 17, 2014 at 02:39:05PM +0000, Russell King - ARM Linux wrote:
> > Given that even cocked these up (just as what happened with the cache
> > type register) decoding of the feature type registers depends on the
> > underlying CPU architecture.
> > 
> > So, even _if_ we exported the feature registers to userspace, you still
> > need to know the CPU architecture to decode them properly, so you still
> > need to parse the AT_PLATFORM string to get that information.
> 
> >From ARMv7 and many recent ARMv6, you can rely on the MIDR to tell you
> whether you have the extended CPUID or not. Prior to that, MIDR contains
> the architecture number.

That is not what I'm referring to.  Where the feature registers are
implemented, there are at least two different interpretations of these
feature registers.  They do not comprise of a single coherent set of
definitions - the meaning of some nibbles were changed between different
architectures.

> So what would you like to set it to? "v7l"? Even for pre-ARMv8 CPUs,
> such value doesn't give enough information and user space should rely on
> hwcap (yes, we missed a HWCAP_DMB because we relied on kuser helpers;
> another big thing we missed is Thumb-2 in hwcap).

Shall we look at the entire code fragment again, and this time use our
heads to *think* about it first?

        const char *ptr;
        int architecture;

        ptr = (const char *)(uintptr_t)getauxval(AT_PLATFORM);
        assert(ptr);

        if (!strncmp(ptr, "aarch64", 7))
                architecture = 8;
        else
                assert(sscanf(ptr, "v%d", &architecture) == 1);

        switch (architecture) {
        case 4:
        case 5:
                no_mcr_dmb;
                break;
        case 6:
                use_mcr;
                break;
        default:
                use_dmb;
                break;
        }

Now, if 32-bit ARMv8 returns "v8l" from the AT_PLATFORM auxval, then
it is not equal to "aarch64".  So, we fall through th sscanf().  sscanf()
parses the "v8l" string, and sets "architecture" to 8.

We now enter the switch() statement.  8 isn't 4.  8 also isn't 5.  Nor is
it 6.  So, we fall through to the "default" section, which uses "use_dmb".

That's the correct answer for ARMv8 CPUs, because we don't want to use
the MCR instruction there, nor do we want to do nothing.  That is not
coincidence - it was /specifically/ designed to select that outcome for
any architecture value it didn't explicitly know.  The assumption there
is that ARM are not going to deprecate and remove the dmb instruction.

So it doesn't matter if there's a v9, v10, v11, v12 etc.  It'll continue
to select the dmb method until the code is modified to do otherwise.

So, maybe I'm not as stupid as you first thought, and maybe I /did/ think
about this carefully about the possible scenarios before suggesting this
code fragment as a solution.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
