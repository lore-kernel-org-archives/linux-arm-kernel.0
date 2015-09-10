From: mwp@mwp.id.au (Mark Williams)
Date: Thu, 10 Sep 2015 19:57:34 +0930
Subject: MXS Framebuffer pan/virtual issues
Message-ID: <CA+OkyLQLB1=BZ__9UqBdaUQSR7AwNtjLzpWYduZTrkz=BdwDMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings all,

I'm trying to get double-buffering working with my iMX287 based embedded device.
It uses a 800x480 TFT which is supported by the MXS framebuffer kernel driver.

Setting the larger virtual_yres appears to work (ioctl() returns
successfully), but subsequent FBIOGET_VSCREENINFO returns the old
virtual_yres value?

FBIOPAN_DISPLAY with any yoffset other than a value of 0 fails.

Does anyone know what's going on here?

Test code is as follows:

fd = open("/dev/fb0", O_RDWR);
ioctl(fd, FBIOGET_FSCREENINFO, &fb_fix);
ioctl(fd, FBIOGET_VSCREENINFO, &fb_var);
printf("RES: %u x %u\n",fb_var.xres,fb_var.yres);

fb_var.xres_virtual = fb_var.xres;
fb_var.yres_virtual = fb_var.yres * 2;
printf("SET-VIRT: %u x %u\n",fb_var.xres_virtual,fb_var.yres_virtual);
printf("FBIOPUT_VSCREENINFO: %d\n", ioctl(fd, FBIOPUT_VSCREENINFO, &fb_var));

ioctl(fd, FBIOGET_VSCREENINFO, &fb_var);
printf("NEW-VIRT: %u x %u\n",fb_var.xres_virtual,fb_var.yres_virtual);

fb_var.xoffset = 0;
fb_var.yoffset = fb_var.yres;
printf("FBIOPAN_DISPLAY: %d\n", ioctl(gfx_fbfd, FBIOPAN_DISPLAY, &fb_var));

This results in the output:

RES: 800 x 480
SET-VIRT: 800 x 960
FBIOPUT_VSCREENINFO: 0
NEW-VIRT: 800 x 480
FBIOPAN_DISPLAY: -1

Thankyou,
Mark Williams.
