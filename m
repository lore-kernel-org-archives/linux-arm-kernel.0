From: james.morse@arm.com (James Morse)
Date: Thu, 09 Nov 2017 11:06:02 +0000
Subject: [3/3] arm64: Add software workaround for Falkor erratum 1041
In-Reply-To: <alpine.DEB.2.20.1711081305310.26324@lazy>
References: <1509679664-3749-4-git-send-email-shankerd@codeaurora.org>
 <alpine.DEB.2.20.1711081305310.26324@lazy>
Message-ID: <5A04369A.2020405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manoj,

On 08/11/17 19:05, Manoj Iyer wrote:
> On Thu, 2 Nov 2017, Shanker Donthineni wrote:
>> The ARM architecture defines the memory locations that are permitted
>> to be accessed as the result of a speculative instruction fetch from
>> an exception level for which all stages of translation are disabled.
>> Specifically, the core is permitted to speculatively fetch from the
>> 4KB region containing the current program counter and next 4KB.
>>
>> When translation is changed from enabled to disabled for the running
>> exception level (SCTLR_ELn[M] changed from a value of 1 to 0), the
>> Falkor core may errantly speculatively access memory locations outside
>> of the 4KB region permitted by the architecture. The errant memory
>> access may lead to one of the following unexpected behaviors.

> I applied the 3 patches to Ubuntu 4.13.0-16-generic (Artful) kernel and
> ran stress-ng cpu tests on QDF2400 server

[...]

> Where stress-ng would spawn N workers and test cpu offline/online, perform
> matrix operations, do rapid context switchs, and anonymous mmaps. Although
> I was not able to reproduce the erratum on the stock 4.13 kernel using the
> same test case, the patched kernel did not seem to introduce any
> regressions either. I ran the stress-ng tests for over 8hrs found the
> system to be stable.


Could you throw kexec and KVM into the mix? This issue only shows up when we
disable the MMU, which we almost never do.

For CPU offline/online we make the PSCI 'offline' call with the MMU enabled.
When the CPU comes back firmware has reset the EL2/EL1 SCTLR from a higher
exception level, so it won't hit this issue.

One place we do this is kexec, where we drop into purgatory with the MMU disabled.

The other is KVM unloading itself to return to the hyp stub. You can stress this
by starting and stopping a VM. When the number of VMs reaches 0 KVM should
unload via 'kvm_arch_hardware_disable()'.


Thanks,

James
