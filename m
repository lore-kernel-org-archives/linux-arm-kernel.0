From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 18:39:43 +0100
Subject: [PATCH 00/16] Another 16 L2C patches
In-Reply-To: <535E8F6D.9000803@wwwdotorg.org>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <535E8BEE.1000100@wwwdotorg.org> <535E8F6D.9000803@wwwdotorg.org>
Message-ID: <20140428173943.GN26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:27:09AM -0600, Stephen Warren wrote:
> On 04/28/2014 11:12 AM, Stephen Warren wrote:
> > On 04/28/2014 10:56 AM, Russell King - ARM Linux wrote:
> >> So, in response to Matt Porter's complaint about breaking prima2, here's
> >> another 16 patches which changes the way the L2 cache is initialised on
> >> many platforms.  This series moves towards a situation where the generic
> >> code initialises the L2 cache itself, with as little help as possible
> >> from board specific code.
> >>
> >> A number of platforms are left alone because they're more complex -
> >> these should still eventually be converted.
> >>
> >> At some point in the near future, I will see about sorting out their
> >> ordering wrt the previous patch set.  For the time being, they apply
> >> on top of the existing l2c changes.
> > 
> > Are "the existing l2c changes" in next-20140428? If not, is there a git
> > branch I can pull to test the whole thing, rather than tracking down and
> > applying "the existing l2c changes" first?
> 
> I guess they must be in linux-next, since this series applies cleanly on
> top of it.
> 
> So, patches 2/16 ("ARM: l2c: add platform independent core L2 cache
> initialisation") and 7/16 ("ARM: l2c: convert tegra to generic l2c
> initialisation"),
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> (On an NVIDIA Tegra20 Seaboard/Springbank board, on top of next-20140428)
> 
> I do see one error in dmesg during boot, but it doesn't appear to
> negatively affect operation in brief testing, and is present in
> linux-next without this series anyway. Is this message a problem?
> 
> > [    0.000000] L2C: platform modifies aux control register: 0x02080000 -> 0x3e480001
> > [    0.000000] L2C: DT/platform modifies aux control register: 0x02080000 -> 0x3e480001
> > [    0.000000] L2C-310 errata 727915 769419 enabled
> > [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> > [    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
>                           ^^^^^^ this is logged at error level

Correct, it's an error because on Tegra you explicitly set bit 0 in the
auxiliary control register, which is pointless unless the feature is
also enabled in the Cortex-A9 control register as well.

Rather than trying to track down everyone who does this, and then end
up in a long discussion about it, I'm just going to make the kernel
print an error message as a result, it's just wrong to set random bits
in device control registers without first properly understanding what
they're doing.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
