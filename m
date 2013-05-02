From: jjo.braun@gmail.com (Johannes Braun)
Date: Thu, 2 May 2013 20:00:24 +0200
Subject: Freescale imx35: sgtl5000 codec not working over i2c
Message-ID: <20130502200024.72c112cc@jobraun>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello @all,

I hope this is the right place for my problem. Currently I am trying to
get a sigmatel sgtl5000 codec to work on a Freescale imx35 based board.
I am using a vanilla kernel 3.7.10. The codec is connected via i2c. I
configured the i2c device in /arch/arm/mach-imx/mach-proxmobil2.c.
Proxmobil2 is the name of our device. Here is the part which configures
the i2c device and the bus.

static const struct imxi2c_platform_data mx35_prox2_i2c0_data
	__initconst = {
        .bitrate = 100000,
};

imx35_add_imx_i2c0(&mx35_prox2_i2c0_data);

static struct i2c_board_info __initdata i2c_devices_prox2[] = {
        {
                I2C_BOARD_INFO("imx-audio-sgtl5000", 0x0a),
        },
};

i2c_register_board_info(0, i2c_devices_prox2,
	ARRAY_SIZE(i2c_devices_prox2));


The i2c bus is working correctly. I can scan the bus in uboot and in
linux with i2cdetect. In both cases a device with the address 0x0a is
found. This is the address of the sgtl5000 codec. The device is also
present in /sys/bus/i2c/devices.The audio codec is the only device on
the bus.

I tested the data and clock line with a oszilloscope while booting
linux. There was no activity. But when I scan the bus via uboot or via
i2cdetect I can seen that there is action on the bus. Also the power
supply for the codec looks good. I measured 3.3 V. So I think it is not
a problem with the wiring. 

The problem I is that the driver imx-audio-sgtl5000 does not start. I
tested it with some printk outputs in its probe method. But the probe
method is never called.

Then I thought, maybe it is a it is a problem with my board
configuration file. So I tested the codec on the Freescale imx35 3stack
eval board. But without success. This try ends with the same result. No
driver was loaded, alsa did not detect a soundcard and so on.

The result is a non working audio codec on the board. Shure I can use
the Freescale kernel. But this kernel I to old. I think it is a
2.6.28 kernel. I want to use an actual kernel with the board. So maybe
someone has a running sgtl5000 code in combination with a imx35 board.
I am grateful for tips. Thanks for reading.

---
Johannes
