From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 24 Jan 2017 12:49:00 -0800
Subject: [PATCH 00/22] Conversion of ARMv4 Gemini to DT and multiplatform
In-Reply-To: <CACRpkdY1A8QbKVV0-ZFeH-n0zYpmJkoGj5vA0Ov-DDhBTJf5_w@mail.gmail.com>
References: <20170122121506.9995-1-linus.walleij@linaro.org>
 <8e705d3a-ff99-23b2-c4c9-2edccf134cac@gmail.com>
 <CACRpkdbdsNU6pOcewyZw_jpXzXvm_aj0FURY7Ty5FkT227iZ=Q@mail.gmail.com>
 <alpine.LNX.2.00.1701241734140.2736@T420s>
 <CACRpkdY1A8QbKVV0-ZFeH-n0zYpmJkoGj5vA0Ov-DDhBTJf5_w@mail.gmail.com>
Message-ID: <6a6f3b79-18d7-3243-6a5c-2dc9a3755aa9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2017 12:47 PM, Linus Walleij wrote:
> Hans, Florian et al: does any of you have a copy of the kernel source
> dump(s) from Teltonika, Raidsonic or Wiliboard?
> 
> Would be nice to have the stuff that vendors are using.
> 
> On Tue, Jan 24, 2017 at 6:24 PM, Hans Ulli Kroll
> <ulli.kroll@googlemail.com> wrote:
> 
>> AFAICR
>> This is a dual GMAC !
>>
>> They are two different base address for each GMAC and one shared
>> base address for both of them.
>> This is all in one address space which remaps the driver.
>>
>> And to make it worse two interrupt lines, one of them is also shared.
>>
>> Any ideas to "convert" this into DT ??
>> Because I think it's impossible to split both GMAC interfaces ??
> 
> Sounds odd.  Yeah hardware.h lists this:
> 
> #define GEMINI_TOE_BASE         0x60000000
> #define GEMINI_GMAC0_BASE       0x6000A000
> #define GEMINI_GMAC1_BASE       0x6000E000
> 
> I guess one approach is to make a driver handling all of it in one,
> let it ioremap all regions and support one or two GMACs on the same
> TOE. More complex solutions is to share the TOE using
> syscons regmap mechanism but it looks cumbersome.
> 
> {
>    compatible = "cortina,genesis-gmac-ethernet";
>    reg = <0x60000000 0xa000>, <0x6000a000 0x4000>, <0x6000e000 0x4000>;
>    interrupts = <1 IRQ_TYPE_LEVEL_HIGH>, <2 IRQ_TYPE_LEVEL_HIGH>;
> }
> 
> Or something like that?

I'd recommend looking at how mv643xx_eth does it, there are shared and
individual portions of the register set in there, with concepts of
"ports" which result in network device instances.
-- 
Florian
