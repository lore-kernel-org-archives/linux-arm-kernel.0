From: robh@kernel.org (Rob Herring)
Date: Thu, 12 Nov 2015 21:30:31 -0600
Subject: [PATCH v2 1/4] drm: arm: Add DT bindings documentation for HDLCD
 driver.
In-Reply-To: <20151112104210.GZ963@e106497-lin.cambridge.arm.com>
References: <1447258010-2234-1-git-send-email-Liviu.Dudau@arm.com>
 <1447258010-2234-2-git-send-email-Liviu.Dudau@arm.com>
 <20151111184849.GA9172@rob-hp-laptop>
 <20151112104210.GZ963@e106497-lin.cambridge.arm.com>
Message-ID: <CAL_Jsq+M8cEgLpRJ9j_ULRaGcLgaTZ8rr2F1nv7wUxfEEpZinw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 4:42 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Wed, Nov 11, 2015 at 12:48:50PM -0600, Rob Herring wrote:
>> On Wed, Nov 11, 2015 at 04:06:47PM +0000, Liviu Dudau wrote:
>> > Cc: Rob Herring <robh+dt@kernel.org>
>> > Cc: Pawel Moll <pawel.moll@arm.com>
>> > Cc: Mark Rutland <mark.rutland@arm.com>
>> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> > Cc: Kumar Gala <galak@codeaurora.org>
>> >
>> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>>
>> Looks pretty good, but a few comments.
>>
>> > ---
>> >  .../devicetree/bindings/drm/arm/arm,hdlcd.txt      | 74 ++++++++++++++++++++++
>> >  1 file changed, 74 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/drm/arm/arm,hdlcd.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/drm/arm/arm,hdlcd.txt b/Documentation/devicetree/bindings/drm/arm/arm,hdlcd.txt
>> > new file mode 100644
>> > index 0000000..b57f1b9
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/drm/arm/arm,hdlcd.txt
>> > @@ -0,0 +1,74 @@
>> > +ARM HDLCD
>> > +
>> > +This is a display controller found on several development platforms produced
>> > +by ARM Ltd and in more modern of its' Fast Models. The HDLCD is an RGB
>> > +streamer that reads the data from a framebuffer and sends it to a single
>> > +digital encoder (DVI or HDMI).
>> > +
>> > +Required properties:
>> > +  - compatible: "arm,hdlcd"
>>
>> Kind of generic. Something more specific please.
>
> "There can be only one!" (hdlcd) :) This is going to be a "one version only" HW part.
> ARM has now switched to a new display hardware that has more features and a new name,
> and work on mainlining support for that will start once I get the HDLCD driver accepted.

So there is never going to be a single difference across platforms.
Variations in max clock for different FPGAs?


>> > +  - reg: Physical base address and length of the controller's registers.
>> > +    If a second pair of address and length values is present this specifies
>> > +    the presence of a DMA coherent memory area that the HDLCD can use as
>> > +    framebuffer instead of normal CMA memory.
>>
>> This is on-chip RAM or nornal system RAM? We already have bindings for
>> both.
>
> Juno has a set of TLX (ThinLinks) connectors on the board where an FPGA can be attached. On r1
> the code running on FPGA can even participate as an AXI master with full coherency. The FPGA
> has local memory that we want to share with the HDLCD to be used as a framebuffer.

So describe the memory region and then use a memory-region phandle to
the memory here.

>> > +  - interrupts: One interrupt used by the display controller to notify the
>> > +    interrupt controller when any of the interrupt sources programmed in
>> > +    the interrupt mask register have activated.
>> > +  - clocks: A list of phandle + clock-specifier pairs, one for each
>> > +    entry in 'clock-names'.
>> > +  - clock-names: A list of clock names. For HDLD it should contain:

typo: HDLD

>> > +      - "pxlclk" for the clock feeding the output PLL of the controller.
>> > +  - port: The HDLCD connection to an encoder chip. The connection is modelled

s/modelled/modeled/

Rob
