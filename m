From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 20:50:44 -0600
Subject: [RFC PATCH 1/3] Enable BCM2835 mailbox support
In-Reply-To: <5232F7B7.4070206@yahoo.com.au>
References: <5232F7B7.4070206@yahoo.com.au>
Message-ID: <524B8A04.1020006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 05:32 AM, Craig McGeachie wrote:
> Cherry-picked selection of commits by Lubomir Rintel [1], Suman Anna and
> Jassi Brar [2] on which to base the implementation.
> 
> Signed-off-by: Suman Ana <s-anna@ti.com>
> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
> [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html

This needs a proper patch description. It should describe what the
mailbox HW is, what services it provides, etc.

There shouldn't be any text after the tag paragraph (i.e. the s-o-b
lines) and the --- separator.

Are you able to generate patches using "git format-patch". That would
included diffstat in the patch summary, which can be useful.

I'd prefer to see patch 1 and 2 squashed together, since the new mailbox
driver should just be implemented in one shot, rather than added with
one implementation, then reworked to be different in a separate patch.

That said, the patches need to be split up based on subsystem divisions.
The squashed patch 1 and 2, and the separate patch 3, should be split into:

a) A patch that adds the driver. This would touch just
drivers/mailbox/... (or drivers/thermal/...) and
Documentation/devicetree/bindings/...

b) A patch that adds the necessary entries to *.dts/*.dtsi

c) A patch that enables any new entries in bcm2835_defconfig.

In my initial round of review, I'll only discuss the DT bindings, and
only in response to patch 2 where they're complete rather than here.
Once the bindings are finalized and the driver adjusted to implement the
final bindings, then I'll look at the driver code.

Note that all new DT bindings should be CC'd to the DT bindings
maintainers; see the following in MAINTAINERS:

OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
M:      Rob Herring <rob.herring@calxeda.com>
M:      Pawel Moll <pawel.moll@arm.com>
M:      Mark Rutland <mark.rutland@arm.com>
M:      Stephen Warren <swarren@wwwdotorg.org>
M:      Ian Campbell <ijc+devicetree@hellion.org.uk>
L:      devicetree at vger.kernel.org
S:      Maintained
F:      Documentation/devicetree/
F:      arch/*/boot/dts/
F:      include/dt-bindings/

> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> index 1e12aef..4fc8a68 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -29,6 +29,12 @@
>  			#interrupt-cells = <2>;
>  		};

There needs to be a blank line here.

>  +		mailbox {

Patch corruption? + is indented!
