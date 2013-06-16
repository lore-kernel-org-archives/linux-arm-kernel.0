From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 16 Jun 2013 15:34:06 +0200
Subject: IGEPv2 audio problem
In-Reply-To: <51BDAD7F.8090303@collabora.co.uk>
References: <20130616135208.3f124c2c@skate> <51BDAD7F.8090303@collabora.co.uk>
Message-ID: <20130616153406.1c8096fa@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Javier Martinez Canillas,

Thanks for your quick feedback!

On Sun, 16 Jun 2013 14:20:15 +0200, Javier Martinez Canillas wrote:

> Are you booting with DeviceTree or legacy using the IGEPv2 board file?

I was booting legacy with the IGEPv2 board file.

> I can take a look to this but I don't know if Tony is still accepting bugfixes
> for board files.
> 
> twl4030 based audio should already work with DT as far as I know.
> 
> Can you please try using DT? I don't have access to my IGEPv2 right now but I'm
> going to try with both DT and legacy boot too.

I've tried DT based boot right now, and it doesn't work any better:

# aplay test.wav 
[  172.044494] omap-dma-engine 48056000.dma-controller: allocating channel for 33
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: pcm_write[  192.184661] omap-dma-engine 48056000.dma-controller: freeing channel for 33
:1737: write error: Input/output error

and I still have the following message in dmesg:

[  182.083740] ALSA pcm_lib.c:1942 playback write error (DMA or IRQ trouble?)

And I'm really booting the DT way:

$ dmesg | grep Flattened
[    0.000000] Machine: Generic OMAP3 (Flattened Device Tree), model: IGEPv2

Also, there is a fairly significant issue with the DT based booting:
the Ethernet controller is not enabled apparently.

I must admit I really don't understand the way mach-omap2 is handling
the migration from legacy booting to DT-based booting. Right now, you
have the choice between:

 (*) Legacy booting, with which you get support for all devices, but as
     you said, if something breaks, it may not get fixed as legacy booting
     is deprecated.

 (*) DT booting, which is supported, but not all devices are enabled
     because some of them are handled by drivers that still lack a DT
     binding.

Why isn't the mach-omap2 world following the path that other platforms
have followed, such as mach-kirkwood, where the migration to the DT is
done progressively? When a board is converted to the DT, the
possibility of booting it the legacy way is removed, but all the
devices that cannot be initialized through DT remain initialized using
C function calls and platform_device. This offers a smooth transition
to end users. See
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-kirkwood/board-dt.c#n109
for details on how it is done on Kirkwood platforms. For example,
Kirkwood still lacks a DT binding for its Ethernet driver, but the
Ethernet interface(s) still get probed the old way even if you're
booting through DT.

That said, in this particular case, it seems like audio doesn't work
regarless of the boot method. But if audio gets fixed for DT based
booting, it will be pretty useless: an IGEPv2 without Ethernet is not
very useful.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
