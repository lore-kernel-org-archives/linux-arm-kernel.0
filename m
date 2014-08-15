From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 15 Aug 2014 13:21:59 +0100
Subject: [PATCH] arm/arm64: KVM: Support KVM_CAP_READONLY_MEM
In-Reply-To: <20140815091550.GS10550@cbox>
References: <1405003351-12973-1-git-send-email-christoffer.dall@linaro.org>
 <8761hvrs4z.fsf@approximate.cambridge.arm.com> <20140815091550.GS10550@cbox>
Message-ID: <CAFEAcA8XqEYsh8RWRf=LiS1A5N+69-X97MsTsfzeqPqs=O21YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2014 10:15, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Thu, Aug 14, 2014 at 04:46:20PM +0100, Marc Zyngier wrote:
>> So the consequence of a write to a ROM region would be to do an IO
>> emulation? That seems a bit weird. Shouldn't we have a separate error
>> path for this (possibly ignoring the write entierely)?

> It's part of the ABI, see Documentation/virtual/kvm/api.txt section
> 4.35:
>
> "The latter [KVM_KVM_READONLY] can be set, if KVM_CAP_READONLY_MEM
> capability allows it, to make a new slot read-only.  In this case,
> writes to this memory will be posted to userspace as KVM_EXIT_MMIO
> exits."

...and the reason for this is so we can execute out of things
like NOR flash devices, which typically have "reads just read
but writes are interpreted as command bytes to do block
erase or write of the flash device" semantics. If userspace
wants "reads should fault" behaviour it can implement it
itself (well, it could if the KVM MMIO API supported having
an MMIO exit return "this should fault", but that's a separate
thing.)

-- PMM
