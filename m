From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 4 Apr 2017 14:04:05 +0200
Subject: [PATCH v5 00/34] arm/arm64: KVM: Rework the hyp-stub API
In-Reply-To: <20170403183807.1620-1-marc.zyngier@arm.com>
References: <20170403183807.1620-1-marc.zyngier@arm.com>
Message-ID: <20170404120405.GH11752@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon, Apr 03, 2017 at 07:37:33PM +0100, Marc Zyngier wrote:
> As noticed by RMK in this thread[1], the hyp-stub API on 32bit ARM
> could do with some TLC (it cannot perform a soft-restart at HYP, and
> has holes in the hyp-stub support in a number of places). In general,
> it would be desirable for the 32bit behaviour to align on 64bit, if
> only to ease maintenance.
> 
> This series implements the following:
> - Add HVC_[GS]ET_VECTORS and HVC_SOFT_RESTART to the 32bit code
> - Add HVC_RESET_VECTORS to both arm and arm64, removing the need for
>   __hyp_reset_vectors
> - Implement add the stub entry points in the KVM init code, which
>   didn't implement any so far
> - Convert the HYP code to use the init code stubs directly
> - Some general cleanup as a result of these changes (which includes
>   killing HVC_GET_VECTORS)
> - Add some API documentation that covers the above
> 
> Patches 14 to 16 would be better squashed into 12 and 13, but I've
> kept them separate so that I can take the blame for everything I've
> broken.
> 
> I've tested this on arm (Cubietruck, Jetson TK1) and arm64 (Seattle),
> both as host and guest. Keerthy has been kind enough to test the 32bit
> code on DRA7-EVM, AM57XX-EVM and KEYSTONE-K2E-EVM.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/473472.html
> 
> * From v4:
>   - Added a standard return value on stub hypercall failure
>   - Zero r0/x0 on successful hypercall
>   - Make 32bit ARM resistant to kvm_reboot while executing a guest
>   - Update documentation to reflect the calling convention expectations
>   - Added Acks from Catalin
>   - Rebased on 4.11-rc5

Thanks for doing the changes.

I have applied your patches to kvmarm/queue.

-Christoffer
