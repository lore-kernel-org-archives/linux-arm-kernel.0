From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 10 Feb 2014 11:03:55 +0100
Subject: [PATCH 01/17] Documentation: i2c: describe devicetree method for
 instantiating devices
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392026654-5343-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---

 Documentation/i2c/instantiating-devices | 34 +++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/instantiating-devices b/Documentation/i2c/instantiating-devices
index c70e7a7..6df095a 100644
--- a/Documentation/i2c/instantiating-devices
+++ b/Documentation/i2c/instantiating-devices
@@ -8,8 +8,8 @@ reason, the kernel code must instantiate I2C devices explicitly. There are
 several ways to achieve this, depending on the context and requirements.
 
 
-Method 1: Declare the I2C devices by bus number
------------------------------------------------
+Method 1a: Declare the I2C devices by bus number
+------------------------------------------------
 
 This method is appropriate when the I2C bus is a system bus as is the case
 for many embedded systems. On such systems, each I2C bus has a number
@@ -51,6 +51,36 @@ The devices will be automatically unbound and destroyed when the I2C bus
 they sit on goes away (if ever.)
 
 
+Method 1b: Declare the I2C devices via devicetree
+-------------------------------------------------
+
+This method has the same implications as method 1a. The declaration of I2C
+devices is here done via devicetree as subnodes of the master controller.
+
+Example:
+
+	i2c1: i2c at 400a0000 {
+		/* ... master properties skipped ... */
+		clock-frequency = <100000>;
+
+		flash at 50 {
+			compatible = "atmel,24c256";
+			reg = <0x50>;
+		};
+
+		pca9532: gpio at 60 {
+			compatible = "nxp,pca9532";
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0x60>;
+		};
+	};
+
+Here, two devices are attached to the bus using a speed of 100kHz. For
+additional properties which might be needed to set up the device, please refer
+to its devicetree documentation in Documentation/devicetree/bindings/.
+
+
 Method 2: Instantiate the devices explicitly
 --------------------------------------------
 
-- 
1.8.5.1
