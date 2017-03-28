From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 28 Mar 2017 15:37:18 +0200
Subject: [PATCH v2 0/9] arm64: KVM: Fix PMU exception generation
In-Reply-To: <20170327160345.12402-1-marc.zyngier@arm.com>
References: <20170327160345.12402-1-marc.zyngier@arm.com>
Message-ID: <20170328133718.GA20211@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 05:03:36PM +0100, Marc Zyngier wrote:
> Running the following code:
> 
> root at zomby-woof:~# cat test-pmu.c
> int main(int argc, char *argv[])
> {
> 	unsigned int val;
> 	asm ("mrc p15, 0, %0, c9, c13, 0\n" : "=r" (val));
> 	return val;
> }
> 
> in a 32bit guest (or a 64bit guest with a 32bit userspace) results in
> this surprising result:
> 
> [  120.347497] kvm [1150]: Unsupported guest CP15 access at: ab0945ae
> [  120.353689] kvm [1142]:  { Op0( 0), Op1( 0), CRn( 9), CRm(13), Op2( 0), func_read },
> 
> which is weird, because the guest behaves correctly:
> root at zomby-woof:~# ./test-pmu 
> [   16.184422] test-pmu[740]: undefined instruction: pc=00000000ab0945ae
> [   16.186043] Code: 00340001 b4800000 af00b085 60396078 (3f1dee19) 
> Illegal instruction
> 
> It gets the expected UNDEF, and all is fine. So what?
> 
> It turns out that the PMU emulation code is a bit lazy, and tells the
> rest of KVM that the emulation has failed, so that an exception gets
> delivered. Subtle differences in the 32bit vs 64bit handling make it
> spit an "Unsupported..." error.
> 
> This series tries to set things straight:
> - Make all PMU illegal accesses inject an UNDEF
> - Make these illegal accesses a successful emulation w.r.t the rest of KVM.
> 
> In the process, we also squash an interesting bug in the 64bit CP
> access. Similar treatment is applied to the 32bit kernel, except that
> we don't ever inject an exception there (no PMU support yet).
> 

I have applied this series to queue (not next since I haven't tested
thoroughly yet), with the fixups agreed in the series.

Thanks,
-Christoffer
