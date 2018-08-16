From: jacopo@jmondi.org (jacopo mondi)
Date: Thu, 16 Aug 2018 21:46:51 +0200
Subject: [RESEND PATCH v5 2/3] dt-bindings: display: atmel: optional
 video-interface of endpoints
In-Reply-To: <061a99d5-4fe6-795c-7e91-cf7127fb8472@axentia.se>
References: <20180803072308.14962-1-peda@axentia.se>
 <20180803072308.14962-3-peda@axentia.se>
 <20180803081128.GA4528@w540>
 <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
 <20180803085143.GC4528@w540>
 <061a99d5-4fe6-795c-7e91-cf7127fb8472@axentia.se>
Message-ID: <20180816194651.GA30122@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thu, Aug 16, 2018 at 02:52:41PM +0200, Peter Rosin wrote:
> On 2018-08-03 10:51, jacopo mondi wrote:
> > On Fri, Aug 03, 2018 at 10:40:02AM +0200, Peter Rosin wrote:
> >> On 2018-08-03 10:11, jacopo mondi wrote:
> >>> Hi Peter!
> >>>
> >>> On Fri, Aug 03, 2018 at 09:23:07AM +0200, Peter Rosin wrote:
> >>>> With bus-type/bus-width properties in the endpoint nodes, the video-
> >>>> interface of the connection can be specified for cases where the
> >>>> heuristic fails to select the correct output mode. This can happen
> >>>> e.g. if not all RGB pins are routed on the PCB; the driver has no
> >>>> way of knowing this, and needs to be told explicitly.
> >>>>
> >>>> This is critical for the devices that have the "conflicting output
> >>>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> >>>> RGB bits move around depending on the selected output mode. For
> >>>> devices that do not have the "conflicting output formats" issue
> >>>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> >>>>
> >>>> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >>>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>>> ---
> >>>>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++++++++++++++++
> >>>>  1 file changed, 26 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >>>> index 82f2acb3d374..9de434a8f523 100644
> >>>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >>>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >>>> @@ -15,6 +15,14 @@ Required children nodes:
> >>>>   to external devices using the OF graph reprensentation (see ../graph.txt).
> >>>>   At least one port node is required.
> >>>>
> >>>> +Optional properties in grandchild nodes:
> >>>> + Any endpoint grandchild node may specify a desired video interface
> >>>> + according to ../../media/video-interfaces.txt, specifically
> >>>> + - bus-type: must be <0>.
> >>>
> >>> Is there any value in specifying this, if it has a fixed value to
> >>> "autodetect"? I understand it's optional, so if nobody else objects,
> >>> feels free to keep it there.
> >>
> >> That's just how media/video-interfaces.txt works.
> >>
> >> bus-type 0 means that other properties describe the bus type. In this
> >> case bus-width is specified, so that means a parallel bus. But bus-width
> >> has no meaning (or may not have) if bus-type is non-zero. But checking
> >> that bus-type for zero in the code seemed like overkill to me since the
> >> driver already knows that it is a parallel bus...
> >>
> >
> > Yeah, I felt like pointing that out since you're not cheking for its value,
> > and that property is only used by v4l2-fwnode to handle some
> > not-that-used-anymore bus as CCP2 is.
> >
> >> TL;DR I'd like to keep it.
> >>
> >
> > Fine with me then.
> >
> >>>
> >>>> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> >>>> +   override any output mode selection heuristic, forcing "rgb444",
> >>>> +   "rgb565", "rgb666" and "rgb888" respectively.
> >>>> +
> >>>>  Example:
> >>>>
> >>>>  	hlcdc: hlcdc at f0030000 {
> >>>> @@ -50,3 +58,21 @@ Example:
> >>>>  			#pwm-cells = <3>;
> >>>>  		};
> >>>>  	};
> >>>> +
> >>>
> >>> Two blank lines here.
> >>>
> >>>> +
> >>>> +Example 2: With a video interface override to force rgb565; as above
> >>>> +but with these changes/additions:
> >>>> +
> >>>> +	&hlcdc {
> >>>> +		hlcdc-display-controller {
> >>>> +			pinctrl-names = "default";
> >>>> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> >>>> +
> >>>> +			port at 0 {
> >>>
> >>> The node has a unit address specified, you're missing a reg = <0>
> >>> property (no big deal, it's an example, but the other one has it)
> >>>
> >>>> +				hlcdc_panel_output: endpoint at 0 {
> >>>
> >>> Missing reg here too.
> >>
> >> I'll fix those (I think they appeared for the original example after I
> >> wrote the patch).
> >>
> >
> > Ok, then please consider also describing the port at 0 node cell sizes too
> > since it has a child endpoint node.
>
> Ok, I have now figured out why this was as it were, and I no longer agree
> with adding the extra properties. The whole of example 2 is inside a
> reference (using the &hlcdc notation) to the hlcdc node in example 1, and
> therefore these "missing" properties are not missing. I think they are
> just clutter that hides what is really needed/different between example 1
> and 2, and apparently Boris and Rob agreed when they acked/reviewed. The
> description of example 2 also clearly states that example 2 is changes
> and additions on top of example 1. So, I plan to have this in the next
> iteration:
>
> 	&hlcdc {
> 		hlcdc-display-controller {
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
>
> 			port at 0 {
> 				hlcdc_panel_output: endpoint at 0 {
> 					bus-width = <16>;

Right, I thought that even when re-defining a node, reg properties
should be there, but yes, I had no reasons to think so :)

> 				};
> 			};
> 		};
> 	};
>
> Jacopo, please let me know if you want me to keep your review tag anyway...
>

Sure

>
> >> Cheers,
> >> Peter
> >>
> >>> Minors apart:
>
> ...because I interpret this to mean that I could add your tag if I made the
> changes you suggested. Or did it mean that I could add your tag regardless
> because the issues were minor?
>v

Sorry, I was not clear. That was a minor nit, you could have add my
tag anyhow.

Thanks
   j

> Cheers,
> Peter
>
> >>>
> >>> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>>
>  >>> Thanks
> >>>    j
> >>>
> >>>> +					bus-type = <0>;
> >>>> +					bus-width = <16>;
> >>>> +				};
> >>>> +			};
> >>>> +		};
> >>>> +	};
> >>>> --
> >>>> 2.11.0
> >>>>
> >>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180816/3bf52c6a/attachment.sig>
