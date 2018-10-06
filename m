From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 6 Oct 2018 12:40:52 +0200
Subject: [PATCH 15/36] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
In-Reply-To: <20181005165848.3474-16-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-16-robh@kernel.org>
Message-ID: <c4909f78-bfa1-9253-e436-1159392b45a9@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Am 05.10.18 um 18:58 schrieb Rob Herring:
> Convert Actions Semi SoC bindings to DT schema format using json-schema.

This sounds like the next Yanny vs. Laurel... I fail to see any json. ;)

Also, it may help my understanding to be CC'ed on the cover letter, too?

> 
> Cc: "Andreas F?rber" <afaerber@suse.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
>  .../devicetree/bindings/arm/actions.yaml      | 34 +++++++++++
>  2 files changed, 34 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
> deleted file mode 100644
> index d54f33c4e0da..000000000000
> --- a/Documentation/devicetree/bindings/arm/actions.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -Actions Semi platforms device tree bindings
> --------------------------------------------
> -
> -
> -S500 SoC
> -========
> -
> -Required root node properties:
> -
> - - compatible :  must contain "actions,s500"
> -
> -
> -Modules:
> -
> -Root node property compatible must contain, depending on module:
> -
> - - LeMaker Guitar: "lemaker,guitar"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Allo.com Sparky: "allo,sparky"
> - - Cubietech CubieBoard6: "cubietech,cubieboard6"
> - - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
> -
> -
> -S700 SoC
> -========
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s700"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Cubietech CubieBoard7: "cubietech,cubieboard7"
> -
> -
> -S900 SoC
> -========
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s900"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
> new file mode 100644
> index 000000000000..af9345a228b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> @@ -0,0 +1,34 @@
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/arm/actions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

404 for the schema. Where does one find an explanation?

> +
> +title: Actions Semi platforms device tree bindings
> +
> +maintainers:
> +  - Andreas F?rber <afaerber@suse.de>

Mani is now officially reviewer and the closest I have to a
co-maintainer. I suggest we add him here in some form. I assume this is
independent of MAINTAINERS patterns though, or will get_maintainers.pl
parse this, too?

> +
> +description: |

Does the | have any meaning, or a stray typo?

> +  The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC. The Actions Semi
> +  S900 is a quad-core ARM Cortex-A53 SoC.

You forgot the S700 as another quad-core Cortex-A53 SoC.
Also, arm or Arm rather than ARM these days?

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - lemaker,guitar-bb-rev-b
> +          - enum:
> +              - lemaker,guitar
> +              - allo,sparky
> +              - cubietech,cubieboard6
> +          - const: actions,s500
> +        minItems: 2
> +        maxItems: 3
> +        additionalItems: false

Objection. You've managed to turn a perfectly human-comprehensible text
into a machine-parseable representation incomprehensible for humans.

First, there should remain some free-text explanation of the values
defined here. Are comments allowed after the value or indented maybe?
Alternatively we could have a per-vendor file ? la vendor-prefixes.txt,
but that would seem inefficient.

Next, the above items construct is horrible. What about nested oneOf:

+      - items:
+          - oneOf:
+              - items:
+                  - enum:
+                      - lemaker,guitar-bb-rev-b
+                  - const: lemaker,guitar
+              - items:
+                  - enum:
+                      - allo,sparky
+                      - cubietech,cubieboard6
+          - const: actions,s500

This grouping is much clearer to me and hopefully to anyone adding
further base boards for the module.
We will have the same issue for the BPi-S64 module with S700 below.

> +      - items:
> +          - const: cubietech,cubieboard7
> +          - const: actions,s700
> +      - items:
> +          - const: ucrobotics,bubblegum-96
> +          - const: actions,s900

Please make the board compatible an enum, even if only one is listed
today. That makes it clearer where/how (and easier) to add new boards.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
