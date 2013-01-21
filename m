From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 21 Jan 2013 19:34:51 +0100
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <20130121182419.GE10020@beef>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef>
Message-ID: <20130121183451.GD2342@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 01:24:19PM -0500, Matt Porter wrote:
> On Mon, Jan 21, 2013 at 06:20:03PM +0000, Richard Cochran wrote:
> > On Mon, Jan 21, 2013 at 10:45:10AM -0600, Nishanth Menon wrote:
> > > for MMC filesystem - we need the edma series. for a ramdisk, I am able
> > > to boot up to shell with 3.8-rc4 tag
> > 
> > Yep, I also could boot 3.8-rc3 using ramfs, no problem.
> 
> Do you use appended dtb? The only different that jumped out at me first
> Paul's reported hang is he uses appended dtb and I boot my boards with a
> single uImage and multiple dtbs the traditional DT way.

No, not appended. I have a u-boot that supports dtb:

  U-Boot SPL 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)
  U-Boot 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)

and using the omap2plus_defconfig, with a minicom script like the one
below, and it works just fine.

HTH,
Richard


verbose on
send setenv ipaddr 192.168.1.77
send setenv serverip 192.168.1.12
send setenv netmask 255.255.255.0
send setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=16384 earlyprintk=serial
send tftp 81000000 uImage
expect {
	"U-Boot# "
}
send tftp 82000000 beaglebone-initrd.gz
expect {
	"U-Boot# "
}
send tftp 80000000 am335x-bone.dtb
expect {
	"U-Boot# "
}
send bootm 81000000 - 80000000
