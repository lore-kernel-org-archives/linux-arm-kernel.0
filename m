From: robh@kernel.org (Rob Herring)
Date: Mon, 15 Oct 2018 09:34:20 -0500
Subject: [PATCH 6/9]  PM / OPP: dt-bindings: Add opp-interconnect-bw
In-Reply-To: <20180827151112.25211-7-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-7-jcrouse@codeaurora.org>
Message-ID: <20181015143420.GA16932@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 09:11:09AM -0600, Jordan Crouse wrote:
> Add the "opp-interconnect-bw" property to specify the
> average and peak bandwidth for an interconnect path for
> a specific operating power point. A separate bandwidth
> pair can be specified for each of the interconnects
> defined for the device by appending the interconnect
> name to the property.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index c396c4c0af92..d714c084f36d 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -170,6 +170,11 @@ Optional properties:
>    functioning of the current device at the current OPP (where this property is
>    present).
>  
> +- opp-interconnect-bw-<name>: This is an array of pairs specifying the average
> +  and peak bandwidth in bytes per second for the interconnect path known by
> +  'name'.  This should match the name(s) specified by interconnect-names in the
> +  device definition.
> +

I don't think this is good design with the name defined in one node and 
then used in the OPP table. First, '*-names' is typically the a name 
local to that node/device. If you had 2 instances of a device with a 
shared OPP table for the 2 instances, then you are going to have to 
make the names unique. Second, how exactly would having multiple b/w 
entries work? A given OPP frequency supports the sum of the b/w entries? 
What if some devices for b/w entries aren't currently active?

This also seems like a mixture of using OPP table for setting GPU's 
bandwidth/freq and then the interconnect binding to set the 
interconnect's bandwidth. Perhaps we need a more unified approach. Not 
sure what that would look like though.

Rob
