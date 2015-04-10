From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 10 Apr 2015 11:12:15 +0200
Subject: [RFC PATCH] arm64: KVM: remove fpsimd save/restore from the
 world switch
In-Reply-To: <1428598439-5217-1-git-send-email-marc.zyngier@arm.com>
References: <1428598439-5217-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150410091215.GC6186@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 05:53:59PM +0100, Marc Zyngier wrote:
> The world switch spends quite some time dealing with the FP/SIMD
> registers, as the state is quite sizeable (32 128bit registers,
> plus some crumbs on the side). We save/restore them on each
> entry/exit, so that both the host and the guest always see
> the state they expect.
> 
> But let's face it: the host kernel doesn't care. It is the host
> userspace that actually cares about FP. An obvious improvement is
> to remove the save/restore from the world switch, and only perform
> it when we're about to enter/exit the guest (by plugging it into
> vcpu_load/vcpu_put). The effect is pretty spectacular when running
> hackbench (which is the only benchmark worth looking at):
> 
so the kernel never uses fp/simd registers for stuff like memcopies
etc.?

Can we also make a similar change for ARM on the 32-bit side?

-Christoffer
