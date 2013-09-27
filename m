From: neko@bakuhatsu.net (Matt Sealey)
Date: Fri, 27 Sep 2013 10:40:03 -0500
Subject: device tree binding documentation outdated
In-Reply-To: <20130927122814.GK25146@S2101-09.ap.freescale.net>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <CACRpkda9HZ4JKnidnJJh-HkhCgtvJwQPQJnv9CZ4iYcQP36_Nw@mail.gmail.com>
 <20130927025116.GG25146@S2101-09.ap.freescale.net>
 <20130927084504.GW12758@n2100.arm.linux.org.uk>
 <20130927122814.GK25146@S2101-09.ap.freescale.net>
Message-ID: <CAHCPf3tZCTp_-W-BDjCg3=iUfP1GYJYQ+WrV_y-2K98zgg-odA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn, Russell,

Okay I have a proposal that might make this much easier. Why not
redefine the preprocessor macros as follows (one used as an example)

/* MUX_CTL definitions */
#define SION    0x10
#define ALT0    0x0
#define ALT5   0x5
#define GPIO ALT5

#define SD2_DAT1_MUX 0x04c
#define SD2_DAT1_INP 0x000
#define SD2_DAT1_CTL 0x360
#define SD2_DAT1__SD2_DATA1 0x0 ALT0
#define SD2_DAT1__SD2_DATA1_PAD 0x1b0b0
#define SD2_DAT1__GPIO1_IO14 0x0 ALT5
#define SD2_DAT1__GPIO1_IO14_PAD 0x1b0b0

#define IOMUX_R(name, function, mux_r, inp_r, pad_r, mux_v, inp_v, pad_v) \
                         mux_r pad_r inp_r mux_v inp_v pad_v

#define IOMUX_V(name, function, mux_v, inp_v, pad_v) \
                        name##_MUX name##_CTL name##_INP mux_v inp_v pad_v

#define IOMUX_P(name, function, pad_v) \
                        name##_MUX name##_CTL name##_INP
name##__##function pad_v

#define IOMUX_F(name, function)  \
                        name##_MUX name##_CTL name##_INP
name##__##function name##_##function##_PAD

Then you can have, in your lists;

fsl,pins = <  IOMUX_R(SD2_DAT1, SD2_DATA1, 0x04c, 0x000, 0x360, 0x0,
0x0, 0x1b0b0)    // long form, define pad name, function name,
register offsets, data. function is ignored.
          //         IOMUX_V(SD2_DAT1, SD2_GPIO1_IO14, 0x0, 0x15,
0x1b0b0)                          // short form, define pad name,
function name, data. function is ignored. We didn't use a prebaked ALT
define since we want to set the SION bit.
         //         IOMUX_P(SD2_DAT1, SD2_GPIO1_IO14, 0x1b0b0)
                               // short form, define pad name,
function name, pad settings.
         //         IOMUX_F(SD2_DAT1, SD2_DATA1)
                                              // beginner form, use a
prebaked value for all of the above. function is used to generate the
above.


Which gives the best of all worlds - you know the pad name, and
function type at every step. At the point someone is twiddling with
pad settings that aren't preprovided (or the defaults..) I do not
believe that it is worthwhile to "hide" the three data values. For the
uses where a custom board pin name wants to be used, SD2_DAT1,
SABRESD_WIFI_RST can be used in the IOMUX_V definition to give it some
meaning, and it will be ignored. In the worst case boards get lists of
definitions at the top of their .dts which define pin/pad names and
functions.

I did figure out that the headers are included explicitly by the
files, so in fact MX6QDL_PAD_BLAH_PREFIX_SD2_DAT1__SD2_DATA1 is
totally long-form and pointless. As above, fixed.

Also I noticed that none of the headers have guards on them, some of
the dtsi/dts don't include them and assume lower levels do. That's not
a great assumption to make.

This way I don't think I need to reorder the fsl,pins numbering at all
(although it is driving me nuts), and the macro can take into account
the weird order by normalizing it in the macro definition (as above).

I'll be throwing a patch for this out on the weekend. Can we wait on
the docs until we can define this properly? I want to ask for
'approval' first if only because rehashing all these files and
cross-checking preprocessed output (BTW.. I'll make a patch for
keeping pre-processed dts output) to compare results will take a VERY
long time for all these boards, and I won't submit a patch until it's
done.. maybe I'll start with Babbage since nobody uses it, and then
commit the Efika MX tree (finally) with the rehash then move to MX53
(I only have an old Quickstart) and MX6 for Cubox, Utilite, maybe
SabreSD and SabreLite (== Steev will you be able to test this? Which
i.MX boards do you have floating@your place?)
