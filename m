From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sun, 16 Jun 2013 14:20:15 +0200
Subject: IGEPv2 audio problem
In-Reply-To: <20130616135208.3f124c2c@skate>
References: <20130616135208.3f124c2c@skate>
Message-ID: <51BDAD7F.8090303@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2013 01:52 PM, Thomas Petazzoni wrote:
> Hello,
> 
> I am trying to get audio working on an IGEPv2 with the latest mainline
> kernel, v3.10-rc6, but it unfortunately doesn't work:
> 
> # strace -o strace.log aplay truc.wav 
> Playing WAVE 'truc.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Stereo aplay: pcm_write:1737: write error: Input/output error
> 
> No sound ever goes out of the audio out jack. During the audio
> playback, the kernel complains:
> 
> [  123.353485] omap-dma-engine omap-dma-engine: allocating channel for 33
> [  133.489196] ALSA pcm_lib.c:1942 playback write error (DMA or IRQ trouble?)
> [  143.589172] ALSA pcm_lib.c:1942 playback write error (DMA or IRQ trouble?)
> [  143.595703] omap-dma-engine omap-dma-engine: freeing channel for 33
> 
> And strace confirms that something is going wrong:
> 
> ioctl(4, SNDRV_PCM_IOCTL_WRITEI_FRAMES, 0xbeed49ec) = 0
> ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2c858) = 0
> poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, 100) = 0 (Timeout)
> ioctl(4, SNDRV_PCM_IOCTL_WRITEI_FRAMES, 0xbeed49ec) = -1 EIO (Input/output error)
> write(2, "aplay: pcm_write:1737: ", 23) = 23
> write(2, "write error: Input/output error", 31) = 31
> 
> I've attached the kernel .config, the kernel boot log and the strace
> output.
> 
> Is this a known problem?
> 
> To be sure, I've tested the 2.6.37 kernel provided by ISEE, and it
> works fine on this hardware platform.
> 
> Thanks!
> 
> Thomas
> 

Hi Thomas,

Are you booting with DeviceTree or legacy using the IGEPv2 board file?

I can take a look to this but I don't know if Tony is still accepting bugfixes
for board files.

twl4030 based audio should already work with DT as far as I know.

Can you please try using DT? I don't have access to my IGEPv2 right now but I'm
going to try with both DT and legacy boot too.

To boot the IGEPv2 with DT:

$ make omap2plus_defconfig
$ make -j4 zImage
$ make dtbs
$ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n Linux
-d arch/arm/boot/zImage uImage-omap2plus
$ make omap3-igep0020.dtb
$ cp uImage-omap2plus /media/boot/uImage
$ cp arch/arm/boot/dts/omap3-igep0020.dtb /media/boot

and the following uEnv.txt file:

dtbaddr=0x81600000
kerneladdr=0x80000000
bootargs-base=console=ttyO2,115200n8 console=tty0
mmc-bootargs=setenv bootargs ${bootargs-base} root=/dev/mmcblk0p2 rw rootwait
mmc-boot=run mmc-bootargs; mmc rescan; fatload mmc 0:1 ${kerneladdr} uImage;
fatload mmc 0:1 0x81600000 omap3-igep0020.dtb; fdt addr ${dtbaddr}; fdt resize;
bootm ${kerneladdr} - ${dtbaddr}

uenvcmd=run mmc-boot

Best regards,
Javier
