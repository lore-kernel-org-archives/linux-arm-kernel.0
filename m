From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 08:48:41 -0500
Subject: [PATCH v2 1/9] dt-bindings: display: sun4i: Add component
 endpoint ID numbering scheme
In-Reply-To: <20170421083857.29636-2-wens@csie.org>
References: <20170421083857.29636-1-wens@csie.org>
 <20170421083857.29636-2-wens@csie.org>
Message-ID: <20170428134841.cc5jrqhunh2rxhog@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 04:38:49PM +0800, Chen-Yu Tsai wrote:
> The Allwinner display pipeline contains many hardware components, some
> of which can consume data from one of multiple upstream components.
> The numbering scheme of these components must be encoded into the device
> tree so the driver can figure out which component out of two or more of
> the same type it is supposed to use or program.
> 
> This patch adds the constraint that local endpoint IDs must be the index
> or number of the remote endpoint's hardware block, for all components
> in the display pipeline up to the TCONs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 57a8d0610062..7acdbf14ae1c 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -4,6 +4,16 @@ Allwinner A10 Display Pipeline
>  The Allwinner A10 Display pipeline is composed of several components
>  that are going to be documented below:
>  
> +For the input port of all components up to the TCON in the display
> +pipeline, if there are multiple components, the local endpoint IDs
> +must correspond to the index of the upstream block. For example, if
> +the remote endpoint is Frontend 1, then the local endpoint ID must
> +be 1.
> +
> +Conversely, for the output ports of the same group, the remote endpoint
> +ID must be the index of the local hardware block. If the local backend
> +is backend 1, then the remote endpoint ID must be 1.

It would be clearer if you just explicitly listed IDs and their 
connections. From how this is worded, it would not work if you had 
connections like this:

DevA 0
DevA 1
DevB 0
DevB 1

These would need to be endpoints 0-3 in TCON, and that doesn't reflect 
the remote devices' index.

Rob
