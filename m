From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Thu, 6 Mar 2014 13:34:02 +0100
Subject: imx-drm: ldb and display power on sequence
Message-ID: <CAH9NwWcE=4OVHSMKCEuTrFA7JMGEdkxrbX_0OORZ96N1Roi2HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all.

On our custom board design (imx6d) we are using a TFT-display
connceted via LVDS.
The datasheet [0] says that the display needs a defined power up
sequence. I need
to control the following stuff:

- LCD_ON (gpio2 3)
- Backlight ON (gpio2 0)
- PMW for dimm

At the moment I have the backlight suff ready:

       backlight {
               compatible = "pwm-backlight";
               pwms = <&pwm4 0 50000>;
               enable-gpios = <&gpio2 0 0>;

               brightness-levels = <0 1 2 3 4>;
               default-brightness-level = <4>;
       };

Now I only need to enable the LCD_ON and wait 40ms before turning on
the LVDS clocks and data. For this I tought
to add a regulator support in imx_ldb_encoder_commit(..) of imx-ldb.c.
That should give me the correct sequence for
LVDS on to LVDS data/clock. Now I only need to get the pwm-backlight
driver doing its work after ldb is ready.

Are there some other and better solutions to this problem?

[0] http://www.hy-line.de/fileadmin/hy-line/computer/csv/datasheets/FG050722DSSWDG01.pdf

thanks
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
