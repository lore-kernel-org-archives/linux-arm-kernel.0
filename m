From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 30 Dec 2013 16:18:43 +0100
Subject: [PATCH 4/6] [RFC] Documentation: dt: Add Renesas RSPI/QSPI
 bindings
In-Reply-To: <CAMuHMdUnf77Z1u=d8zFZk0vQtGJ9QhhCk6KVJsVKS-iMFSMUKw@mail.gmail.com>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
 <2582506.8vb3LhHISh@avalon>
 <CAMuHMdUnf77Z1u=d8zFZk0vQtGJ9QhhCk6KVJsVKS-iMFSMUKw@mail.gmail.com>
Message-ID: <3193607.9r7LL0m5xX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Monday 30 December 2013 10:37:24 Geert Uytterhoeven wrote:
> On Mon, Dec 30, 2013 at 12:22 AM, Laurent Pinchart wrote:
> > On Friday 27 December 2013 20:01:53 Geert Uytterhoeven wrote:
> >> On Fri, Dec 27, 2013 at 5:18 PM, Laurent Pinchart wrote:
> >> > On Tuesday 24 December 2013 12:56:48 Geert Uytterhoeven wrote:
> >> >> +++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
> >> >> @@ -0,0 +1,27 @@
> >> >> +Device tree configuration for Renesas RSPI/QSPI driver
> >> >> +
> >> >> +Required properties:
> >> >> +- compatible      : "renesas,rspi-<soctype>". "renesas,rspi-rz" as
> >> >> fallback,
> >> >> +                    or
> >> >> +                    "renesas,qspi-<soctype>", "renesas,qspi-rcar" as
> >> >> fallback.
> >> > 
> >> > I think you need to be a bit more verbose here and explain when to use
> >> > rspi and when to use qspi. I'm also wondering where we need the -rz and
> >> > -
> >> > rcar
> >> 
> >> OK.
> >> 
> >> > suffixes for the generic compatible strings.
> >> 
> >> The rationale behind this is that RSPI DT would apply to RSPI on RZ/A1H.
> >> The spi-rspi driver also supports legacy SH7757, which may not move to
> >> DT anytime soon.
> >> For symmetry, I did the same thing for QSPI, which applies to QSPI
> >> on R-Car H2 and M2 (upon second look, it should be
> >> "renesas,qspi-rcar-gen2", as E1/M1/H1 have HSPI).
> >> 
> >> Does this makes sense? Or do you still prefer plain "renesas,rspi" and
> >> "renesas,qspi", and perhaps "renesas,rspi-sh" if we ever get DT there?
> > 
> > The compatible strings should define what the device is compatible with.
> > They should start with the most specific compability and end with the
> > less specific one. In this case we definitely want to list the
> > SoC-specific compatible string first, even if we don't need it, as
> > experience with Renesas SoC shows that subtle differences between
> > different versions of the same IP core can be discovered later. If all
> > RSPI cores are similar enough to be supported by a single driver
> > configuration, then I believe "renesas,rspi" would be a proper second
> > compatible string. If the RSPI cores in the SH and RZ chips are
> > incompatible then we need two different strings. The same is true for
> > QSPI.
> > 
> > A quick look at the driver shows that RSPI is supported without caring
> > whether the SoC is an SH or ARM, so I believe "renesas,rspi" should do.
> > The question
>
> There are subtle register differences between RSPI on SH7757 and RZ/A1H,
> cfr. what rspi_parse_platform_data() does when no platform_data is
> passed[*]. RSPI on RZ/A1H seems to be an evolutionary step from RSPI on SH
> towards QSPI on RCar Gen2 (but without Dual/Quad).
> 
> [*] setup-sh7757.c doesn't pass platform data, although the rspi driver and
> its platform data has support for DMA on SH7757, which is not used by
> setup-sh7757.c nor any other in-tree platform.

The only important difference I can see (beside the hardcoded 16-bit width 
which could be selected as the default) is that the SSH7757 RSPI has no SPL 
bits in SPDCR. I don't have access tot he SH7757 datasheet, could you please 
confirm that ?

> > in my opinion is whether we want to use
> > 
> > compatible = "renesas,rspi-r7s72100", "renesas,rspi";
> > 
> > or
> > 
> > compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz", "renesas,rspi";
> 
> So we end up with:
> 
> compatible = "renesas,sh7757", "renesas,rspi-sh" (SH legacy)
> compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz" (Genmai)
> compatible = "renesas,rspi-r8a7790", "renesas,qspi" (Lager)
> compatible = "renesas,rspi-r8a7791", "renesas,qspi" (Koelsch)

Don't you mean "renesas,qspi-r8a7790" and "renesas,qspi-r8a7791" ?

-- 
Regards,

Laurent Pinchart
