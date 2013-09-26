From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 26 Sep 2013 18:10:21 -0500
Subject: device tree binding documentation outdated
In-Reply-To: <20130926205906.GT12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
Message-ID: <CAHCPf3u9KyoJiAPv6oc_ZdVBqgix41__RAGRXh8z+d5bXO8fQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 3:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

[snip]

I'm sure I saw Shawn Guo throw a patch here that added the new
bindings etc. - did they get missed? Or did I imagine it?

BTW I'll second Fabio's offer of help, if you need it. I'm itching to
get a CuBox-i (or more than one..)

> +       IOMUX_PAD(0x0694, 0x02AC, 1, 0x0818, 1, MX6DL_ENET_PAD_CTRL_PD),/*RGMII RD0*/
> +       IOMUX_PAD(0x0698, 0x02B0, 1, 0x081C, 1, MX6DL_ENET_PAD_CTRL_PD),/*RGMII RD1*/
> +       /* In RGMII mode RD2 should be '1' to disable the PLL OFF mode */
> +       MX6DL_PAD_RGMII_RD2__ENET_RGMII_RD2,
> +       MX6DL_PAD_RGMII_RD3__ENET_RGMII_RD3,
> +       /* In RGMII mode RX_DV should be pulled down for reset strap */
> +       IOMUX_PAD(0x06A4, 0x02BC, 1, 0x0828, 1, MX6DL_ENET_PAD_CTRL_PD),/*RGMII RXCTL*/
>
> The ones which don't are those IOMUX_PAD() ones - what I have so far for
> them (I'm still busy adding to the DT file for everything else) are
> (in order):
>
>         MX6QDL_PAD_ENET_MDIO__ENET_MDIO
>         MX6QDL_PAD_ENET_MDC__ENET_MDC
>         MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 -- ?
>         MX6QDL_PAD_DI0_PIN2__GPIO4_IO18
>         /* RMII */
>         MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN ... extra stuff
>         MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0 ... extra stuff
>         MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1 ... extra stuff
>         MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0
>         MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1
>         MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN
>         MX6QDL_PAD_GPIO_16__ENET_REF_CLK  -- ?
>         MX6QDL_PAD_RGMII_TXC__RGMII_TXC
>         MX6QDL_PAD_RGMII_TD0__RGMII_TD0
>         MX6QDL_PAD_RGMII_TD1__RGMII_TD1
>         MX6QDL_PAD_RGMII_TD2__RGMII_TD2
>         MX6QDL_PAD_RGMII_TD3__RGMII_TD3
>         MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL
>         MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK
>         MX6QDL_PAD_RGMII_RXC__RGMII_RXC
>         MX6QDL_PAD_RGMII_RD0__RGMII_RD0 ... extra stuff
>         MX6QDL_PAD_RGMII_RD1__RGMII_RD1 ... extra stuff
>         /* In RGMII mode RD2 should be '1' to disable the PLL OFF mode */
>         MX6QDL_PAD_RGMII_RD2__RGMII_RD2
>         MX6QDL_PAD_RGMII_RD3__RGMII_RD3
>         /* In RGMII mode RX_DV should be pulled down for reset strap */
>         MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL ... extra stuff
>
> If I have to customize any of these settings, how do I do that?

Do not put them in the binding header, that's for sure. Just list the
6 values required and put a comment next to it.

> Final question is - in imx6qdl.dtsi, I see for instance:
>
>         MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
>
> What does the final number refer to?

The essential definition of fsl,pins is now something like

<MUX_CTL_PAD_offset> <PAD_CTL_PAD_offset> <SELECT_INPUT_offset>
<MUX_value> <SELECT_INPUT_value> <PAD_value>

Essentially the device tree must always have those 6 values, and you
ran into one where the first 5 are defined as a preprocessor macro in
most cases.

The end result is in the i.MX6 manual - the 5 values in the header are
as they are, and 0x1b0b0 is on page 2307 (section 36.4.309,
IOMUXC_SW_PAD_CTL_PAD_ENET_MDIO) of the manual.

It decodes as HYS(EN), PUS(100K_OHM_PU), PUE(PULL), PKE(EN), ODE(DIS),
DSE(40_OHM), SPEED(100MHZ), SRE(SLOW).

You can actually find a good description of the default pad settings
(they are these, exactly) on page 282 of the manual (in table 4-1) for
this pin.

You may note three stupidities here, the first only by grokking the
code in drivers/pinctrl/pinctrl-imx.c:

* The SION bit of the MUX_CTL_PAD_* register is actually kept in the
field for the PAD_CTL_PAD_* value and swapped back in
* Notice that the offsets are ordered mux, pad, input but the value
pairs are ordered as mux, input, pad...

And third, not stupid as "you can't trust the bootloader" and possibly
"the manual could be wrong"..

* Most of the macros are great for readability, but in the DT the pad
setting values - as above ..ENET_MDIO 0x1b0b0 - are chip defaults and
in the manual.. or they're correct in the bootloader anyway making
pinctrl definitions a pain in the ass for doing what you want to do
right now and an effective NOP once you complete it.

The Vybrid binding is more or less just as confusing, as it is define
as mux_off, input_off, mux_mode, input_mode, pad_ctl - the mux_ctl and
pad_ctl registers from i.MX were merged into one, hooray! But there
are two values to define the content of the mux_off register offset..

Thankfully, you ran into this.. I am vindicated in my objections to
the initial patches, which were summarily ignored. This is not why
preprocessing device trees is a good idea, in fact it is the very
definition of the worst possible usage for it. It doesn't make writing
device trees easier - it took me longer to port pinctrl in the tree I
had to the new binding than it did to write the ENTIRE initial tree
with the old pinctrl binding in the first place. Rather than copy
pasting numbers out of the manual, I've ended up searching for those
numbers in a header, cross-referencing the values to ensure they're
correct and meeting my needs, copy pasting the preprocessor define
out, or rewriting 6 individual values anyway because I want a
non-common usage.

The preprocessor macros here just serve to abstract and therefore
obfuscate what is going on. They make the tree more readable at first
glance but they don't help people add new definitions, even with a
binding document (if it existed). It is difficult to cross-reference
the manual and the bindings as the pin namings aren't the same (so no
searching the PDF for those definitions).

I'd rather see patches to rework this to get rid of the preprocessing
completely, and direct people to the manuals instead, comment the
trees like they were before, and instead bind and document any quirks
- there are a couple of pins which must have other IP blocks involved
(IOMUXC_GPRx for example) which aren't covered by the binding except
with some weirdo hacks. Perhaps even spend a couple days trying to
figure out a better way of describing those pins to the pinctrl
subsystem than gluing chicken bits into existing fields like the
hardware did.

It's halfway in place, and the old system is still documented maybe
because it is still in use somewhere... I desperately want to go in
and just fix everything for i.MX5/6 right now but a raft of personal
problems and a severe lack of internet connection at home aren't
making it easy, unfortunately. That, and it would be HUGE churn.

-- 
Matt Sealey <neko@bakuhatsu.net>
