From: agross@codeaurora.org (Andy Gross)
Date: Wed, 26 Aug 2015 13:14:10 -0500
Subject: [PATCH] soc: qcom: smd: Use correct remote processor ID
In-Reply-To: <20150826034622.GH13472@usrtlx11787.corpusers.net>
References: <1440534995-12899-1-git-send-email-agross@codeaurora.org>
 <20150826034622.GH13472@usrtlx11787.corpusers.net>
Message-ID: <20150826181410.GC13139@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 08:46:22PM -0700, Bjorn Andersson wrote:
> On Tue 25 Aug 13:36 PDT 2015, Andy Gross wrote:
> 
> > This patch fixes SMEM addressing issues when remote processors need to use
> > secure SMEM partitions.
> > 
> 
> Right, sorry for missing that remote_pid and edge_pid isn't in sync...
> 
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > ---
> >  .../devicetree/bindings/soc/qcom/qcom,smd.txt      |    7 +++++++
> >  drivers/soc/qcom/smd.c                             |   18 ++++++++++++++----
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
> > index f65c76d..3b60702 100644
> > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
> > @@ -37,6 +37,12 @@ The edge is described by the following properties:
> >  	Definition: the identifier of the remote processor in the smd channel
> >  		    allocation table
> >  
> > +- qcom,remote-pid:
> > +	Usage: required
> 
> I would like to see this being optional, as this is not a property that
> matters on any of the 32-bit systems (perhaps 8084?).

I thought about that myself, and yeah I have to agree.

> 
> > +	Value type: <u32>
> > +	Definition: the identifier for the remote processor as known by the rest
> > +		    of the system.
> > +
> >  = SMD DEVICES
> >  
> >  In turn, subnodes of the "edges" represent devices tied to SMD channels on that
> > @@ -68,6 +74,7 @@ The following example represents a smd node, with one edge representing the
> >  			interrupts = <0 168 1>;
> >  			qcom,ipc = <&apcs 8 0>;
> >  			qcom,smd-edge = <15>;
> > +			qcom,remote-pid = <0xffffffff>;
> 
> This looks messy, so let's make the property optional and make its
> absence indicate the "global partition".
> 
> >  
> >  			rpm_requests {
> >  				compatible = "qcom,rpm-msm8974";
> > diff --git a/drivers/soc/qcom/smd.c b/drivers/soc/qcom/smd.c
> [..]
> > @@ -1184,6 +1187,13 @@ static int qcom_smd_parse_edge(struct device *dev,
> >  		return -EINVAL;
> >  	}
> >  
> > +	key = "qcom,remote-pid";
> > +	ret = of_property_read_u32(node, key, &edge->remote_pid);
> > +	if (ret) {
> > +		dev_err(dev, "edge missing %s property\n", key);
> > +		return -EINVAL;
> > +	}
> > +
> 
> So I suggest you changing this to:
> 
> edge->remote_pid = QCOM_SMEM_HOST_ANY;
> of_property_read_u32(node, "qcom,remote-pid", &edge->remote_pid);

Agreed.

> 
> >  	syscon_np = of_parse_phandle(node, "qcom,ipc", 0);
> >  	if (!syscon_np) {
> >  		dev_err(dev, "no qcom,ipc node\n");
> 
> Regards,
> Bjorn

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
