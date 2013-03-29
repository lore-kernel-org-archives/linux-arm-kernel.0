From: ryan@presslab.us (Ryan Press)
Date: Thu, 28 Mar 2013 21:13:48 -0700
Subject: [PATCH] ARM: mvebu: Add gpio button to Mirabox board
In-Reply-To: <20130328033807.GA12212@localhost>
References: <CABx3TkVyVAzEJ54FV70fK3BoULKCOkgNcw32_K3XT-oCUWjEfg@mail.gmail.com>
 <20130328033807.GA12212@localhost>
Message-ID: <CABx3TkW0P7spbUr5gTRQMz9mqNZeWXQn8z212V1wiOPv135M7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On Wed, Mar 27, 2013 at 8:38 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Wed, Mar 27, 2013 at 05:42:36PM -0700, Ryan Press wrote:
>> Ezequiel Garcia wrote:
>> >
>> >The Globalscale Mirabox board has a little gpio button
>> >placed just above the SD card slot; the board user guide labels
>> >this button as "System reset button".
>> >
>> >This patch adds support for this button in the device tree file.
>> I was not able to get this to work, I think there is
>> some IRQ problem.  I was able to get it to work with
>> "gpio-keys-polled" however.
>>
>
> Could you explain what you did and what was your problem?

Just to be on the same page, I pulled the latest 3-9-rc4, with no
other changes, and then added your patch.  Does this rely on a patch?
No interrupt events are shown in /proc/interrupts.  I have a lot more
things running than your box, maybe there is a conflict.

#cat /proc/interrupts
           CPU0
 16:      12222  armada_370_xp_irq  armada_370_xp_per_cpu_tick
 17:        552  armada_370_xp_irq  serial
 25:          0  armada_370_xp_irq  d0010300.rtc
 27:       6438  armada_370_xp_irq  ehci_hcd:usb1
 28:          0  armada_370_xp_irq  ehci_hcd:usb2
 95:          0  d0018140.gpio  Reset Button
104:          2  armada_370_xp_irq  d0060800.xor
105:          2  armada_370_xp_irq  d0060800.xor
106:          2  armada_370_xp_irq  d0060900.xor
107:          2  armada_370_xp_irq  d0060900.xor
IPI0:          0  CPU wakeup interrupts
IPI1:          0  Timer broadcast interrupts
IPI2:          0  Rescheduling interrupts
IPI3:          0  Function call interrupts
IPI4:          0  Single function call interrupts
IPI5:          0  CPU stop interrupts
Err:          0

Here is my kernel config:
http://pastebin.com/rFQSUAPs

Maybe you can send me your config and I will try it.

Oh and although I guess the bootloader sets it up, i wouldn't trust
it.  There should probably be the pinctrl in the device tree, yes?

Thanks,
Ryan


diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts
b/arch/arm/boot/dts/armada-370-mirabox.dts
index dd0c57d..f083f56 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -33,6 +33,14 @@
 			clock-frequency = <600000000>;
 			status = "okay";
 		};
+
+		pinctrl {
+			reset_button_pin: reset-button-pin {
+				marvell,pins = "mpp58";
+				marvell,function = "gpio";
+			};
+		}
+
 		gpio-keys {
 			compatible = "gpio-keys";
 			#address-cells = <1>;
