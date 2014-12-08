From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 8 Dec 2014 09:33:16 +0100
Subject: [PATCH/RFC] ARM: shmobile: lager: Fix SPI mode of SPI-Flash into
 mode3
In-Reply-To: <20141208003105.GC7420@verge.net.au>
References: <1414648551-30318-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVQ0s35sW=kvf80c0s++R-5uNuJQtxMcX1R5ogxNwkp9w@mail.gmail.com>
 <20141112082242.GU9007@verge.net.au>
 <20141208003105.GC7420@verge.net.au>
Message-ID: <CAMuHMdWcu2JAHUZpymA61SPW82PvaRYZuyp-qMLyTNH8xGuFVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Dec 8, 2014 at 1:31 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Nov 12, 2014 at 05:22:43PM +0900, Simon Horman wrote:
>> On Thu, Oct 30, 2014 at 10:26:33AM +0100, Geert Uytterhoeven wrote:
>> > On Thu, Oct 30, 2014 at 6:55 AM, Simon Horman
>> > <horms+renesas@verge.net.au> wrote:
>> > > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> > >
>> > > In order to change into mode3, CPOL and CPHA bit of SPCMD register
>> > > of MSIOF is changed. Mode3 can avoid intermediate voltage.
>> >
>> > This is the QSPI node, not MSIOF?
>>
>> Indeed.
>>
>> Nakamura-san's patch, which I up-ported, was against the QSPI node
>> but the version I posted below is indeed against the MSIOF.
>>
>> Furthermore, I see that spi-cpol and spi-cpha are already present
>> in the MSIOF node in mainline. I would like to withdraw this patch.
>
> Hi Geert,
>
> coming back to this I'm a little confused.
>
> I believe that the patch below is for the QSPI node and that was
> intended by it. Is such a change appropriate for mainline?

OK. So please change MSIOF to QSPI in the description.

> Should I confirm some details with Nakamura-san?
>
> In mainline spi-cpol and spi-cpha are currently set in the
> MSIOF node but not the QSPI node. I believe the same holds for koelsch too.

According to the Spansion S25FL512S datasheet both mode 0 and mode 3
are supported:

"The difference between the two modes is the clock polarity when the bus
 master is in standby mode and not transferring any data.
   - SCK will stay at logic low state with CPOL = 0, CPHA = 0
   - SCK will stay at logic high state with CPOL = 1, CPHA = 1"

So this looks OK to me.

I gave it a try with a similar change to Koelsch, and it seems to work fine.

>> > > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> > > ---
>> > > Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
>> > >
>> > >  arch/arm/boot/dts/r8a7790-lager.dts | 2 ++
>> > >  1 file changed, 2 insertions(+)
>> > >
>> > > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
>> > > index 830f2e8..1606fad 100644
>> > > --- a/arch/arm/boot/dts/r8a7790-lager.dts
>> > > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>> > > @@ -343,6 +343,8 @@
>> > >                 spi-tx-bus-width = <4>;
>> > >                 spi-rx-bus-width = <4>;
>> > >                 m25p,fast-read;
>> > > +               spi-cpol;
>> > > +               spi-cpha;

Please keep the spi-* properties together, and alphabetically sorted,
i.e. insert
the new ones before spi-max-frequency.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
