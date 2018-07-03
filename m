From: houlong.wei@mediatek.com (houlong wei)
Date: Wed, 4 Jul 2018 07:39:18 +0800
Subject: [PATCH v22 1/4] dt-bindings: soc: Add documentation for the
 MediaTek GCE unit
In-Reply-To: <20180703023040.GA24508@rob-hp-laptop>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
 <1530098172-31385-2-git-send-email-houlong.wei@mediatek.com>
 <20180703023040.GA24508@rob-hp-laptop>
Message-ID: <1530661158.21991.45.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-03 at 10:30 +0800, Rob Herring wrote:
> On Wed, Jun 27, 2018 at 07:16:09PM +0800, Houlong Wei wrote:
> > This adds documentation for the MediaTek Global Command Engine (GCE) unit
> > found in MT8173 SoCs.
> > 
> > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > ---
> > Hi Rob,
> >   I don't add your ACK in this version since the dt-binding description
> > has been changed. Thanks.
> > ---
> >  .../devicetree/bindings/mailbox/mtk-gce.txt        |   65 ++++++++++++++++++++
> >  include/dt-bindings/gce/mt8173-gce.h               |   48 +++++++++++++++
> >  2 files changed, 113 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> >  create mode 100644 include/dt-bindings/gce/mt8173-gce.h
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > new file mode 100644
> > index 0000000..26f65a4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > @@ -0,0 +1,65 @@
> > +MediaTek GCE
> > +===============
> > +
> > +The Global Command Engine (GCE) is used to help read/write registers with
> > +critical time limitation, such as updating display configuration during the
> > +vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
> > +
> > +CMDQ driver uses mailbox framework for communication. Please refer to
> > +mailbox.txt for generic information about mailbox device-tree bindings.
> > +
> > +Required properties:
> > +- compatible: Must be "mediatek,mt8173-gce"
> > +- reg: Address range of the GCE unit
> > +- interrupts: The interrupt signal from the GCE block
> > +- clock: Clocks according to the common clock binding
> > +- clock-names: Must be "gce" to stand for GCE clock
> > +- thread-num: Maximum threads count of GCE.
> 
> mediatek,thread-num
> 
> Is this needed for anything other than error checking the thread id in 
> the mbox cells? if that's it, then drop it. 
> 

'thread-num' is used to configure the GCE thread number, which is the
channel number of gce mailbox. This property is read in
cmdq_probe()/mtk-cmdq-mailbox.c and a mailbox's channel array is
allocated according to the number.
Since the thread number may be different on different SoC, we wish it
could be configured in device tree.

> > +- #mbox-cells: Should be 4.
> > +	<&phandle channel timeout priority atomic_exec>
> > +	phandle: Label name of a gce node.
> > +	channel: Channel of mailbox. Be equal to the thread id of GCE.
> > +	timeout: Maximum time of software waiting GCE processing done, in unit
> > +		of millisecond.
> > +	priority: Priority of GCE thread.
> > +	atomic_exec: GCE processing continuous packets of commands in atomic
> > +		way.
> > +
> > +Required properties for a client device:
> > +- mboxes: Client use mailbox to communicate with GCE, it should have this
> > +  property and list of phandle, mailbox specifiers.
> > +- gce-subsys: Specify the sub-system id which is corresponding to the register
> > +  address.
> 
> What is this for?

You mean the new added property 'gce-subsys'?  
It is used for GCE to distinguish the high 16-bit of a hardware register
address. When a client driver packets a register setting into a GCE
instruction, it uses a sub-system code and register offset instead of
the 32-bit register address.
Since sub-system code may be different on different SoC, we wish it
could be configured in device tree.

> 
> > +
> > +Optional properties for a client device:
> > +- gce-event: Specify the event if the client has any. Because the event is
> > +  parsed by client, so client can replace 'gce-event' with other meaningful
> > +  name.
> 
> If the client sets the name, then no point having here. It must be 
> documented in the client binding. But then, what is this for in the 
> first place?

Since display driver will use GCE firstly, so we will move the
description to
'Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt'
when display driver start using the GCE driver.
Is that ok?

> 
> > +
> > +Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'. Such as
> > +thread number, sub-system ids, thread priority, event ids.
> > +
> > +Example:
> > +
> > +	gce: gce at 10212000 {
> 
> mailbox at ...

Will do.

> 
> > +		compatible = "mediatek,mt8173-gce";
> > +		reg = <0 0x10212000 0 0x1000>;
> > +		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&infracfg CLK_INFRA_GCE>;
> > +		clock-names = "gce";
> > +		thread-num = CMDQ_THR_MAX_COUNT;
> > +		#mbox-cells = <4>;
> > +	};
> > +
> > +Example for a client device:
> > +
> > +	mmsys: clock-controller at 14000000 {
> > +		compatible = "mediatek,mt8173-mmsys";
> > +		mboxes = <&gce 0 2000 CMDQ_THR_PRIO_LOWEST 1>,
> > +			 <&gce 1 2000 CMDQ_THR_PRIO_LOWEST 1>;
> > +		gce-subsys = <SUBSYS_1400XXXX>;
> > +		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> > +				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> > +
> > +		...
> > +	};
