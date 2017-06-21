From: jacopo@jmondi.org (jmondi)
Date: Wed, 21 Jun 2017 23:50:59 +0200
Subject: [PATCH V4 1/7] dt-bindings: pinctrl: extend the pinmux property
 to support integers array
In-Reply-To: <1498046395-30001-2-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
 <1498046395-30001-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170621215059.GA14826@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,
   thanks for this

On Wed, Jun 21, 2017 at 07:59:49PM +0800, Dong Aisheng wrote:
> Some platforms may need more than one integer to represent a complete
> pinmux binding, so let's extend the pinmux property to allow to accept
> integer array instead of only a single integer.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>
> ---
> ChangeLog:
>  * new patch
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> index f01d154..1b954b5 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> @@ -205,10 +205,11 @@ maintain.
>
>  For cases like this, the pin controller driver may use the pinmux helper
>  property, where the pin identifier is packed with mux configuration settings
> -in a single integer.
> +in a single integer or integers array which depends on platform binding
> +specific.
>

s/or integers array/or a group of integers/
since you're using "group" below

s/ which depends on platform binding specific//

I'm not a native speaker, but this sounds weird to me. If I'm the only
one, please ignore my comment otherwise please drop this

Actually, to avoid confusion between "array of integers" and "group of
integers" I would provide a definition of what a "pinmux group" is
before everything else.
This is how the paragraph would look like:

-----------------------------------------------------------------------------
 For cases like this, the pin controller driver may use the pinmux helper
 property, where the pin identifier is provided with mux configuration settings
 in a pinmux group.

 A pinumux group consists of the pin identifier and mux settings
 represented as a single integer or an array of integers.

 The pinmux property accepts an array of pinmux groups, each of them describing
 a single pin multiplexing configuration.

 pincontroller {
	state_0_node_a {
		pinmux = <PINMUX_GROUP>, <PINMUX_GROUP>, ...;
	};
 };

 Each individual pin controller driver bindings documentation shall specify
 how pin IDs and pin multiplexing configuration are defined and assembled together
 in a pinmux group.
-----------------------------------------------------------------------------

Thanks
   j

> -The pinmux property accepts an array of integers, each of them describing
> -a single pin multiplexing configuration.
> +The pinmux property accepts an array of group of integers, each group
> +describing a single pin multiplexing configuration.
>
>  pincontroller {
>  	state_0_node_a {
> @@ -300,7 +301,7 @@ arguments are described below.
>  - pinmux takes a list of pin IDs and mux settings as required argument. The
>    specific bindings for the hardware defines:
>    - How pin IDs and mux settings are defined and assembled together in a single
> -    integer.
> +    integer or integers array.
>
>  - bias-pull-up, -down and -pin-default take as optional argument on hardware
>    supporting it the pull strength in Ohm. bias-disable will disable the pull.
> --
> 2.7.4
>
