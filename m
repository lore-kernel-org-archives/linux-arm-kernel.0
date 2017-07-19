From: jintack.lim@linaro.org (Jintack Lim)
Date: Wed, 19 Jul 2017 10:35:30 -0400
Subject: [RFC PATCH v2 00/38] Nested Virtualization on KVM/ARM
In-Reply-To: <20170719084938.GA11435@cbox>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
 <CAHyh4xjkT+JNJL0kxmEjz4qU8kD2-ZwYgVB8VgwsSYjpjTc3LA@mail.gmail.com>
 <20170719084938.GA11435@cbox>
Message-ID: <CAHyh4xjNMqzQpEQKfN7uKTsW-rDB5X6jjdFH3xW_Hee4NPfybg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 4:49 AM, Christoffer Dall <cdall@linaro.org> wrote:
> Hi Jintack,
>
> On Tue, Jul 18, 2017 at 10:23:05PM -0400, Jintack Lim wrote:
>> On Tue, Jul 18, 2017 at 12:58 PM, Jintack Lim <jintack.lim@linaro.org> wrote:
>> > Nested virtualization is the ability to run a virtual machine inside another
>> > virtual machine. In other words, it?s about running a hypervisor (the guest
>> > hypervisor) on top of another hypervisor (the host hypervisor).
>> >
>> > Supporting nested virtualization on ARM means that the hypervisor provides not
>> > only EL0/EL1 execution environment to VMs as it usually does but also the
>> > virtualization extensions including EL2 execution environment. Once the host
>> > hypervisor provides those execution environments to the VMs, then the guest
>> > hypervisor can run its own VMs (nested VMs) naturally.
>> >
>> > This series supports nested virtualization on arm64. ARM recently announced an
>> > extension (ARMv8.3) which has support for nested virtualization[1]. This patch
>> > set is based on the ARMv8.3 specification and tested on the FastModel with
>> > ARMv8.3 extension.
>> >
>> > The whole patch set to support nested virtualization is huge over 70
>> > patches, so I categorized them into four parts: CPU, memory, VGIC, and timer
>> > virtualization. This patch series is the first part.
>> >
>> > CPU virtualization patch series provides basic nested virtualization framework
>> > and instruction emulations including v8.1 VHE feature and v8.3 nested
>> > virtualization feature for VMs.
>> >
>> > This patch series again can be divided into four parts. Patch 1 to 5 introduces
>> > nested virtualization by discovering hardware feature, adding a kernel
>> > parameter and allowing the userspace to set the initial CPU mode to EL2.
>> >
>> > Patch 6 to 25 are to support the EL2 execution environment, the virtual EL2, to
>> > a VM on v8.0 architecture. We de-privilege the guest hypervisor and emulate the
>> > virtual EL2 mode in EL1 using the hardware features provided by ARMv8.3; The
>> > host hypervisor manages virtual EL2 register state for the guest hypervisor
>> > and shadow EL1 register state that reflects the virtual EL2 register state to
>> > run the guest hypervisor in EL1.
>> >
>> > Patch 26 to 33 add support for the virtual EL2 with Virtualization Host
>> > Extensions. These patches emulate newly defined registers and bits in v8.1 and
>> > allow the virtual EL2 to access EL2 register states via EL1 register accesses
>> > as in the real EL2.
>> >
>> > Patch 34 to 38 are to support for the virtual EL2 with nested virtualization.
>> > These enable recursive nested virtualization.
>> >
>> > This patch set is tested on the FastModel with the v8.3 extension for arm64 and
>> > a cubietruck for arm32. On the FastModel, the host and the guest kernels are
>> > compiled with and without VHE, so there are four combinations. I was able to
>> > boot SMP Linux in the nested VM on all four configurations and able to run
>> > hackbench. I also checked that regular VMs could boot when the nested
>> > virtualization kernel parameter was not set. On the cubietruck, I also verified
>> > that regular VMs could boot as well.
>> >
>> > I'll share my experiment setup shortly.
>>
>> I summarized my experiment setup here.
>>
>> https://github.com/columbia/nesting-pub/wiki/Nested-virtualization-on-ARM-setup
>>
>
> Thanks for sharing this.
>
>> >
>> > Even though this work has some limitations and TODOs, I'd appreciate early
>> > feedback on this RFC. Specifically, I'm interested in:
>> >
>> > - Overall design to manage vcpu context for the virtual EL2
>> > - Verifying correct EL2 register configurations such as HCR_EL2, CPTR_EL2
>> >   (Patch 30 and 32)
>> > - Patch organization and coding style
>>
>> I also wonder if the hardware and/or KVM do not support nested
>> virtualization but the userspace uses nested virtualization option,
>> which one is better: giving an error or launching a regular VM
>> silently.
>>
>
> I think KVM should complain to userspace if userspace tries to set a
> feature it does not support, and I think userspace should give as
> meaningful an error message as possible to the user when that happens.
>

Ok, thanks. I'll work this out.

> Thanks,
> -Christoffer
