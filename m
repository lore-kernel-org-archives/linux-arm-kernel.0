From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 16:48:21 -0500
Subject: [PATCH v2 1/2] dt-bindings: add bindings doc for ZTE VOU display
 controller
In-Reply-To: <20161009074910.GA15400@tiger>
References: <1474727185-24180-1-git-send-email-shawn.guo@linaro.org>
 <1474727185-24180-2-git-send-email-shawn.guo@linaro.org>
 <20161003174429.GA26054@rob-hp-laptop>
 <20161009074910.GA15400@tiger>
Message-ID: <20161010214821.GA17551@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 09, 2016 at 03:49:10PM +0800, Shawn Guo wrote:
> On Mon, Oct 03, 2016 at 12:44:29PM -0500, Rob Herring wrote:
> > > +Example:
> > > +
> > > +vou: vou at 1440000 {
> > > +	compatible = "zte,zx296718-vou";
> > > +	#address-cells = <1>;
> > > +	#size-cells = <1>;
> > > +	reg = <0x1440000 0x10000>;
> > > +	ranges;
> > 
> > You still have overlapping addresses. Explicitly list the sub ranges in 
> > reg here used by the VOU driver if the driver usage doesn't overlap. If 
> > there is overlap (2 drivers accessing the same range), then you need 
> > some APIs between the components (or possibly regmap).
> 
> The driver matching "zte,zx296718-vou" doesn't map or access the any
> 'reg' address.  The 'reg' property here is more like a hint telling
> that the VOU block covers the address space of all child devices.
> 
> I will simply drop the 'reg' property here.
> 
> > Also, don't do an empty ranges here. Fill it in so the child nodes are 
> > just offsets of 0x1440000
> 
> Okay.  I thought that empty 'ranges' is fine as long as parent and child
> address spaces are identical (1:1 mapping).

It is fine, but it's just better policy to limit the scope of things.

> So with your suggestion, I made the changes below.  Let me know if this
> is still not what you are asking for.

Looks fine. With that,

Acked-by: Rob Herring <robh@kernel.org>

> 
> Shawn
> 
> -----8<-----------------
> 
> diff --git a/Documentation/devicetree/bindings/display/zte,vou.txt b/Documentation/devicetree/bindings/display/zte,vou.txt
> index d03ba4c4810c..6bb4ab2517ef 100644
> --- a/Documentation/devicetree/bindings/display/zte,vou.txt
> +++ b/Documentation/devicetree/bindings/display/zte,vou.txt
> @@ -56,14 +56,13 @@ vou: vou at 1440000 {
>         compatible = "zte,zx296718-vou";
>         #address-cells = <1>;
>         #size-cells = <1>;
> -       reg = <0x1440000 0x10000>;
> -       ranges;
> +       ranges = <0 0x1440000 0x10000>;
>  
> -       dpc: dpc at 1440000 {
> +       dpc: dpc at 0 {
>                 compatible = "zte,zx296718-dpc";
> -               reg = <0x1440000 0x1000>, <0x1441000 0x1000>,
> -                     <0x1445000 0x1000>, <0x1446000 0x1000>,
> -                     <0x144a000 0x1000>;
> +               reg = <0x0000 0x1000>, <0x1000 0x1000>,
> +                     <0x5000 0x1000>, <0x6000 0x1000>,
> +                     <0xa000 0x1000>;
>                 reg-names = "osd", "timing_ctrl",
>                             "dtrc", "vou_ctrl",
>                             "otfppu";
> @@ -74,9 +73,9 @@ vou: vou at 1440000 {
>                               "main_wclk", "aux_wclk";
>         };
>  
> -       hdmi: hdmi at 144c000 {
> +       hdmi: hdmi at c000 {
>                 compatible = "zte,zx296718-hdmi";
> -               reg = <0x144c000 0x4000>;
> +               reg = <0xc000 0x4000>;
>                 interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
> 
