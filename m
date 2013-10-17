From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 17 Oct 2013 10:31:38 +0100
Subject: [RFC PATCH 2/5] ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and
 SYSTEM_RESET to user space
In-Reply-To: <525FAC07.4060306@arm.com>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-3-git-send-email-anup.patel@linaro.org>
 <525FA1D3.8060001@arm.com>
 <CAFEAcA-xqobnEmHnda5Psr4XH+3vAUr3K9Cnv_uhB7itBbNgfw@mail.gmail.com>
 <525FAC07.4060306@arm.com>
Message-ID: <CAFEAcA-0nY-Ck35zx_vbfkfrRxqfHs_5C2AABhWGoO88vmPqOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 October 2013 10:21, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 17/10/13 10:10, Peter Maydell wrote:
>> On 17 October 2013 09:37, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 16/10/13 18:02, Anup Patel wrote:
>>>> The PSCI SYSTEM_OFF and SYSTEM_RESET functions are VM or Guest level
>>>> functions hence cannot be emulated by the in-kernel PSCI emulation code.
>>>
>>> Why can't we implement system-wide functionality in the kernel? I fail
>>> to see the issue here.
>>
>> Because the kernel isn't emulating the whole board, and you need
>> to power off or reset the whole board, not just the CPUs.
>
> In which case we can forward a generic event, once KVM has dealt with
> the CPUs.

Ideally per-CPU reset should be driven by userspace, incidentally.
We ought to have an ioctl for "hey, reset this CPU': at the moment
we have to fake it up by having QEMU feed the CPU back the register
values it read on powerup, which is kind of ugly.

-- PMM
