From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Feb 2018 17:04:14 -0600
Subject: [PATCH v3 01/25] dt-bindings: soc: qcom: Add bindings for APR bus
In-Reply-To: <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
 <20180213231244.ama4bwsehzuh5sr7@rob-hp-laptop>
 <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
Message-ID: <20180218230414.dkd6kb6kd35arcyv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 09:13:23AM +0000, Srinivas Kandagatla wrote:
> Thanks for the review,
> 
> On 13/02/18 23:12, Rob Herring wrote:
> > On Tue, Feb 13, 2018 at 04:58:13PM +0000, srinivas.kandagatla at linaro.org wrote:
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> > > bus driver. This bus is used for communicating with DSP which provides
> > > audio and various other services to cpu.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 83 ++++++++++++++++++++++
> > >   1 file changed, 83 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> > > new file mode 100644
> > > index 000000000000..1b95fbfed348
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> > > @@ -0,0 +1,83 @@
> > > +Qualcomm APR (Asynchronous Packet Router) binding
> > > +
> > > +This binding describes the Qualcomm APR. APR is a IPC protocol for
> > > +communication between Application processor and QDSP. APR is mainly
> > > +used for audio/voice services on the QDSP.
> > > +
> > > +- compatible:
> > > +	Usage: required
> > > +	Value type: <stringlist>
> > > +	Definition: must be "qcom,apr-v<VERSION-NUMBER>", example "qcom,apr-v2"
> > > +
> > > +- qcom,apr-dest-domain-id
> > > +	Usage: required
> > > +	Value type: <prop-encoded-array>
> > > +	Definition: Destination processor ID.
> > > +	Possible values are :
> > > +			1 - APR simulator
> > > +			2 - PC
> > > +			3 - MODEM
> > > +			4 - ADSP
> > > +			5 - APPS
> > > +			6 - MODEM2
> > > +			7 - APPS2
> > > +
> > > += APR SERVICES
> > > +Each subnode of the APR node can represent service tied to this apr. The name
> > > +of the nodes are not important. The properties of these nodes are defined
> > > +by the individual bindings for the specific service
> > > +- but must contain the following property:
> > > +
> ...
> > > += APR DEVICES:
> > > +Each subnode of the APR node can represent devices tied to this apr, like
> > > +sound-card. The properties of these nodes are defined by the individual
> > > +bindings for the specific device.
> > 
> > It's not a good design generally to mix different types of nodes at one
> > level.
> 
> I agree, may be I can split the services and devices into different subnodes
> like below, which should avoid mixing different types of nodes.
> 
> Does this sound good to you?

Seems your original example wasn't so complete...

I don't see why you need all these nodes in the first place. For a 
single SoC, how much does all this vary?

> 
> apr {
>         compatible = "qcom,apr-v2";
>         qcom,smd-channels = "apr_audio_svc";
>         qcom,apr-dest-domain-id = <APR_DOMAIN_ADSP>;
> 
>         apr-services {
>                 q6core {
>                         qcom,apr-svc-name = "CORE";
>                         qcom,apr-svc-id = <APR_SVC_ADSP_CORE>;
>                         compatible = "qcom,q6core";
>                 };
> 
>                 q6afe: q6afe {
>                         compatible = "qcom,q6afe";
>                         qcom,apr-svc-name = "AFE";
>                         qcom,apr-svc-id = <APR_SVC_AFE>;
>                         #sound-dai-cells = <1>;
>                 };
> 
>                 q6asm: q6asm {
>                         compatible = "qcom,q6asm";
>                         qcom,apr-svc-name = "ASM";
>                         qcom,apr-svc-id = <APR_SVC_ASM>;
>                         #sound-dai-cells = <1>;
>                 };
> 
>                 q6adm: q6adm {
>                         compatible = "qcom,q6adm";
>                         qcom,apr-svc-name = "ADM";
>                         qcom,apr-svc-id = <APR_SVC_ADM>;
>                         #sound-dai-cells = <0>;
>                 };

All these DAI nodes could be a single node and the cell value be the 
svc-id?

>         };
> 
>         apr-devices {
>                 audio {
>                         compatible = "qcom,msm8996-snd-card";

This is a pseudo device. Why not put it at the top level like other 
sound cards?

>                         ...
>                 };
>         };
> };
> 
> 
> 
> 
> > 
> > > +
> > > += EXAMPLE
> > > +The following example represents a QDSP based sound card on a MSM8996 device
> > > +which uses apr as communication between Apps and QDSP.
> > > +
> > > +	apr {
> > > +		compatible = "qcom,apr-v2";
> > > +		qcom,smd-channels = "apr_audio_svc";
> > > +		qcom,apr-dest-domain-id = <APR_DOMAIN_ADSP>;
> > > +
> > > +		q6core {
> > > +			compatible = "qcom,q6core";
> > > +			qcom,apr-svc-name = "CORE";
> > > +			qcom,apr-svc-id = <APR_SVC_ADSP_CORE>;
> > > +		};
> > > +
> > > +		q6afe {
> > > +			compatible = "qcom,q6afe";
> > > +			qcom,apr-svc-name = "AFE";
> > > +			qcom,apr-svc-id = <APR_SVC_AFE>;
> > > +		};
> > > +
> > > +		audio {
> > > +			compatible = "qcom,msm8996-snd-card";
> > > +			...
> > > +		};
> > > +	};
> > > -- 
> > > 2.15.1
> > > 
