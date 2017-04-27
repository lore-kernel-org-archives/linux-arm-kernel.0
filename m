From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Apr 2017 16:57:37 -0500
Subject: [PATCH 1/2] dt/bindings: Add bindings for Broadcom STB DRAM
 Sensors
In-Reply-To: <CAGt4E5uu1Ty0ReaiBZ0kcR_-jnqJQL8vgU4Y9mL64FP7f+=T7Q@mail.gmail.com>
References: <20170418201702.57019-1-code@mmayer.net>
 <20170418201702.57019-2-code@mmayer.net>
 <CAGt4E5susQWWNZPbNh8AoWtK-4yu50VL=GqOw+_2w_FA+2V68Q@mail.gmail.com>
 <CAGt4E5uu1Ty0ReaiBZ0kcR_-jnqJQL8vgU4Y9mL64FP7f+=T7Q@mail.gmail.com>
Message-ID: <20170427215737.dmnj4u2e4tfc6vfv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 11:28:37AM -0700, Markus Mayer wrote:
> On 25 April 2017 at 12:29, Markus Mayer <markus.mayer@broadcom.com> wrote:
> > Hi Rob,
> >
> > On 18 April 2017 at 13:17, Markus Mayer <code@mmayer.net> wrote:
> >> From: Markus Mayer <mmayer@broadcom.com>
> >>
> >> Provide bindings for the Broadcom STB DDR PHY Front End (DPFE).
> >
> > Would you be able to have a look at this binding? The driver won't be
> > upstreamed as hwmon driver (as per Guenter's comments). I am currently
> > converting the driver to a "soc" driver instead, but the proposed
> > binding remains unchanged.
> >
> > If you have comments or suggestions, I would like to incorporate them
> > with the new series I will be sending out.
> 
> To explain a bit more what we are looking for: we had a internal
> discussions how to structure this binding and are looking for some
> guidance.
> 
> Should we create three different nodes for the three different memory
> areas (dpfe-cpu at ..., dpfe-dmem at ..., dpfe-imem at ...), each with a single
> "reg" property (which is the proposal below) or should this be one
> single property with 3 "reg" cells, i.e. something like this:

Either way could be okay. It is conceptually 1 thing or 3?

> 
> dpfe-cpu at f1132000 {
>     ...
>     reg = <0xf1132000 0x180     /* register space */
>            0xf1134000 0x1000    /* data memory */
>            0xf1138000 0x4000>;  /* instruction memory */
>     ...
> };
> 
> Regards,
> -Markus
> 
> >> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> >> ---
> >>  .../devicetree/bindings/hwmon/brcmstb-dpfe.txt     | 68 ++++++++++++++++++++++
> >>  1 file changed, 68 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/hwmon/brcmstb-dpfe.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/brcmstb-dpfe.txt b/Documentation/devicetree/bindings/hwmon/brcmstb-dpfe.txt
> >> new file mode 100644
> >> index 0000000..3519197
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/hwmon/brcmstb-dpfe.txt
> >> @@ -0,0 +1,68 @@
> >> +DDR PHY Front End (DPFE) for Broadcom STB
> >> +=========================================
> >> +
> >> +DPFE and the DPFE firmware provide an interface for the host CPU to
> >> +communicate with the DCPU, which resides inside the DDR PHY.
> >> +
> >> +There are three memory regions for interacting with the DCPU.
> >> +
> >> +The DCPU Register Space
> >> +-----------------------
> >> +
> >> +Required properties:
> >> +  - compatible: must be one of brcm,bcm7271-dpfe-cpu, brcm,dpfe-cpu-v12.0.0.0
> >> +    or brcm,dpfe-cpu

3 compatibles is a bit excessive. You can always use 
brcm,bcm7271-dpfe-cpu as a fallback for other chips. I wouldn't expect a 
DDR phy to be around a long time without changes given process and DDR 
technology changes.

> >> +  - reg: must reference the start address and length of the DCPU register
> >> +    space
> >> +
> >> +Optional properties:
> >> +  - cell-index: the index of the DPFE instance; will default to 0 if not set

Don't use cell-index. It's not a valid property for FDT (only real 
OpenFirmware).

Rob
