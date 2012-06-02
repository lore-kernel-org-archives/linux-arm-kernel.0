From: hanskroner@gmail.com (Hans =?utf-8?b?S3LDtm5lcg==?=)
Date: Sat, 2 Jun 2012 12:20:59 +0000 (UTC)
Subject: Kernel 3.4 on Dreamplug: no serial console
Message-ID: <loom.20120602T135715-548@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I built a 3.4 kernel by grabbing the sources off kernel.org at
/pub/linux/kernel/v3.0/linux-3.4.tar.bz2

I built both the uImage with FDT support for the Dreamplug and it's respective
dtb, and placed them on the Dreamplug's internal SD. I made minor tweaks
to my U-boot env to handle FDT and proceeded to boot.

At first I thought the Dreamplug was hanging while booting the kernel, since
the console hangs at "Uncompressing Linux... done, booting the kernel."
However, doing the "post mortem" analysis and using U-boot to look at
__log_buf, I could see the kernel actually booting fine. I let it boot and
then SSHd into the box, everything seems fine.

I couldn't figure out why the serial console wasn't working, so I tried using
a newer kernel build. I cloned the 3.4 mainline git tree and built a new
kernel and dtb. This time, the kernel does hang! All I get as output
when doing the "post mortem" analysis is: "Booting Linux on physical
CPU 0."

Did I miss something while configuring the kernel? Am I not
understanding FDT and my U-boot env is messed? I'm attaching both
my U-boot env and .config in hopes that someone can help me figure
this out.

Thanks in advance!!!

Hans

----------
U-boot env
----------
baudrate=115200
bootargs=console=ttyS0,115200
bootcmd=${x_bootcmd_usb}; ${x_bootcmd_kernel};
${x_bootcmd_fdt}; setenv bootargs ${x_bootargs} 
${x_bootargs_root}; bootm 0x6400000 - 0xd000000;
bootdelay=3
eth1addr=F0:AD:4E:00:E0:55
ethact=egiga0
ethaddr=F0:AD:4E:00:E0:56
serial_num=DS2-1148-000242
stderr=serial
stdin=serial
stdout=serial
x_bootargs=console=ttyS0,115200n8 earlyprintk
x_bootargs_root=root=/dev/sda2 rootdelay=10 rootfstype=ext4
x_bootcmd_ethernet=ping 192.168.0.110
x_bootcmd_fdt=ext2load usb 0 0xd000000 kirkwood-dreamplug.dtb
x_bootcmd_kernel=ext2load usb 0 0x6400000 uImage
x_bootcmd_usb=usb start
