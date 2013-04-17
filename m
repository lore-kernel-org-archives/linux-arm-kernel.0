From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 Apr 2013 17:15:48 +0200
Subject: MXS framebuffer driver and 18bits display
Message-ID: <516EBCA4.1020609@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We noticed a strange bug with the 18 bits display found in the
iMX28 CFA-10049, but it should not be specific to it.

Like I said, we have a small 18-bits LCD panel. When further testing
it, it displayed horrible colors with standard jpg images used together
with tools such as fbv, applications written in Qt, etc.

Digging a bit into it, it looks like the mxsfb driver accepts devices
with 18bits interfaces.

However, in such case, the driver registers as a 32bits framebuffer
device, sets up the controller as a 24 bits display, and is actually
asking the controller to drop the 2 upper bits of each color by setting
the DATA_FORMAT_24_BIT bit in the HW_LCDIF_CTRL register.

So basically, applications feed to the framebuffer something like:

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| R7| R6| R5| R4| R3| R2| R1| R0| G7| G6| G5| G4| G3| G2| G1| G0| B7| B6| B5| B4| B3| B2| B1| B0|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

And what is being sent to the LCD is:

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| R5| R4| R3| R2| R1| R0| G5| G4| G3| G2| G1| G0| B5| B4| B3| B2| B1| B0|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

And thus, results in colors being horrible because the MSB are dropped.

What I believe the controller should send in theory should be :

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| R7| R6| R5| R4| R3| R2| G7| G6| G5| G4| G3| G2| B7| B6| B5| B4| B3| B2|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

Thus dropping the 2 LSB for each color. However, it doesn't seem that
the controller can be setup that way.

We thought of several solutions for this:
  - Switching to "real" 18 bits color depth
    * It is definitely not a good solution, since it requires the
      applications to handle the 18 bits color depth case, which only a
      few of them do.
  - Using the SHIFT_NUM_BITS bits in the HW_LCDIF_CTRL register
    * It doesn't look like a good solution either, since it seems to be
      shifting the whole 24 bits, and not each color independently, so
      the result will only be worse.
  - Use a 16 bits color depth
    * It doesn't seem possible either, since the 16 bits will be packed
      on two bytes, while the controller expects the 18 bits not to be
      packed.

Do you see a solution for this?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
