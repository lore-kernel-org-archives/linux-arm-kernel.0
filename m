From: maxime.hadjinlian@gmail.com (Maxime Hadjinlian)
Date: Tue, 24 Dec 2013 12:17:12 +0100
Subject: [PATCH 2/2] ARM: Kirkwood: DT board setup for LaPlug
In-Reply-To: <20131223164826.GA6535@localhost>
References: <1387813346-16741-1-git-send-email-maxime.hadjinlian@gmail.com>
 <1387813346-16741-2-git-send-email-maxime.hadjinlian@gmail.com>
 <CAGduivwCtQr-6sY92jEydU6uG1QJOSQcqxAKwcxr4viV38vU-Q@mail.gmail.com>
 <20131223164826.GA6535@localhost>
Message-ID: <CAGduivx9tkOrccNhhmCwbFqbF7Yi_EHAFA7ge08_OPzDvChR-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 5:48 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Hi Maxime,
Hi Ezequiel
>
> On Mon, Dec 23, 2013 at 04:47:34PM +0100, Maxime Hadjinlian wrote:
>> I have a slight issue which I could not resolve regarding the Hynix
>> NAND on this platform. Although it worked perfectly well with 3.12,
>> the device is not detected  anymore with the current head of master.
>>
>
> If you do a "git log v3.12..v3.13-rc4 -- drivers/mtd/nand/orion_nand.c"
> you'll see that no changes have been made.
>
> So maybe this new dts v2 is the problem. And if you look in detail you'll
> find you've been bitten by the subtleties of the devicetree!
>
> See below...
>
>> > +       mbus {
>> > +               ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
>> > +               pcie-controller {
>> > +                       status = "okay";
>> > +                       pcie at 1,0 {
>> > +                               status = "okay";
>> > +                       };
>> > +               };
>> > +       };
>
> ^^^^
> Here's the problem: there's two wrong things with the above:
>
> 1. You can't do this... a ranges properties doesn't add on the included
> (dtsi) ranges properties. Instead it replaces the included one, so you have
> to write the entries all over again.
>
> Yes, we know: it sucks! And given we know it sucks, there was a nice
> message warning you about this. From the kirkwood.dtsi
>
>         /* If a board file needs to change this ranges it must replace it completely */
>         ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000     /* internal-regs */
>                   MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000      /* nand flash */
>                   MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000      /* crypto sram */
>           >;
>
> 2. Looking in yet more detail, you're re-adding the internal-regs window.
> I guess it's just a typo, no?
>
> Anyway, I *think* that's what prevented you from getting the NAND to
> work. The correct mbus node should be:
>
>         mbus {
>                 pcie-controller {
>                         status = "okay";
>                         pcie at 1,0 {
>                                 status = "okay";
>                         };
>                 };
>         };
>
>> > +&nand {
>> > +       /* Total size : 512MB */
>> > +       status = "okay";
>> > +
>
> And here: don't you need to add the pinmuxing? Maybe you don't need it,
> but I guess it's the right thing to do.
>
> I hope this helps!
That was it ! Thank you very much, I will resend a v3. Thank you very much.
I will be more carefarch/arm/boot/dts/kirkwood-laplug.dtsull about
this next time.
>
> Merry Christmas...
Merry Christmas to you.
> --
> Ezequiel Garc?a, Free Electrons
> Embedded Linux, Kernel and Android Engineering
> http://free-electrons.com
