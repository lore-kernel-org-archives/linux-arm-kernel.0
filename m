From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 6 Jan 2015 13:58:18 +0000
Subject: [PATCH v5 08/19] arm/arm64: KVM: make the maximum number of vCPUs
 a per-VM value
In-Reply-To: <54AACB0A.9080207@arm.com>
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-9-git-send-email-andre.przywara@arm.com>
 <86d27a1seb.fsf@arm.com> <54AACB0A.9080207@arm.com>
Message-ID: <CAFEAcA_v5BYi6Dm2yj_p27nSrN8ai+Z2-YJwBMbADuoUtNEW2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2015 at 17:34, Andre Przywara <andre.przywara@arm.com> wrote:
> Mmmh, fair point. I guess we should just allow KVM_MAX_VCPUS in this
> case, right? Has anyone tested userland GIC emulation recently?
> I will see if I find some method of testing this with QEMU.

I did actually use this when I was trying to track down the bugs
that turned out to be vgic-init-ordering last month. If you add
-machine kernel_irqchip=off to your QEMU command line it will
try to use an emulated userspace GIC. But as Christoffer says,
there is a catch: there's no way to get the vcpu's generic timers
to tell userspace that there's been a timer interrupt that needs
to be fed into the userspace GIC. So you need to fiddle with the
device tree to tell the guest the generic timers don't exist,
and provide a different timer, at least in theory [though I
didn't actually end up having to do that, I think it was just
fluke that it worked for my testing].

-- PMM
