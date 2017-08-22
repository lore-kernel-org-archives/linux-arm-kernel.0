From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 22 Aug 2017 12:22:14 +0200
Subject: device tree bindings for lp5523 leds on N950?
In-Reply-To: <20170815131518.jt4xff6qv4whebul@earth>
References: <20170814133816.GA24493@amd>
 <20170815131518.jt4xff6qv4whebul@earth>
Message-ID: <20170822102214.pmag4k2dxz4fdvq5@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 15, 2017 at 09:15:28AM -0400, Sebastian Reichel wrote:
> Hi Pavel,
> 
> On Mon, Aug 14, 2017 at 03:38:16PM +0200, Pavel Machek wrote:
> > I'm (still) trying to debug "N950 not booting" situation. I'm stuck
> > with black screen, so I thought it would be cool to use RGB led for
> > debugging...
> > 
> > Unfortunately, I don't see required dts bindings in the mainline.
> > 
> > Does anyone have that working?
> 
> I have some N950 DTS patches lying around, I think RGB led was one
> of them. I'm currently in Canda for a company event without my N950,
> but I should be able to send something tested before the weekend.

Below is a DTS snippet for N950, that has been tested by me
on top of 4.13-rc6. The left and right keyboard LEDs are
also debug LEDs for cpu idle modes, so they will be lit
without being enabled in lp5523. The status LED of N950 is
not RGB, but just white. Also you need this to get the driver
loading. Otherwise detection after reset fails even after
quite increases waiting times. Looks like the lp5523 reset
(which is not properly Ack'd by the device) breaks the omap-i2c
state horribly.

-- Sebastian

--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -413,7 +413,7 @@ int lp55xx_init_device(struct lp55xx_chip *chip)
                usleep_range(1000, 2000); /* 500us abs min. */
        }
 
-       lp55xx_reset_device(chip);
+       //lp55xx_reset_device(chip); // FIXME: breaks omap-i2c
 
        /*
         * Exact value is not available. 10 - 20ms

----------

&i2c2 {
       rgb-led at 32 {
               compatible = "national,lp5523";
               reg = <0x32>;

               enable-gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>; /* 41 */
               clock-mode = /bits/ 8 <2>; /* external */

               chan0 {
                       chan-name = "lp5523:kb5"; /* Keyboard ooooox */
                       led-cur = /bits/ 8 <50>;
                       max-cur = /bits/ 8 <130>;
               };

               chan1 {
                       chan-name = "lp5523:kb4"; /* Keyboard ooooxo */
                       led-cur = /bits/ 8 <50>;
                       max-cur = /bits/ 8 <130>;
               };

               chan2 {
                       chan-name = "lp5523:kb3"; /* Keyboard oooxoo */
                       led-cur = /bits/ 8 <50>;
                       max-cur = /bits/ 8 <130>;
               };

               chan3 {
                       chan-name = "lp5523:kb2"; /* Keyboard ooxooo */
                       led-cur = /bits/ 8 <50>;
                       max-cur = /bits/ 8 <130>;
               };

               chan4 {
                       chan-name = "lp5523:kb1"; /* Keyboard oxoooo */
                       led-cur = /bits/ 8 <50>;
                       max-cur = /bits/ 8 <130>;
               };

               chan5 {
                       chan-name = "lp5523:kb0"; /* Keyboard xooooo */
                       led-cur = /bits/ 8 <50>;
                       max-cur = /bits/ 8 <130>;
               };

               chan6 {
                       led-cur = /bits/ 8 <0>;
                       max-cur = /bits/ 8 <0>;
               };

               chan7 {
                       led-cur = /bits/ 8 <0>;
                       max-cur = /bits/ 8 <0>;
               };

               chan8 {
                       chan-name = "lp5523:status-led";
                       led-cur = /bits/ 8 <50>;
                       max-cur = /bits/ 8 <130>;
               };
       };
};
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170822/85d089d8/attachment.sig>
