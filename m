From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 14:39:05 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
Message-ID: <20141117143905.GQ4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 01:54:13PM +0000, Catalin Marinas wrote:
> On Sun, Nov 16, 2014 at 05:10:55PM +0000, Russell King - ARM Linux wrote:
> > which means that rather than encoding the
> > CPU architecture (like with every other Linux architecture), we have a
> > string which encodes the kernel architecture instead, which is absurd.
> 
> Just like x86_64 vs i686?

That is still valid, but let's wait and see what happens when a new
"version" of x86_64 comes along.

However, the issue on x86 is far less of a problem: userspace (even
kernel space) does not have to play these games because the CPUs aren't
designed by people intent on removing old instructions from the
instruction set, thereby stopping existing binaries working without
kernel emulation of the missing instructions.

> > Obviously, the plan for ARM64 is that there will never be an ARMv9
> > architecture, and ARMv8 is the perfect architecture for the future. :p
> 
> If you haven't noticed, the distinction between ARMv6 and ARMv7 has been
> blurred enough (guess why cpu_architecture() reports ARMv7 for
> ARM11MPCore). ARM is trying to move away from architecture version
> numbers, which are rather useful for marketing, to proper feature
> detection based on CPUID. Whether there is an ARMv9 or not, it's
> irrelevant to what Linux should do (i.e. use CPUID rather than guess
> features based on architecture version numbers).

That may be what is desired, but unfortunately we have no way to export
all the intricate feature registers to userspace.  No, elf hwcaps don't
support it, there's only 64 bits split between two words there, and
there are many more than just 64 bits of feature registers.

Given that even cocked these up (just as what happened with the cache
type register) decoding of the feature type registers depends on the
underlying CPU architecture.

So, even _if_ we exported the feature registers to userspace, you still
need to know the CPU architecture to decode them properly, so you still
need to parse the AT_PLATFORM string to get that information.

> > So, a reasonable parsing of this would be:
> > 
> > 	const char *ptr;
> > 	int architecture;
> > 
> > 	ptr = (const char *)(uintptr_t)getauxval(AT_PLATFORM);
> > 	assert(ptr);
> > 
> > 	if (!strncmp(ptr, "aarch64", 7))
> > 		architecture = 8;
> > 	else
> > 		assert(sscanf(ptr, "v%d", &architecture) == 1);
> 
> Oh, have you even bothered trying 32-bit (compat) getauxval(AT_PLATFORM)
> on an aarch64 kernel? It reports "v8l", so please don't confuse others.

Right, I see that now - I'm not knowledgable of the compat code, because
ARM32 has nothing to do with it, and I missed COMPAT_ELF_PLATFORM.

As for "bothered trying" - tell me how I could possibly try that.  You
know full well that I have /no/ 64-bit hardware, and you also know that
I have *nothing* capable of running, let alone building a 64-bit ARM
kernel.

Please, next time you decide to make accusations, bear that in mind - my
"guesses" as to what ARM64 does are based upon reading your code,
sometimes for the first time, and not through any kind of experience of
actually running the damned stuff.

Now, think about what /you/ have said.  Think about your assertion about
that "v8l" string.  How does the code react to that?  Oh my, it sets
"architecture" to 8 !  Oh lookie, it's the right value.  Oh look, the
code works correctly.

So, counter to your crap about me confusing others, maybe you should
make that same accusation of yourself!

Maybe ARM and yourself should have tried to be more inclusive with ARMv8
in general, rather than trying to push me away with accusations and the
like (like you're doing right now) every time I say something about it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
