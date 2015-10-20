From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 20 Oct 2015 16:13:48 +0200
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <CACRpkdZxqPwCm2iLZ3sifRqT0Ub0cE_A-Pzd=_K5kTVf5O6LMQ@mail.gmail.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019113904.GE10678@leverpostej>
 <CAKv+Gu9YDBN8Epa+4xH0ert6LBRgfUAdC9OENdD16oQcGHVRXw@mail.gmail.com>
 <CACRpkdZxqPwCm2iLZ3sifRqT0Ub0cE_A-Pzd=_K5kTVf5O6LMQ@mail.gmail.com>
Message-ID: <CAKv+Gu8zkOE_tBmNaW0c+y1V6Am2xawNQ-z2AuKcYAkEG+XHHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 October 2015 at 23:58, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Oct 19, 2015 at 4:40 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>
>> I sent some patches around about a year ago that registers UEFI
>> runtime MMIO regions with /proc/iomem, which should prevent drivers
>> from attaching to the same physical memory regions. With that in
>> place, describing it in the DT would not be a problem, and on devices
>> with multiple NOR flashes of which only one is used at runtime by
>> UEFI, it would allow Linux to still access the other one.
>
> That is very un-kernellike I think, isn't it better that it gets defined as
> an MTD partition?
>

I think it makes perfect sense to reserve an MMIO region if it is in
active use by a driver, which is arguably the case for UEFI Runtime
Services that implement the abstract UEFI variable store on top of a
NOR flash device. Note that it is not the content that is reserved, it
is the fact that resident code may be invoked that assumes that it is
the sole owner of the NOR flash.

So this has nothing to do with partitioning. NOR write commands are
issues to the MMIO base address, and so a driver must own the entire
MMIO range, and not simply a slice that represents the data it is
interested in.

> None of it should affect registering the flash in the device tree
> however, it is indeed the hardware that is there, it is a device tree.
>

Agreed.

> We could discuss switching MTD and/or AFS off for EFI boots,
> but it seems a bit overzealous to me.
>

Nope. Each flash /device/ is either owned by UEFI or by the kernel, not both.

-- 
Ard.
