From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 26 Jun 2018 10:19:27 +0200
Subject: [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <CACRpkdb1GksbePt6XgePCD6g-z4fxY-LF-gpyRfQVxCrq226fg@mail.gmail.com>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <CAK8P3a2KqoX-squhGc8TBuJ==8xxELsuy-H+c1+C7Fu7Z4OjDA@mail.gmail.com>
 <CAKv+Gu-gAkfRsEUOc=iyxi6Twvg9cbvWNqNHRS2HzUDZg8xUhg@mail.gmail.com>
 <CACRpkdb1GksbePt6XgePCD6g-z4fxY-LF-gpyRfQVxCrq226fg@mail.gmail.com>
Message-ID: <CAKv+Gu8cXxQWbnB++adGx=xwAzuM9jqxkCOznk1qP5r=P4vxrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 June 2018 at 10:09, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 18, 2018 at 3:22 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>
>> We should also consider firmware use of the mezzanines. For instance,
>> the Secure96 has a RNG which UEFI may want to use so the early boot
>> code can access is for KASLR. It also has a TPM, which should not be
>> reset/reinitialized/etc by the OS if we want to make meaningful use of
>> it.
>
> This problem: sharing or dedicating a piece of hardware to UEFI or
> the TrustZone secure world is a generic problem not related to
> mezzanines or plug-in boards specifically.
>
> c.f.
> arch/arm64/boot/dts/arm/juno-motherboard.dtsi:
>
> flash at 0,00000000 {
>         /* 2 * 32MiB NOR Flash memory mounted on CS0 */
>         compatible = "arm,vexpress-flash", "cfi-flash";
>         linux,part-probe = "afs";
>         reg = <0 0x00000000 0x04000000>;
>         bank-width = <4>;
>         /*
>          * Unfortunately, accessing the flash disturbs
>          * the CPU idle states (suspend) and CPU
>          * hotplug of the platform. For this reason,
>          * flash hardware access is disabled by default.
>          */
>         status = "disabled";
> };
>
> What we need for this is something like
>
> status = "secure-world-exclusive";
> status = "UEFI-exclusive";
>
> Or something like the same when using device tree.
>

I agree that this is *also* a problem. But it is not what I was talking about.

My example is about peripherals that firmware and OS should both drive
natively, and in the TPM case, the OS should be mindful of the fact
that the measured state should be preserved. Also, it means that we
may be duplicating functionality between the OS and firmware [as
usual] so it might make sense to come up with something that takes
both use cases into account.

> If people probe this from sysfs (as in my example) they are
> obviously not novice users and they know what they are
> doing. For a simple user experience, I suspect device tree
> is what we want to use to populate defaults.
>
>> So ideally, DTs can be expressed such that older kernels can still use
>> those peripherals.
>
> That kind of expressions are possible already, such as
> putting the TPM DT node inside a SoC-specific I2C bus
> node. The boot loader can do that for example.
>
> Then they can't also probe the same board from userspace,
> obviously. No matter whether they use the idea I present
> here or device tree overlays or anything else.
>

OK.
