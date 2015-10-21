From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Wed, 21 Oct 2015 12:18:09 +0100
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <20151019112033.GA10728@bivouac.eciton.net>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <20151019112033.GA10728@bivouac.eciton.net>
Message-ID: <CAD0U-h+cr0xpAAcCD1P8k2hUcJJL2Ga+-Grrb8WaZrgm08G2nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 October 2015 at 12:20, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Mon, Oct 19, 2015 at 11:29:32AM +0100, Mark Rutland wrote:
>> > Correct, I just mentioned so that if you see/get any boot issue report
>> > with NOR flash and CPUIdle enabled, you will have the background instead
>> > of investigating the known issue again.
>>
>> Also, for non U-Boot systems I was under the impression that the flash
>> was effectively owned by EFI (for variable storage), so it doesn't seem
>> like a sensible idea to me to poke the flash behind its back in that
>> case.
>>
>> Given that, I'm not sure that the flash node should be enabled by
>> default in the DT.
>>
>> Leif?
>
> Well, given that it's a NOR device (or even two), it doesn't
> necessarily have to be an all-or-nothing decision.
>
> 0x0BFC0000-0x0BFFFFFF ("erase region 1", the last 256KB) is used for
> the persistent storage. This is hard wired into the UEFI image.
>
> But the rest of the flash consists of whatever the contents of
> images.txt in the magic configuration-via-USB-filesystem says it is.
> I'm not convinced that is written to the device in AFS format.

After a discussion on IRC, Leif asked me to email the list to describe
how AFS works.  I read Linus' code in u-boot [1] to work it out.

There is no global TOC placed in NOR or elsewhere.

Each image stored in NOR flash contains a "footer" at the end of the
last sector of the image.  This footer describes the image, including
it's image "name".

To find all of the images in NOR flash, the AFS code has to scan for
the footer's signature at the end of every sector in flash.  The v1
footer is the last 4 bytes of the sector, the v2 footer is the last 8
bytes.  Juno uses v2 footers.

For example, the first file in Juno's NOR flash is "fip".  It lives at
address 0x08000000 and occupies two 256k sectors (08000000 and
08040000).  So the footer lives at the end of the last sector, from
address 0807ff70 to 0807ffff.

[1] common/cmd_armflash.c
http://git.denx.de/?p=u-boot.git;a=blob;f=common/cmd_armflash.c;h=af453f7b3b84aba97704fd9ff2178d00876b6aad;hb=5ec0003b19cbdf06ccd6941237cbc0d1c3468e2d
