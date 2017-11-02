From: james.morse@arm.com (James Morse)
Date: Thu, 02 Nov 2017 12:14:28 +0000
Subject: [PATCH v4 09/21] KVM: arm/arm64: mask/unmask daif around VHE
 guests
In-Reply-To: <20171030074019.GS2166@lvm>
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-10-james.morse@arm.com> <20171030074019.GS2166@lvm>
Message-ID: <59FB0C24.7080503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 30/10/17 07:40, Christoffer Dall wrote:
> On Thu, Oct 19, 2017 at 03:57:55PM +0100, James Morse wrote:
>> Non-VHE systems take an exception to EL2 in order to world-switch into the
>> guest. When returning from the guest KVM implicitly restores the DAIF
>> flags when it returns to the kernel at EL1.
>>
>> With VHE none of this exception-level jumping happens, so KVMs
>> world-switch code is exposed to the host kernel's DAIF values, and KVM
>> spills the guest-exit DAIF values back into the host kernel.
>> On entry to a guest we have Debug and SError exceptions unmasked, KVM
>> has switched VBAR but isn't prepared to handle these. On guest exit
>> Debug exceptions are left disabled once we return to the host and will
>> stay this way until we enter user space.
>>
>> Add a helper to mask/unmask DAIF around VHE guests. The unmask can only
>> happen after the hosts VBAR value has been synchronised by the isb in
>> __vhe_hyp_call (via kvm_call_hyp()). Masking could be as late as
>> setting KVMs VBAR value, but is kept here for symmetry.

> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks!


>> ---
>> Give me a kick if you want this reworked as a fix (which will then
>> conflict with this series), or a backportable version.
> 
> I don't know of any real-world issues where some more graceful handling
> of SErrors would make sense on older kernels, so I'm fine with just
> merging this together with this series.

What about debug?
> On guest exit Debug exceptions are left disabled once we return to the host
> and will stay this way until we enter user space.

Today VHE:KVM causes the kernel to run with SError unmasked and debug disabled
until the next return to user-space, whereas previously the kernel expected
SError to be masked and debug enabled.


(Reposting just the SError rework without this patch changes the kernel to
expect SError to be unmasked, which isn't making this any worse.)


Thanks,

James
