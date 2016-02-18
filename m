From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 18 Feb 2016 23:14:57 +0200
Subject: [PATCH/RFC v2 01/11] PM / Domains: Add DT bindings for the R-Car
 System Controller
In-Reply-To: <CAMuHMdXqVL6_P6Lnea6z8jFtR2v4NFnzn=ibZVyauZ8-ODb6dg@mail.gmail.com>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
 <20160218143826.GB9654@rob-hp-laptop>
 <CAMuHMdXqVL6_P6Lnea6z8jFtR2v4NFnzn=ibZVyauZ8-ODb6dg@mail.gmail.com>
Message-ID: <15010857.2cVvcc6676@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Thursday 18 February 2016 18:18:56 Geert Uytterhoeven wrote:
> On Thu, Feb 18, 2016 at 3:38 PM, Rob Herring <robh@kernel.org> wrote:
> > On Mon, Feb 15, 2016 at 10:16:50PM +0100, Geert Uytterhoeven wrote:
> >> The Renesas R-Car System Controller provides power management for the
> >> CPU cores and various coprocessors, following the generic PM domain
> >> bindings in Documentation/devicetree/bindings/power/power_domain.txt.
> >> 
> >> This supports R-Car Gen1, Gen2, and Gen3.
> >> 
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> 
> >> Alternatives I considered:
> >>   - Using a single node per power register block, even if it contains
> >>     multiple domains, e.g.:
> >>           pd_ca15_scu: ca15_scu at 180 {
> >>                   reg = <0x180 0x20>;
> >>                   #address-cells = <1>;
> >>                   #size-cells = <0>;
> >>                   #power-domain-cells = <0>;
> >>                   renesas,interrupt-bits = <12>;
> >>                   
> >>                   pd_ca15_cpu: ca15_cpu at 40 {
> >>                           reg = <0x40 0x20>;
> >>                           #power-domain-cells = <1>;
> >>                           renesas,pm-domain-indices = <0 1>;
> >>                           renesas,pm-domain-names =
> >>                                   "ca15_cpu0", "ca15_cpu1";
> >>                           renesas,interrupt-bits = <0 1>;
> >>                   };
> >>           };
> >>     
> >>     Notes:
> >>       - You cannot just have a property with the number of domains, as
> >>       index 0 is not used on R-Car H1. Hence the need for
> >>       "renesas,pm-domain-indices" and "renesas,interrupt-bits",
> >>       - "#power-domain-cells = <1>" for nodes with multiple domains,
> >>       which allows typos in "power-domains = <&pd_ca15_cpu n>", using
> >>       an invalid value of "n".
> >>   
> >>   - Using a linear description in DT:
> >>       - Needs parent links for subdomains,
> >>       - More complicated to parse (lesson learned from R-Mobile PM
> >>       Domain support).
> >>   
> >>   - Keeping the power register block offset and the bit number as
> >>   separate
> >>     "reg" cells, increasing "#address-cells" from 2 to 3,
> >>   
> >>   - Merging the interrupt bit (which needs only 5 bits) in the other
> >>   "reg"
> >>     cell, decreasing "#address-cells" from 2 to 1.
> > 
> > I think I'd move to not encoding mulitple things into reg. This seems
> > like a bit of abuse of reg. Otherwise, I don't have much to comment on.
> 
> Thanks!
> 
> (quoting the encoding of the reg properties)
> 
> > +== PM Domain Nodes ==
> > +
> > +Each of the PM domain nodes represents a PM domain, as documented by the
> > +generic PM domain bindings in
> > +Documentation/devicetree/bindings/power/power_domain.txt.
> > +
> > +Required properties:
> > +  - #power-domain-cells: Must be 0.
> > +  - reg: This property must contain 2 values:
> > +          - The first value is the number of the interrupt bit
> > representing
> > +            the power area in the various Interrupt Registers (e.g.
> > SYSCISR,
> > +            Interrupt Status Register),
> > +          - The second value encodes the power register block offset
> > (which is
> > +            a multiple of 64), and the number of the bit representing the
> > +            power area in the various Power Control Registers (e.g.
> > PWROFFSR,
> > +            Power Shutoff Status Register). This value is created by
> > ORing
> > +            these two numbers.
> 
> Not encoding multiple things into reg means adding more properties to
> provide that information, iff we want to describe the PM Domain Nodes in
> DT. I considered the reg property a two-dimensional address space.
> 
> Taking the lessons from CCF and the new CPG/MSSR bindings into account
> (which was BTW designed after the SYSC DT bindings), perhaps the PM Domain
> hierarchy should be moved from DT to C, in the driver, too?
> 
> That would mean we have in DT:
>   1) "#power-domain-cells = <1>"
>   2) defines for the various domains, e.g. "#define R8A7791_PD_CA15_SCU     
> 12"
>   3) e.g. "power-domains = <&sysc R8A7791_PD_CA15_SCU>"
>   4) and we can get rid of the fallback compatibility strings again.
> 
> Thoughts?

That simplifies DT and will give more flexibility to handle all the weird 
details in C code, so I like it.

Additionally the amount of per-SoC data related to power domains is pretty 
limited, so we shouldn't have a size issue, even for multi-platform kernels. 
The removal of DT parsing code might even make the kernel smaller. The only 
driver I'm concerned about when it comes to per-SoC data size is the PFC 
driver.

-- 
Regards,

Laurent Pinchart
