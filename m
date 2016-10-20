From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Oct 2016 15:59:49 +0530
Subject: [PATCH 2/2] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <bb7bac91-8eb1-fe23-ca9c-857e0fda6ecd@ti.com>
References: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
 <65fde145-0820-794d-d345-621f66cdacc0@ti.com>
 <7a2ffcd0-fe1d-c887-53b7-7cb5e1e61222@ti.com> <4975084.EGQPv58AK6@avalon>
 <daf49046-ad0a-d9e2-d744-1e06085c6585@ti.com>
 <CAMpxmJXT8hcSc0-svbwAq5r_JOFsYV852gtE0vuXL8hHykXnRQ@mail.gmail.com>
 <6c6fcceb-c6f2-219d-492a-a8b38fd83093@ti.com>
 <bb7bac91-8eb1-fe23-ca9c-857e0fda6ecd@ti.com>
Message-ID: <5b76ed89-cb1a-8ab2-bfbd-0a7bcf80de33@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 October 2016 03:51 PM, Tomi Valkeinen wrote:
> On 20/10/16 13:07, Sekhar Nori wrote:
> 
>> Per me, compatible property is an ordered list precisely for the reason
>> that things should continue to "work" with as closely matched driver as
>> possible. So even if someone is running a kernel which does not
>> recognize "ti,da850-tilcdc", it should still be able to probe the driver
>> based on "ti,am33xx-tilcdc" and provide as close to full functionality
>> as possible.
>>
>> That said, I will not insist on keeping it around if Tomi is
>> uncomfortable. And having read the binding documentation accepted by
>> Jyri, it actually says the compatible property should be __one of__
>> "ti,am33xx-tilcdc" or "ti,da850-tilcdc".
> 
> Well, they are just not compatible as far as I know. If the LCDC on
> DA850 would be identified as AM335x LCDC, and used as such, it would not
> work at all. They have different registers, AM335x LCDC has registers
> that do not exist on DA850.
> 
> With our driver it happens to work, because the driver looks at the IP
> revision in the registers, and then decides that this IP is not AM335x
> LCDC even if the dts says so. But I see that as a driver "feature",
> nothing that the .dts can depend on.
> 
> Perhaps it might work the other way around, using DA850 driver on
> AM335x, as DA850 LCDC is a kind of subset of AM335x LCDC. But I'm not
> sure even about that.

Alright, thanks for the detailed explanation. I dropped the "ti,am33xx-
tilcdc" from the list and here is the updated patch I am queuing for
reference.

Thanks,
Sekhar

--8<--
Author:     Karl Beldan <kbeldan@baylibre.com>
AuthorDate: Wed Oct 5 15:05:32 2016 +0200
Commit:     Sekhar Nori <nsekhar@ti.com>
CommitDate: Thu Oct 20 15:57:21 2016 +0530

    ARM: dts: da850: add a node for the LCD controller
    
    Add pins used by the LCD controller and a disabled LCDC node to be
    reused in device trees including da850.dtsi.
    
    Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
    [Bartosz:
      - added the commit description
      - changed the dt node name to a generic one
      - added a da850-specific compatible string
      - removed the tilcdc,panel node
      - moved the pins definitions to da850.dtsi as suggested by
        Sekhar Nori (was in: da850-lcdk.dts)]
    Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
    [nsekhar at ti.com: fix compatible property and remove interrupt-parent]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index f79e1b91c680..901d5c98d5f0 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -186,6 +186,27 @@
 					0xc 0x88888888 0xffffffff
 				>;
 			};
+			lcd_pins: pinmux_lcd_pins {
+				pinctrl-single,bits = <
+					/*
+					 * LCD_D[2], LCD_D[3], LCD_D[4], LCD_D[5],
+					 * LCD_D[6], LCD_D[7]
+					 */
+					0x40 0x22222200 0xffffff00
+					/*
+					 * LCD_D[10], LCD_D[11], LCD_D[12], LCD_D[13],
+					 * LCD_D[14], LCD_D[15], LCD_D[0], LCD_D[1]
+					 */
+					0x44 0x22222222 0xffffffff
+					/* LCD_D[8], LCD_D[9] */
+					0x48 0x00000022 0x000000ff
+
+					/* LCD_PCLK */
+					0x48 0x02000000 0x0f000000
+					/* LCD_AC_ENB_CS, LCD_VSYNC, LCD_HSYNC */
+					0x4c 0x02000022 0x0f0000ff
+				>;
+			};
 
 		};
 		edma0: edma at 0 {
@@ -399,6 +420,13 @@
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
 		};
+
+		display: display at 213000 {
+			compatible = "ti,da850-tilcdc";
+			reg = <0x213000 0x1000>;
+			interrupts = <52>;
+			status = "disabled";
+		};
 	};
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
