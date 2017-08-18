From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 18 Aug 2017 16:20:16 +0100
Subject: [PATCH] arm64: kaslr: Adjust the offset to avoid Image across
 alignment boundary
In-Reply-To: <20170818151920.jpugpcgwiavgwgaf@armageddon.cambridge.arm.com>
References: <20170818150435.35224-1-catalin.marinas@arm.com>
 <20170818151920.jpugpcgwiavgwgaf@armageddon.cambridge.arm.com>
Message-ID: <CAKv+Gu8kXLGNc+iGc8ERUfFR=po5tL7ZBaSrqH_fOzythkHA6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 August 2017 at 16:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Aug 18, 2017 at 04:04:34PM +0100, Catalin Marinas wrote:
>> With 16KB pages and a kernel Image larger than 16MB, the current
>> kaslr_early_init() logic for avoiding mappings across swapper table
>> boundaries fails since increasing the offset by kimg_sz just moves the
>> problem to the next boundary.
>>
>> This patch decreases the offset by the boundary overflow amount, with
>> slight risk of reduced entropy as the kernel is more likely to be found
>> at kimg_sz below a swapper table boundary.
>>
>> Trying-to-fix: afd0e5a87670 ("arm64: kaslr: Fix up the kernel image alignment")
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>
>> While preparing this email, I noticed that the kernel eventually failed
>> to boot, though after a lot more reboot iterations. Mark Rutland also
>> managed to make the KASLR kernel fail to boot with 64K pages which
>> wouldn't be explained by this patch.
>>
>> So, any suggestions are welcome. My testing method, qemu starting a
>> guest in a loop with virtio-rng-pci.
>
> Apparently, the booting gets much more stable if I disable the physical
> relocation in arm64-stub.c (but keep the virtual one with the fix in
> this patch). So I guess we are chasing two different issues.
>

So this is using QEMU with 16k pages support?
