From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Aug 2014 11:41:41 +0100
Subject: [PATCH V2] ARM/ARM64: KVM: Nuke Hyp-mode tlbs before enabling MMU
In-Reply-To: <20140822102315.GQ21734@leverpostej>
References: <1406789604-10533-1-git-send-email-pranavkumar@linaro.org>
 <20140822102315.GQ21734@leverpostej>
Message-ID: <53F71E65.6020400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/14 11:23, Mark Rutland wrote:
> Hi Pranav,
> 
> On Thu, Jul 31, 2014 at 07:53:23AM +0100, Pranavkumar Sawargaonkar wrote:
>> X-Gene u-boot runs in EL2 mode with MMU enabled hence we might
>> have stale EL2 tlb enteris when we enable EL2 MMU on each host CPU.
> 
> Nit: entries
> 
>> This can happen on any ARM/ARM64 board running bootloader in
>> Hyp-mode (or EL2-mode) with MMU enabled.
>>
>> This patch ensures that we flush all Hyp-mode (or EL2-mode) TLBs
>> on each host CPU before enabling Hyp-mode (or EL2-mode) MMU.
> 
> I hit a similar issue intermittently on a Juno board when I boot Linux
> as an EFI application, where CPU0 would get stuck in a recursive
> exception at EL2 while initialising hyp. We don't nuke the TLBs in
> efi_stub_entry nor do we do so in el2_setup, so there's the possibility
> of stale EL2 TLB entries lying around from UEFI.
> 
> With this patch applied I'm unable to reproduce the issue (with ~30
> boots so far). So:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> It would be nice to see this hit mainline soon.

Thanks for testing. I guess this is a candidate for stable as well.

	M.
-- 
Jazz is not dead. It just smells funny...
