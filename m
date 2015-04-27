From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 27 Apr 2015 17:00:11 +0200
Subject: [PATCH] ARM: gic: Document Power and Clock Domain optional properties
Message-ID: <1430146811-29862-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some SoCs, the GIC may be part of a PM Domain (hardware Power and/or
Clock Domain).  Document the related optional DT properties.

Note: As the current GIC driver doesn't support Runtime PM yet, PM
Domain constraints must be handled elsewhere in e.g. platform code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To preserve DT stability, we would like to add these properties to the
affected shmobile dtsi files.

On Thu, Mar 26, 2015 at 11:39 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 25/03/15 21:19, Geert Uytterhoeven wrote:
>> I would like to add the clock and GIC dependency on the clock in the DTS now,
>> for reasons of DTS stability. But that means I need a temporary workaround
>> to avoid the clock from being disabled, until the GIC driver handles this.
>>
>> I don't expect a fix for the GIC code to just show up magically. I just wanted
>> you to be aware of the problem. GIC is not the only problematic module here,
>> there are others, cfr. the last slide of [2].
>
> As long as there is an agreement from the DT people on the presence of
> that extra property in the GIC node, I'm happy with that. I'd like it to
> be documented though.

Full thread at
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331876.html

 Documentation/devicetree/bindings/arm/gic.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 2da059a4790cb3c6..b21113b35f085f27 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -58,6 +58,14 @@ Optional
   regions, used when the GIC doesn't have banked registers. The offset is
   cpu-offset * cpu-nr.
 
+- power-domains : A phandle and PM domain specifier as defined by bindings of
+		  the power controller specified by phandle, used when the GIC
+		  is part of a Power or Clock Domain.
+
+- clocks        : A phandle and clock specifier as defined by bindings of
+		  the clock controller specified by phandle, used when the GIC
+		  is part of a Clock Domain.
+
 Example:
 
 	intc: interrupt-controller at fff11000 {
-- 
1.9.1
