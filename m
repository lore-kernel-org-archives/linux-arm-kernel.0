From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 26 Feb 2018 09:22:13 +0000
Subject: [RFC PATCH] irqchip/gic-v3-its: apply ACPI device based quirks
In-Reply-To: <20180213141118.3092-1-ard.biesheuvel@linaro.org>
References: <20180213141118.3092-1-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu8pGzrgQk2nGMeOXL_d2bPx_BOZVBZ6PvHkR8EcbVDNRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 February 2018 at 14:11, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Reapply the SynQuacer quirk for ITS frames that are matched by 'SCX0005'
> based ACPI devices, replacing the dummy fwnode with the one populated by
> the ACPI device core.
>
> This allows the SynQuacer ACPI tables to publish a device node such
> as
>
>     Device (ITS0) {
>       Name (_HID, "SCX0005")
>       Name (_ADR, 0x30020000)
>       Name (_DSD, Package ()  // _DSD: Device-Specific Data
>       {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>           Package (2) {
>             "socionext,synquacer-pre-its",
>             Package () { 0x58000000, 0x200000 }
>           },
>         }
>       })
>     }
>
> which will trigger the existing quirk that replaces the doorbell
> address with the appropriate address in the pre-ITS frame.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Marc, Lorenzo,
>
> I am aware that this patch may be seen as controversial, but I would like to
> propose it nonetheless. The reason is that this is the only thing standing in
> the way of full ACPI support in Socionext SynQuacer based platforms.
>
> The pre-ITS is a monstrosity, but as it turns out, Socionext had help from
> ARM designing it, and the reason we need DT/ACPI based quirks in the first
> place is that the IIDR of this GICv3 implementation is simply the ARM Ltd.
> one (as they designed the IP)
>
> Please take this into consideration when reviewing this patch,
>

Ping?
