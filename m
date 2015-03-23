From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Mar 2015 21:55:45 +0000
Subject: gpio-syscon for Keystone 2 - DT bindings mismatch code expectation?
Message-ID: <20150323215545.GT8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus, Grygorii,

I'm trying to understand what's happening to make Keystone2 print
this at boot:

gpio-syscon soc:keystone_dsp_gpio at 02620240: can't read the dir register offset!
gpio-syscon soc:keystone_dsp_gpio at 2620244: can't read the dir register offset!
gpio-syscon soc:keystone_dsp_gpio at 2620248: can't read the dir register offset!
gpio-syscon soc:keystone_dsp_gpio at 262024c: can't read the dir register offset!
gpio-syscon soc:keystone_dsp_gpio at 2620250: can't read the dir register offset!
gpio-syscon soc:keystone_dsp_gpio at 2620254: can't read the dir register offset!
gpio-syscon soc:keystone_dsp_gpio at 2620258: can't read the dir register offset!
gpio-syscon soc:keystone_dsp_gpio at 262025c: can't read the dir register offset!

>From what I can see in DT, these are defined as:

                dspgpio0: keystone_dsp_gpio at 02620240 {
                        compatible = "ti,keystone-dsp-gpio";
                        gpio-controller;
                        #gpio-cells = <2>;
                        gpio,syscon-dev = <&devctrl 0x240>;
                };

However, the patch set which introduced the code included:

commit 5a3e3f88b0a10f8b5baf224ebda5916195fb8745
Author: Grygorii Strashko <grygorii.strashko@ti.com>
Date:   Wed Sep 3 20:05:33 2014 +0300

    gpio: syscon: retrive syscon node and regs offsets from dt

which wants gpio,syscon-dev to contain a phandle and two offsets, not
a single offset.  Moreover, the following patch:

commit 2134cb997f2f1b2d960ad8705d67dc8d690ba59c
Author: Grygorii Strashko <grygorii.strashko@ti.com>
Date:   Wed Sep 3 20:05:34 2014 +0300

    gpio: syscon: reuse for keystone 2 socs

added documentation which indicates that for keystone 2, only one
offset is necessary in gpio,syscon-dev, yet there is no "compatible"
string to stop the code requiring two offsets.

This looks like a complete trainwreck.  What's going on here?

Please can this get fixed... Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
