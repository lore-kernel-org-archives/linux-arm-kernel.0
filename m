From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 7 Jun 2013 23:09:56 -0400 (EDT)
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <20130607175007.GH8111@mudshark.cambridge.arm.com>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130606151705.GG16794@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306061156330.18597@syhkavp.arg>
 <20130607175007.GH8111@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1306072214120.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Will Deacon wrote:

> Hello Nicolas, Ard,
> 
> On Thu, Jun 06, 2013 at 05:17:39PM +0100, Nicolas Pitre wrote:
> > On Thu, 6 Jun 2013, Will Deacon wrote:
> > > On Thu, Jun 06, 2013 at 04:03:00PM +0100, Ard Biesheuvel wrote:
> > > > This time, I have included two use cases that I have been using, XOR and RAID-6
> > > > checksumming. The former gets a 60% performance boost on the NEON, the latter
> > > > over 400%.
> > > 
> > > Whilst that sounds impressive, can you achieve similar results across all
> > > NEON-capable CPUs? In particular, we need to make sure this doesn't cause
> > > performance regressions on some cores.
> > 
> > Note that the kernel performs runtime benchmarking of all the different 
> > implementations it has available at boot time and selects the best one.  
> > So if this would turn out to make things worse on some cores then the 
> > Neon code would simply not be used.
> 
> That will be all sorts of fun if we try to run this on big.LITTLE...
> Perhaps we don't care about that either.

Probably not at the present time.

> > > Furthermore, do you have any power figures to complement your 
> > > findings?
> > 
> > This is going to be most useful in server type environments where a bit 
> > more power is not such an issue but throughput is ... unless you start 
> > using RAID6 arrays on your phone that is.  :-)  Otherwise this can be 
> > left configured out for mobile targets.
> 
> Agreed, but this patch series also sets a precedent for using NEON in the
> kernel. Whilst I'd love to hook up some SCSI arrays to my Nexus 4 (!), much
> more likely is that people might start reworking some of the crypto algorithms
> to use the NEON/SIMD register file (especially with the crypto extensions in
> ARMv8) so it would be good to have *some* feel of the power impact off the
> bat.

Well... Neon is there to be used, otherwise it is just a waste of gates. 
So of course it is going to use more power.  but as long as the power 
used by Neon is less than the power consumed by the same task performed 
by the main processor then we're happy.  Ard provided numbers where Neon 
performs 4 times better while it surely doesn't use 4 times the power 
(or so I hope).

That shouldn't matter much if that power is used in user or kernel 
space.  OTOH the kernel does use crypto algorithms so it does need Neon 
if we want 4x the throughput.

In the end what I want to say is that the power profile is for system 
integrator to assess and decide.  We cannot tell if the Neon power usage 
is good or bad without the overall application use case.  All we should 
do is to provide the mechanism and make it configurable.  Same argument 
applies to the context switch overhead.

> > > We support building the kernel with older toolchains, so I don't see the
> > > benefit of using intrinsics here.
> > 
> > These days the compiler tends to do a better job than humans at properly 
> > scheduling instructions for some code.  We shouldn't deprive ourselves 
> > from it when a recent enough gcc is available.
> 
> What's the earliest toolchain we claim to support nowadays? If that can't
> deal with the intrinsics then we either need to bump the requirement, or
> write this using hand-coded asm. In the case of the latter, I don't think
> the maintenance overhead of having two implementations is worth it.

We have many different minimum toolchain version requirements attached 
to different features being enabled already, ftrace being one of them if 
I remember correctly.  For these Neon optimizations the minimum gcc 
version is v4.6.

Given that this is going to be interesting mostly to server systems, and 
given that ARM server deployments are rather new, I don't see the point 
of compiling a new server environment using an older gcc version.

I don't think we have to bump the gcc requirement for anyone wishing to 
compile the kernel with their existing set of features either.  That 
would be rather silly.  It is not because Neon intrinsics are used in 
some kernel code that everyone should be forced to upgrade their 
compiler, especially if they don't intend to use that in-kernel Neon 
code. However, in order to benefit from optional new features that 
didn't exist before, I think it is perfectly reasonable to require later 
gcc versions for them if need be.

I agree that having two different implementations of the same thing is 
not the way to go.  So if the choice between a pure assembly vs a C 
version with intrinsics has to be made, then I'd vote for the C version 
unless the assembly one is much faster.  C code is always preferable to 
assembly code as it is much easier to review and modify, and 
improvements to the compiler may still increase performance of the 
unchanged code while the assembly version is static and will always be 
tuned to some particular core implementations only.

If someone eventually comes along with some pure assembly version that 
blows the current C version out of the water then we simply replace it, 
period.  We don't have to commit ourselves to a particular 
implementation either.

But for that to happen we need to merge this code and let people 
experiment with it.  That's how improvements will come about.


Nicolas
