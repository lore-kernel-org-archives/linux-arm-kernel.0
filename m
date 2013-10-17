From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 17 Oct 2013 10:10:14 +0100
Subject: [RFC PATCH 2/5] ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and
 SYSTEM_RESET to user space
In-Reply-To: <525FA1D3.8060001@arm.com>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-3-git-send-email-anup.patel@linaro.org>
 <525FA1D3.8060001@arm.com>
Message-ID: <CAFEAcA-xqobnEmHnda5Psr4XH+3vAUr3K9Cnv_uhB7itBbNgfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 October 2013 09:37, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 16/10/13 18:02, Anup Patel wrote:
>> The PSCI SYSTEM_OFF and SYSTEM_RESET functions are VM or Guest level
>> functions hence cannot be emulated by the in-kernel PSCI emulation code.
>
> Why can't we implement system-wide functionality in the kernel? I fail
> to see the issue here.

Because the kernel isn't emulating the whole board, and you need
to power off or reset the whole board, not just the CPUs.

> I'm really not keen on this approach. Having part of the PSCI
> implementation offloaded to userspace means we don't have a complete
> implementation in KVM anymore, and we end-up duplicating functionality
> all over the place.
>
> Also, OFF and RESET are not PSCI specific concepts, and could be
> implemented in various ways. I'm more inclined to return a
> *standardized* exit code that the various platforms can interpret.

Maybe we should have a more generic "kernel can't handle this,
toss it to userspace" API? That might also fit in with supporting
guests that want to make SMC calls to an emulated monitor...

-- PMM
