From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Jul 2018 11:24:59 -0600
Subject: [PATCH v2 09/10] coresight: Cleanup coresight DT bindings
In-Reply-To: <e96b9bda-8a58-a817-5580-7771af7c9e28@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
 <1531997715-6767-10-git-send-email-suzuki.poulose@arm.com>
 <20180725160939.GA24323@rob-hp-laptop>
 <e96b9bda-8a58-a817-5580-7771af7c9e28@arm.com>
Message-ID: <CAL_JsqKhiA=Yr3gWhxaQxT56NUai77Lg5iVfQUaTtBW=a5-kFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 10:13 AM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> On 07/25/2018 05:09 PM, Rob Herring wrote:
> > On Thu, Jul 19, 2018 at 11:55:13AM +0100, Suzuki K Poulose wrote:
> >> The coresight drivers relied on default bindings for graph
> >> in DT, while reusing the "reg" field of the "ports" to indicate
> >> the actual hardware port number for the connections. This can
> >> cause duplicate ports with same addresses, but different
> >> direction. However, with the rules getting stricter w.r.t to the
> >> address mismatch with the label, it is no longer possible to use
> >> the port address field for the hardware port number.
> >>
> >> This patch introduces new DT binding rules for coresight
> >> components, based on the same generic DT graph bindings, but
> >> avoiding the address duplication.
> >>
> >> - All output ports must be specified under a child node with
> >>    name "out-ports".
> >> - All input ports must be specified under a childe node with
> >>    name "in-ports".
> >> - Port address should match the hardware port number.
> >>
> >> The support for legacy bindings is retained, with a warning.
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>   .../devicetree/bindings/arm/coresight.txt          | 91 ++++++++++----------
> >>   drivers/hwtracing/coresight/of_coresight.c         | 97 +++++++++++++++++++---
> >>   2 files changed, 129 insertions(+), 59 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> >> index 8e21512..f39d2c6 100644
> >> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> >> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> >> @@ -104,19 +104,9 @@ The connections must be described via generic DT graph bindings as described
> >>   by the "bindings/graph.txt", where each "port" along with an "endpoint"
> >>   component represents a hardware port and the connection.
> >>
> >> -Since it is possible to have multiple connections for any coresight component
> >> -with a specific direction of data flow, each connection must define the
> >> -following properties to uniquely identify the connection details.
> >> -
> >> - * Direction of the data flow w.r.t the component :
> >> -   Each input port must have the following property defined at the "endpoint"
> >> -   for the port.
> >> -    "slave-mode"
> >> -
> >> - * Hardware Port number at the component:
> >> -     -  The hardware port number is assumed to be the address of the "port"
> >> -         component.
> >> -
> >
> > Why do you add this in the previous patch and then remove it here?
>
> The only use case I can think of it is for someone to look back on the
> legacy bindings, which were never documented. I could skip the parts
> that are being removed.

Yeah, I'd just remove it. Finding the text that exists for 1 commit is
a little hard. Now that we've discussed it here, googling for it will
be easier.

Rob
