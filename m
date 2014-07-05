From: robdclark@gmail.com (Rob Clark)
Date: Sat, 5 Jul 2014 08:21:02 -0400
Subject: [PATCH RFC] drm: add of_graph endpoint helper to find possible
 CRTCs
In-Reply-To: <20140703224117.GA21766@n2100.arm.linux.org.uk>
References: <E1X2kC1-0000sH-C6@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs-p0dXfaSXvy67X8LbSmKF7gT8zubaJx4LSRh_-aKNZQ@mail.gmail.com>
 <20140703224117.GA21766@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGs-MMLYN+X7UJgThVOW20Gxb-bUojtbAsvM=Bn+wEJasw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 3, 2014 at 6:41 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 03, 2014 at 06:17:24PM -0400, Rob Clark wrote:
>> On Thu, Jul 3, 2014 at 12:49 PM, Russell King
>> <rmk+kernel@arm.linux.org.uk> wrote:
>> > Add a helper to allow encoders to find their possible CRTCs from the
>> > OF graph without having to re-implement this functionality.  We add a
>> > device_node to drm_crtc which corresponds with the port node in the
>> > DT description of the CRTC device.
>> >
>> > We can then scan the DRM device list for CRTCs to find their index,
>> > matching the appropriate CRTC using the port device_node, thus building
>> > up the possible CRTC mask.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > ---
>> > This helper will be shared between imx-drm and Armada DRM, and should
>> > be useful for other OF-based drivers.  At the moment, this is being
>> > sent for comments and acks; I need to build upon this patch in order
>> > to convert Armada DRM to DT.
>>
>> ok, possibly a dumb question, but in my defense I don't claim to be a
>> DT expert ;-)
>>
>> Do you have somewhere handy a example dts which this would be parsing?
>>  I think that would help me understand this patch a bit better.
>
> The patch is merely moving something that's already being used by
> imx-drm into a more convenient location.
>
> The documentation for the "binding" (it isn't really parsing a binding,
> merely traversing the graph itself) is:
>
> Documentation/devicetree/bindings/graph.txt

ahh, thanks.. this makes more sense.  Might be worth putting something
along the lines of "see Documentation/devicetree/bindings/graph.txt"
for the drm_of_find_possible_crtcs() comment block.

BR,
-R

> which is shared from the v4l2 code.
>
> To give an example, this is an extract from the imx6qdl dtsi file.  I've
> cut out a load of stuff which isn't that relevant to the overall
> structure.  The full stuff is arch/arm/boots/dts/imx6qdl.dtsi.
>
> IPU contains two display interfaces (DIs, aka CRTCs).  Each display
> interface is connected to a set of muxes, one mux per display bridge
> (encoder/connector) which can select between DI0 or DI1.  Some chips
> have two IPUs, hence four DIs, making it possible to drive the four
> display bridges entirely independently.
>
>                 ipu1: ipu at 02400000 {
>                         ipu1_di0: port at 2 {
>                                 ipu1_di0_hdmi: endpoint at 1 {
>                                         remote-endpoint = <&hdmi_mux_0>;
>                                 };
> ...
>                                 ipu1_di0_lvds1: endpoint at 4 {
>                                         remote-endpoint = <&lvds1_mux_0>;
>                                 };
>                         };
>
>                         ipu1_di1: port at 3 {
>                                 ipu1_di0_disp1: endpoint at 0 {
>                                 };
>
>                                 ipu1_di1_hdmi: endpoint at 1 {
>                                         remote-endpoint = <&hdmi_mux_1>;
>                                 };
> ...
>                                 ipu1_di1_lvds1: endpoint at 4 {
>                                         remote-endpoint = <&lvds1_mux_1>;
>                                 };
>                         };
>                 };
>
> HDMI transmitter component:
>
>                         hdmi: hdmi at 0120000 {
>                                 port at 0 {
>                                         reg = <0>;
>
>                                         hdmi_mux_0: endpoint {
>                                                 remote-endpoint = <&ipu1_di0_hdmi>;
>                                         };
>                                 };
>
>                                 port at 1 {
>                                         reg = <1>;
>
>                                         hdmi_mux_1: endpoint {
>                                                 remote-endpoint = <&ipu1_di1_hdmi>;
>                                         };
>                                 };
>                         };
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
