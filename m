From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Nov 2018 15:22:50 +0100
Subject: [PATCH 1/4] EFI stub: remove -fdata-sections
In-Reply-To: <20181106142126.GD30658@n2100.armlinux.org.uk>
References: <20181106133935.GB30658@n2100.armlinux.org.uk>
 <E1gK1aT-0000oL-Nn@rmk-PC.armlinux.org.uk>
 <CAKv+Gu_-Vqa=TXDzmzorjcPVnxqO3BHvvDyJKViHFLCsnhfeEw@mail.gmail.com>
 <20181106142126.GD30658@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu_PHbT-KGxfFu3k-C8Fj3qJhDf39G0e5JzMAHT15+LmgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2018 at 15:21, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Nov 06, 2018 at 03:11:18PM +0100, Ard Biesheuvel wrote:
>> On 6 November 2018 at 14:40, Russell King <rmk+kernel@armlinux.org.uk> wrote:
>> > Remove -fdata-sections from the EFI stub build as this causes problems
>> > for the ARM decompressor code.
>> >
>> Just out of curiosity: what kind of problems?
>
> I'm afraid I don't remember - these patches are March 2018.  I suspect
> it was a result of a randconfig build failing to link, as I don't have
> any 32-bit ARM configs that have the EFI stub enabled.
>
> In any case, this will break:
>
> #
> # ARM discards the .data section because it disallows r/w data in the
> # decompressor. So move our .data to .data.efistub, which is preserved
> # explicitly by the decompressor linker script.
> #
> STUBCOPY_FLAGS-$(CONFIG_ARM)    += --rename-section .data=.data.efistub
>
> because with -fdata-sections enabled, there is no longer a single .data
> section, but multiple .data.* sections.  Hence, the rename no longer
> works, and all the EFI stub data ends up being discarded by the
> decompressor link stage.
>

Ah, of course, that must be it.
