From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Nov 2012 16:51:17 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121112144122.GJ2346@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121112102354.GA2346@mudshark.cambridge.arm.com>
 <50A105E7.6000005@gmail.com>
 <20121112144122.GJ2346@mudshark.cambridge.arm.com>
Message-ID: <20121112165117.GB18863@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 02:41:22PM +0000, Will Deacon wrote:
> On Mon, Nov 12, 2012 at 02:21:27PM +0000, Rob Herring wrote:
> > On 11/12/2012 04:23 AM, Will Deacon wrote:
> > > Hi Rob,
> > > 
> > > On Sun, Nov 11, 2012 at 03:20:40AM +0000, Rob Herring wrote:
> > >> From: Rob Herring <rob.herring@calxeda.com>
> > >>
> > >> Use the previously unused TPIDRPRW register to store percpu offsets.
> > >> TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
> > >>
> > >> This saves 2 loads for each percpu variable access which should yield
> > >> improved performance, but the improvement has not been quantified.
> > > 
> > > The patch looks largely fine to me (one minor comment below), but we should
> > > try and see what the performance difference is like on a few cores before
> > > merging this. Have you tried something like hackbench to see if the
> > > difference is measurable there? If not, I guess we'll need something more
> > > targetted.
> > 
> > Looks like it's about a 1.4% improvement on Cortex-A9 (highbank) with
> > hackbench.
> > 
> > Average of 30 runs of "hackbench -l 1000":
> > 
> > Before: 6.2190666667
> > After: 6.1347666667
> > 
> > I'll add this data to the commit msg.
> 
> Wow, that's really cool! I'll take it for a spin on 11MPCore to test the v6
> angle...

Ok, similar numbers over here so it looks like this is definitely worth
doing. However, I still object to the "cc", particularly after discussion
with the tools guys here who agree that the behaviour you're seeing is
indicative of a buggy compiler. It may even be part of a larger issue with
GCC's definition of `reachability' for kernel entry points. For interest, I
failed to reproduce with:

  gcc version 4.7.3 20121001 (prerelease) (crosstool-NG linaro-1.13.1-4.7-2012.10-20121022 - Linaro GCC 2012.10)
(http://launchpad.net/linaro-toolchain-binaries/trunk/2012.10/+download/gcc-linaro-arm-linux-gnueabihf-4.7-2012.10-20121022_linux.tar.bz2)

which sounds fairly close to the tools that you are using. Please can you
file a bug in launchpad?

Will
