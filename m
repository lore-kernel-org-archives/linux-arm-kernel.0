From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 03 Aug 2018 11:55:14 +0300
Subject: [RESEND PATCH v5 2/3] dt-bindings: display: atmel: optional
 video-interface of endpoints
In-Reply-To: <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
References: <20180803072308.14962-1-peda@axentia.se>
 <20180803081128.GA4528@w540>
 <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
Message-ID: <3057649.ixkh6hxoBL@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

(CC'ing Sakari Ailus)

On Friday, 3 August 2018 11:40:02 EEST Peter Rosin wrote:
> On 2018-08-03 10:11, jacopo mondi wrote:
> > On Fri, Aug 03, 2018 at 09:23:07AM +0200, Peter Rosin wrote:
> >> With bus-type/bus-width properties in the endpoint nodes, the video-
> >> interface of the connection can be specified for cases where the
> >> heuristic fails to select the correct output mode. This can happen
> >> e.g. if not all RGB pins are routed on the PCB; the driver has no
> >> way of knowing this, and needs to be told explicitly.
> >> 
> >> This is critical for the devices that have the "conflicting output
> >> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> >> RGB bits move around depending on the selected output mode. For
> >> devices that do not have the "conflicting output formats" issue
> >> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> >> 
> >> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >> 
> >>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26
> >>  ++++++++++++++++++++++ 1 file changed, 26 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >> b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt index
> >> 82f2acb3d374..9de434a8f523 100644
> >> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >> 
> >> @@ -15,6 +15,14 @@ Required children nodes:
> >>   to external devices using the OF graph reprensentation (see
> >>   ../graph.txt).
> >>   At least one port node is required.
> >> 
> >> +Optional properties in grandchild nodes:
> >> + Any endpoint grandchild node may specify a desired video interface
> >> + according to ../../media/video-interfaces.txt, specifically
> >> + - bus-type: must be <0>.
> > 
> > Is there any value in specifying this, if it has a fixed value to
> > "autodetect"? I understand it's optional, so if nobody else objects,
> > feels free to keep it there.
> 
> That's just how media/video-interfaces.txt works.
> 
> bus-type 0 means that other properties describe the bus type. In this
> case bus-width is specified, so that means a parallel bus. But bus-width
> has no meaning (or may not have) if bus-type is non-zero. But checking
> that bus-type for zero in the code seemed like overkill to me since the
> driver already knows that it is a parallel bus...
> 
> TL;DR I'd like to keep it.

Sakari told me recently that he was planning to introduce explicit bus types 
for parallel buses (both external sync and BT.656). Sakari, do you want to 
comment on this ?

> >> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> >> +   override any output mode selection heuristic, forcing "rgb444",
> >> +   "rgb565", "rgb666" and "rgb888" respectively.

[snip]

-- 
Regards,

Laurent Pinchart
