From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 7 Mar 2017 01:52:08 -0800
Subject: [PATCH 0/8] arm64: KVM: Fix PMU exception generation
In-Reply-To: <874lz51le6.fsf@on-the-bus.cambridge.arm.com>
References: <20170222114728.2472-1-marc.zyngier@arm.com>
 <20170305150109.GA1502@lvm>
 <874lz51le6.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <20170307095208.GA101711@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 09:33:37AM +0000, Marc Zyngier wrote:
> On Sun, Mar 05 2017 at  3:01:09 pm GMT, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > Hi Marc,
> >
> > On Wed, Feb 22, 2017 at 11:47:20AM +0000, Marc Zyngier wrote:
> >> Running the following code:
> >> 
> >> root at zomby-woof:~# cat test-pmu.c
> >> int main(int argc, char *argv[])
> >> {
> >> 	unsigned int val;
> >> 	asm ("mrc p15, 0, %0, c9, c13, 0\n" : "=r" (val));
> >> 	return val;
> >> }
> >> 
> >> in a 32bit guest (or a 64bit guest with a 32bit userspace) results in
> >> this surprising result:
> >> 
> >> [  120.347497] kvm [1150]: Unsupported guest CP15 access at: ab0945ae
> >> [  120.353689] kvm [1142]:  { Op0( 0), Op1( 0), CRn( 9), CRm(13), Op2( 0), func_read },
> >> 
> >> which is weird, because the guest behaves correctly:
> >> root at zomby-woof:~# ./test-pmu 
> >> [   16.184422] test-pmu[740]: undefined instruction: pc=00000000ab0945ae
> >> [   16.186043] Code: 00340001 b4800000 af00b085 60396078 (3f1dee19) 
> >> Illegal instruction
> >> 
> >> It gets the expected UNDEF, and all is fine. So what?
> >> 
> >> It turns out that the PMU emulation code is a bit lazy, and tells the
> >> rest of KVM that the emulation has failed, so that an exception gets
> >> delivered. Subtle differences in the 32bit vs 64bit handling make it
> >> spit an "Unsupported..." error.
> >> 
> >> This series tries to set things straight:
> >> - Allow an exception to be injected from an emulation handler
> >> - Make all PMU illegal accesses inject an UNDEF
> >> - Make these illegal accesses a successful emulation w.r.t the rest of KVM.
> >> 
> >> In the process, we also squash an interesting bug in the 64bit CP
> >> access. Similar treatment could be applied to the 32bit kernel, except
> >> that we don't ever inject an exception there (no PMU support yet).
> >
> > I'm a bit confused about this series and not too thrilled of the
> > approach where we add a side-channel of the sys_reg param in the vcpu
> > structure, which may or may not contain valid data at any given point.
> >
> > Couldn't we use a slightly bigger hammer (with cleaner semantics) and
> > let all system register handling (cp on 32-bit and 64-bit sys regs
> > alike) simply return true if they were emulated, in which case the
> > caller should advance the PC, or false ifsomething else happened, and
> > leave it up to the emulation of the individual registers to decide if
> > any exceptions should be injected.
> 
> So that was my other option - changing the semantics of the return
> value, and considering that an emulation never fails. At that stage, we
> can repurpose the return value form the accessor to simply indicate
> whether or not we should skip the current instruction.
> 
> > I don't think we have that many places where we want to inject an
> > undefined exception in our handlers, and doing it explicitly might
> > actually be a good idea to make it more clear that we're emulating the
> > architecture properly.  What do you think?
> 
> I think that'd work nicely. I'll rework the series along these lines.
> 
Awesome, thanks.
-Christoffer
