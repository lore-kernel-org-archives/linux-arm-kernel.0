From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 24 Apr 2017 18:53:10 +0200 (CEST)
Subject: [PATCH 1/5 v3] usb: host: add DT bindings for faraday fotg2
In-Reply-To: <20170421204058.6206-1-linus.walleij@linaro.org>
References: <20170421204058.6206-1-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1704241846300.15211@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Fri, 21 Apr 2017, Linus Walleij wrote:

> From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> 
> This adds device tree bindings for the Faraday FOTG2
> dual-mode host controller.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v3:
> - Change compatible to "faraday,fotg210" as the name of the
>   hardware block.
> - Add an elaborate SoC-specific compatible string for the
>   Cortina Systems Gemini so that SoC-specific features can
>   be enabled.
> - Add cortina,gemini-mini-b to indicate a Gemini PHY with
>   a Mini-B adapter connected.
> - Indicated that the Gemini version can handle "wakeup-source".
> - Add optional IP block clock.
> ---
>  .../devicetree/bindings/usb/faraday,fotg210.txt    | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/faraday,fotg210.txt
> 

Got NAK'ed from Rob on some ealier round due missing "device mode" on this 
IP. I've blatantly overrided this to a host only driver.

These are the needed changes in DT to support both modes
Note the -dr at the end of fotg210, to reflect this in an dual role device

diff --git a/Documentation/devicetree/bindings/usb/faraday,fotg210.txt 
b/Documentation/devicetree/bindings/usb/faraday,fotg210.txt
index cf06808303e2..862cda19e9d3 100644
--- a/Documentation/devicetree/bindings/usb/faraday,fotg210.txt
+++ b/Documentation/devicetree/bindings/usb/faraday,fotg210.txt
@@ -13,6 +13,9 @@ Required properties:
 Optional properties:
 - clocks: should contain the IP block clock
 - clock-names: should be "PCLK" for the IP block clock
+- dr_mode : indicates the working mode for "fotg210-dr" compatible
+   controllers.  Can be "host", "peripheral". Default to
+   "host" if not defined for backward compatibility.
 
 Required properties for "cortina,gemini-usb" compatible:
 - syscon: a phandle to the system controller to access PHY registers
@@ -25,7 +28,7 @@ Optional properties for "cortina,gemini-usb" compatible:
 Example for Gemini:
 
 usb at 68000000 {
-       compatible = "cortina,gemini-usb", "faraday,fotg210";
+       compatible = "cortina,gemini-usb", "faraday,fotg210-dr";
        reg = <0x68000000 0x1000>;
        interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
        clocks = <&cc 12>;
