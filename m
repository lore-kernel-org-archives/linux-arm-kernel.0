From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Sep 2014 16:03:09 +0200
Subject: [PATCH] arm: kvm: fix CPU hotplug
In-Reply-To: <1411397568-4738-1-git-send-email-vladimir.murzin@arm.com>
References: <1411397568-4738-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20140929140309.GJ3095@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 03:52:48PM +0100, Vladimir Murzin wrote:
> On some platforms with no power management capabilities, the hotplug
> implementation is allowed to return from a smp_ops.cpu_die() call as a
> function return. Upon a CPU onlining event, the KVM CPU notifier tries
> to reinstall the hyp stub, which fails on platform where no reset took
> place following a hotplug event, with the message:
> 
> CPU1: smp_ops.cpu_die() returned, trying to resuscitate
> CPU1: Booted secondary processor
> Kernel panic - not syncing: unexpected prefetch abort in Hyp mode at: 0x80409540
> unexpected data abort in Hyp mode at: 0x80401fe8
> unexpected HVC/SVC trap in Hyp mode at: 0x805c6170
> 
> since KVM code is trying to reinstall the stub on a system where it is
> already configured.
> 
> To prevent this issue, this patch adds a check in the KVM hotplug
> notifier that detects if the HYP stub really needs re-installing when a
> CPU is onlined and skips the installation call if the stub is already in
> place, which means that the CPU has not been reset.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Applied to queue, thanks

-Christoffer
