From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2015 18:29:24 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56096B85.6040002@free.fr>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
 <56094543.2040101@free.fr> <56096B85.6040002@free.fr>
Message-ID: <20150928172924.GA21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 06:32:05PM +0200, Mason wrote:
> On 28/09/2015 15:48, Mason wrote:
> 
> > But tango_timer_init() is not being called...
> 
> Doh! I was using the wrong DTB...
> 
> By the way, the command I use to generate uImage feels wrong.
> Is there a better way?
> 
> $ make dtbs ; make -j2 zImage ; cat arch/arm/boot/zImage arch/arm/boot/dts/tango4.dtb >XXX && mv XXX arch/arm/boot/zImage ; make uImage LOADADDR=0x80008000

bash$ cat > build.sh
#!/bin/sh
function emake
{
  LANG=C make -j2 CROSS_COMPILE=arm-linux- ARCH=arm "$@"
}

load=0x80008000

emake zImage dtbs
v=$(emake -s kernelrelease)
cat arch/arm/boot/zImage arch/arm/boot/dts/tango4.dtb zImage.tmp
mkimage -A arm -O linux -C none -T kernel \
	-a $load -e $load -n "Linux $v (dt)" -d zImage.tmp uImage
^d
bash$ chmod 755 build.sh
bash$ ./build.sh #<--- build kernel to uImage like this

Even better (and this is what I do) is you can append to that script
a command to copy it to your TFTP server, install modules, tar them
up, copy the modules to the target, and have the target automatically
reboot after the kernel build has finished (provided certain options
are given to the script.)

For a fair number of my active development boards, my kernel build and
boot process is just:

$ kbuild -r -m imx6 cbi4 ssh:hbi2ex hbi1

to build and boot an imx6 kernel on three imx6 machines, or just:

$ kbuild armada38x

to build and copy the armada38x kernel to the tftp server.

This is why people who think that copying kernels to SD cards is somehow
easier than TFTP boot - TFTP based booting is fully automated, no need
to constantly plug and unplug SD cards, wearing out their sockets.  You
can't get any simpler than running a script, walking away to make a
coffee, coming back and having your newly built kernel running on a
whole suite of platforms without any user intervention - complete with
updated modules on the target systems. ;)

-- 
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
