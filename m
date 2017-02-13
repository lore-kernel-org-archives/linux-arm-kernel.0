From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 13 Feb 2017 10:20:32 +0100 (CET)
Subject: [PATCH 00/22] Conversion of ARMv4 Gemini to DT and multiplatform
In-Reply-To: <FC5B4F97116B48439B455474D032A2F1087BAD65@FTCPCS74.faraday.com.tw>
References: <20170122121506.9995-1-linus.walleij@linaro.org>
 <8e705d3a-ff99-23b2-c4c9-2edccf134cac@gmail.com>
 <CACRpkdbdsNU6pOcewyZw_jpXzXvm_aj0FURY7Ty5FkT227iZ=Q@mail.gmail.com>
 <alpine.LNX.2.00.1701241734140.2736@T420s>
 <CACRpkdY1A8QbKVV0-ZFeH-n0zYpmJkoGj5vA0Ov-DDhBTJf5_w@mail.gmail.com>
 <6a6f3b79-18d7-3243-6a5c-2dc9a3755aa9@gmail.com>
 <alpine.LNX.2.00.1701301702420.14503@T420s>
 <CACRpkdbUOR76fjb_UvuiQHq22oAji8zwMAxmJV1dRA5V9DEQQw@mail.gmail.com>
 <alpine.LNX.2.00.1702111853460.32439@T420s>
 <FC5B4F97116B48439B455474D032A2F1087BAD65@FTCPCS74.faraday.com.tw>
Message-ID: <alpine.LNX.2.00.1702131013210.25980@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Mon, 13 Feb 2017, John Feng-Hsin Chiang(???) wrote:

> Hi Hans,
> 
> > HI Linus,
> > 
> > On Sat, 11 Feb 2017, Linus Walleij wrote:
> > 
> > > On Mon, Jan 30, 2017 at 5:35 PM, Hans Ulli Kroll
> > > <ulli.kroll@googlemail.com> wrote:
> > > > On Tue, 24 Jan 2017, Florian Fainelli wrote:
> > > >> On 01/24/2017 12:47 PM, Linus Walleij wrote:
> > >
> > > >> >> This is a dual GMAC !
> > > >> >>
> > > >> >> They are two different base address for each GMAC and one shared
> > > >> >> base address for both of them.
> > > >> >> This is all in one address space which remaps the driver.
> > > >> >>
> > > >> >> And to make it worse two interrupt lines, one of them is also shared.
> > > >> >>
> > > >> >> Any ideas to "convert" this into DT ??
> > > >> >> Because I think it's impossible to split both GMAC interfaces ??
> > > >> >
> > > >> > Sounds odd.  Yeah hardware.h lists this:
> > > >> >
> > > >> > #define GEMINI_TOE_BASE         0x60000000
> > > >> > #define GEMINI_GMAC0_BASE       0x6000A000
> > > >> > #define GEMINI_GMAC1_BASE       0x6000E000
> > > >> >
> > > >> > I guess one approach is to make a driver handling all of it in
> > > >> > one, let it ioremap all regions and support one or two GMACs on
> > > >> > the same TOE. More complex solutions is to share the TOE using
> > > >> > syscons regmap mechanism but it looks cumbersome.
> > > >> >
> > > >> > {
> > > >> >    compatible = "cortina,genesis-gmac-ethernet";
> > > >> >    reg = <0x60000000 0xa000>, <0x6000a000 0x4000>,> <0x6000e000 0x4000>;
> > > >> >    interrupts = <1 IRQ_TYPE_LEVEL_HIGH>, <2> IRQ_TYPE_LEVEL_HIGH>;
> > > >> > }
> > > >> >
> > > >> > Or something like that?
> > > >
> > > > For addresses, base is here, for both interfaces
> > > > #define GEMINI_TOE_BASE                 0x60000000
> > > > and now for each interface, offset to the above code is from the
> > > > headerfile of the openwrt driver.
> > > > #define TOE_GMAC_DMA_BASE(x)            (0x8000 + 0x4000 * (x))
> > > > #define TOE_GMAC_BASE(x)                (0xA000 + 0x4000 * (x))
> > > >
> > > > maybe some other registers to
> > > > #define TOE_NONTOE_QUE_HDR_BASE         0x2000
> > > > #define TOE_TOE_QUE_HDR_BASE            0x3000
> > > > #define TOE_V_BIT_BASE                  0x4000
> > > > #define TOE_A_BIT_BASE                  0x6000
> > > >
> > > > AFAICR
> > > > The TOE part was "invented" for the gigabit interface.
> > > > They need to speed up the NIC because without TCP offloading you
> > > > will get only fast ethernet speed on a gigabit NIC.
> > >
> > > I was suspecting that this ethernet is related to the Faraday ethernet
> > > driver that was merged in drivers/net/ethernet/faraday since so many
> > > other Gemini parts seems to be coming essentially directly from Faraday.
> 
> 1. Faraday have no TOE design in GMAC, and the GMAC in Gemini is very old one (licensed to Storlink about 13 years ago)
> 2. Storlink may modify the GMC design and add TOE function in it to fit their SoC.
> 

Yeah, this was also my idea.
Storlink need to speed up their GMAC NIC, so they do some tricks here.

> > >
> > > I looked through the header files etc there but the registers seem
> > > quite different ... :/
> > >
> > > Still it is using the same "GMAC" naming and I strongly suspect this
> > > is an older Faraday IP that should go into the same driver folder.
> 
> Yes, This is not the same one as Faraday's.
> 
> > >
> > > Cc:ing some Faraday and Andestech emails to see if we can get some
> > > clarity in this. It would be nice if someone could atleast say "oh
> > > it's this IP FTxxx from Faraday" so we know what to name it.
> > >
> 
> You should think this IP is from Storlink
> 

I'll do. Thanks for the hint here, John.

Greetings
Hans Ulli Kroll
