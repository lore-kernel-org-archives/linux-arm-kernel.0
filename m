From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Tue, 29 Jul 2014 14:42:31 +0300
Subject: use IORESOURCE_REG resource type for non-translatable addresses in DT
Message-ID: <53D788A7.4020303@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While looking in MFD drivers I saw that few of them (88pm860x-core,
max8925-core and wm831x-core) allow use of IORESOURCE_REG as resource
type when calling  platform_get_resource() by their child drivers. The
resources for these child devices are filled by core MFD driver manually
and then passed to mfd_add_devices() as mfd_cells.

During development and review comments of the MFD core driver for
Qualcomm SPMI PMICs we came down to a need to describe PMIC peripheral
addresses (the PMIC sub-functions) through *reg* property in DT. The
PMIC peripheral drivers will be scattered over the /drivers and they
will call platform_get_resource() to extract their peripheral base
addresses from resource->start. The issue we have encountered is that
these addresses are non-translatable thus of_address_to_resource returns
OF_BAD_ADDR.

Stephen Boyd have made a suggestion to solve the issue here [1].

Is that approach acceptable? Or do we have better way? How similar
issues could be solved.

Our DT node for SPMI PMICs can be seen below [2].

Please do comment.

PS: I have made a little change in __of_address_to_resource() to
illustrate what I meant above.

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 5edfcb0..898741e 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -617,9 +617,24 @@ static int __of_address_to_resource(struct
device_node *dev,

        if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
                return -EINVAL;
+
        taddr = of_translate_address(dev, addrp);
-       if (taddr == OF_BAD_ADDR)
-               return -EINVAL;
+       /*
+        * if the address is non-translatable to cpu physical address
+        * fallback to a IORESOURCE_REG resource.
+        */
+       if (taddr == OF_BAD_ADDR) {
+               memset(r, 0, sizeof(*r));
+               taddr = of_read_number(addrp, 1);
+               if (taddr == OF_BAD_ADDR)
+                       return -EINVAL;
+               r->start = taddr;
+               r->end = taddr + size - 1;
+               r->flags = IORESOURCE_REG;
+               r->name = name ? name : dev->full_name;
+               return 0;
+       }
+
        memset(r, 0, sizeof(struct resource));
        if (flags & IORESOURCE_IO) {
                unsigned long port;

[1] https://lkml.org/lkml/2014/7/17/680

[2] Simplistic PMIC DT node.

spmi at fc4cf000 {
	compatible = "qcom,spmi-pmic-arb";
	reg = <0xfc4cf000 0x1000>,
	      <0xfc4cb000 0x1000>,
	      <0xfc4ca000 0x1000>;
	reg-names = "core", "intr", "cnfg";
	#address-cells = <2>;
	#size-cells = <0>;
	interrupt-controller;
	#interrupt-cells = <4>;

	pm8941 at 0 {
		compatible = "qcom,pm8941";
		reg = <0x0 SPMI_USID>;
		#size-cells = <1>;
		#address-cells = <1>;

		rtc {
			compatible = "qcom,pm8941-rtc";
			reg = <0x6000 0x100>, <0x6100 0x100>;
			reg-names = "rtc", "alarm";
			interrupts = <0x0 0x61 0x1 0>;
			interrupt-names = "alarm";
		};
	};

	pm8941 at 1 {
		compatible = "qcom,pm8941";
		reg = <0x1 SPMI_USID>;
	};
}

-- 
regards,
Stan
