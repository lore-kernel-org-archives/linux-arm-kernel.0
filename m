From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Jun 2017 17:10:36 +0100
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20170619155003.13218-1-ynorov@caviumnetworks.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
Message-ID: <20170629161036.ftedtbp2gdmyzloo@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On Mon, Jun 19, 2017 at 06:49:43PM +0300, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode.

Thanks for putting this series together, I do appreciate the effort.
There are still some review comments coming in but I'm happy with how
the ABI looks now. I did some LTP testing (AArch64/LP64, AArch64/ILP32,
AArch32) and benchmarking and didn't see any regressions (apart from an
LTP bug with sync_file_range2). James Morse is working on reproducing
similar testing in ARM. Szabolcs reported some glibc test-suite
regressions on the libc-alpha list which I assume will be followed up.
VDSO in C is another issue I'd like sorted but this is not strictly
specific to ILP32 and can be done as a follow up. Note that I didn't run
any big-endian tests, though this is something that needs doing.

Now, having agreed on the ABI and implementation very close to being
ready doesn't necessarily make the code suitable for upstream. With my
maintainer hat on, I'm trying to see where ILP32 will be in 2-5-10
years, whether anyone still cares about it in this time frame. The
difference from a driver or SoC support is that ABIs are very hard to
revert, though are as (or even more) likely to bit-rot when not in use
or regularly tested (we have the big-endian experience here).

There are two main aspects to make the code upstream-worthy:

1. Actual/real users (current, future). I don't mean just a few distros
   showing that it can be done but actual/planned real deployments

2. Long term testing/maintenance plan. This is not about kernel code
   maintenance but a healthy ILP32 ecosystem:
   a) readily available toolchains (x86-hosted and AArch64-hosted)
   b) filesystems (can be large distros like openSUSE or more
      embedded-oriented like Yocto or OpenEmbedded)
   c) suitable continuous regression testing (kernel + userland)
   d) commitment from all parties involved (including ARM Ltd) to treat
      the ILP32 ABI as a (nearly) first class citizen

It is pretty clear from private discussions that there are potential
users but at the moment I can't tell if those would turn into real
deployments of production systems. As for (2), the long term plans are
not convincing (or I haven't spotted them yet), so I'd like to see the
interested parties putting a plan together (something along the lines of
kernelci.org + LTP, glibc buildbot).

What I'd like to propose is that Will and I (as arm64 maintainers, maybe
with with the help of others including this series' authors) take over
the series and push it to a staging branch under the arm64 kernel on
git.kernel.org. This is aimed as a commitment to keep the ABI *stable*
and will be rebased with every kernel release (starting with 4.13). The
decision to merge upstream will be revisited every 6 months, assessing
the progress on the points I mentioned above, with a time limit of 2
years when, if still not upstream, we will stop maintaining such branch.

I am aware that the above proposal has an impact on the glibc patches
since they will not merge a new ABI upstream until officially supported
by the kernel. I cc'ed some of the glibc developers and they will follow
up on the libc-alpha list.

> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
[...]
> Patches 1, 2, 3 and 8 are general, and may be applied separately.

These 4 patches should be merged independently, I don't see a point in
carrying them with the ILP32 series. Arnd, are you ok to push them
upstream?

BTW, patch 3 seems to never make it to the linux-arm-kernel list, I
guess too many on cc.

--
Catalin
