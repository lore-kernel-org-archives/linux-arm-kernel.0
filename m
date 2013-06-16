From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sun, 16 Jun 2013 17:43:34 +0200
Subject: IGEPv2 audio problem
In-Reply-To: <20130616153406.1c8096fa@skate>
References: <20130616135208.3f124c2c@skate> <51BDAD7F.8090303@collabora.co.uk>
 <20130616153406.1c8096fa@skate>
Message-ID: <51BDDD26.3000203@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2013 03:34 PM, Thomas Petazzoni wrote:
> Dear Javier Martinez Canillas,
>

Hi Thomas,

> Thanks for your quick feedback!
> 
> On Sun, 16 Jun 2013 14:20:15 +0200, Javier Martinez Canillas wrote:
> 
>> Are you booting with DeviceTree or legacy using the IGEPv2 board file?
> 
> I was booting legacy with the IGEPv2 board file.
> 
>> I can take a look to this but I don't know if Tony is still accepting bugfixes
>> for board files.
>> 
>> twl4030 based audio should already work with DT as far as I know.
>> 
>> Can you please try using DT? I don't have access to my IGEPv2 right now but I'm
>> going to try with both DT and legacy boot too.
> 
> I've tried DT based boot right now, and it doesn't work any better:
> 
> # aplay test.wav 
> [  172.044494] omap-dma-engine 48056000.dma-controller: allocating channel for 33
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> aplay: pcm_write[  192.184661] omap-dma-engine 48056000.dma-controller: freeing channel for 33
> :1737: write error: Input/output error
> 
> and I still have the following message in dmesg:
> 
> [  182.083740] ALSA pcm_lib.c:1942 playback write error (DMA or IRQ trouble?)
> 
> And I'm really booting the DT way:
> 
> $ dmesg | grep Flattened
> [    0.000000] Machine: Generic OMAP3 (Flattened Device Tree), model: IGEPv2
>

Thanks a lot for testing and the feedback. I'll investigate this as soon as I
have access to my IGEPv2 board again.

> Also, there is a fairly significant issue with the DT based booting:
> the Ethernet controller is not enabled apparently.
> 

Yes, this is a known issue. The problem is that the smsc911x chip is using a
GPIO line as IRQ but the OMAP GPIO bank is not initialized before the call to
request_irq() is made on the smsc911x probe function. An explicit call to
gpio_request() is needed to enable the GPIO bank.

For legacy booting this is done in arch/arm/mach-omap2/gpmc-smsc911x.c but for
DT based booting this is never made. That is why ethernet is not currently
working since request_irq() is failing.

There was a very long discussion on linux-omap with Jon Hunter, Linus Walleij,
Grant Likely (cc'ed now) and others about the best approach to solve this. I
posted a RFC patch [1] to add a .irq_request function handler to struct irq_chip
so gpio_request() could be called by the IRQ core on setup.

Linus said that the right solution is to have some GPIO "hogging" that describes
which GPIO pins could be used as IRQ so the banks could be pre-initialized while
Jon said that the best approach is to call gpio_request() on a custom xlate
handler for the GPIO OMAP, like is made here [2] for the at91 chip. Grant seems
to agree with Jon so probably that is how we are finally solve this issue.

For now I'm carrying this HACK patch [3] on my dev tree to make the smsc911x LAN
chip to work on my IGEPv2 board.

> I must admit I really don't understand the way mach-omap2 is handling
> the migration from legacy booting to DT-based booting. Right now, you
> have the choice between:
> 
>  (*) Legacy booting, with which you get support for all devices, but as
>      you said, if something breaks, it may not get fixed as legacy booting
>      is deprecated.
> 
>  (*) DT booting, which is supported, but not all devices are enabled
>      because some of them are handled by drivers that still lack a DT
>      binding.
> 

Yes, I also admit that the process has been a little bit frustrating for people
like me trying to maintain an OMAP3 board. For legacy booting Enric and I used
to fix the issues found with IGEP boards but it was getting every time more hard
to get the patches accepted until I decided it was not worth spending my (free)
time on it.

So I started adding DT support for IGEP boards and hacking some drivers like
smsc911x and GPMC but there is still a long way to get all the hardware support
we already have today with board files. DSS bindings have not landed in mainline
yet, USB HOST and OTG are not working for me and now you say that twl4030 audio
is not working either...

> Why isn't the mach-omap2 world following the path that other platforms
> have followed, such as mach-kirkwood, where the migration to the DT is
> done progressively? When a board is converted to the DT, the
> possibility of booting it the legacy way is removed, but all the
> devices that cannot be initialized through DT remain initialized using
> C function calls and platform_device. This offers a smooth transition
> to end users. See
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-kirkwood/board-dt.c#n109
> for details on how it is done on Kirkwood platforms. For example,
> Kirkwood still lacks a DT binding for its Ethernet driver, but the
> Ethernet interface(s) still get probed the old way even if you're
> booting through DT.
> 

In fact the same path is being used for OMAP. There is a board-generic.c in
mach-omap2 that is compatible with "ti,omap{3,4,5}". If you look to the
omap_generic_init() .init_machine handler for this board file, you will see that
the display is explicitly initialized for panda and panda sdp using C function
calls and platform device/data since the OMAP DSS DT bindings are still not
available [4].

This is necessary since from v3.11 OMAP4 will be DT only and all the OMAP4 board
files will be removed.

I think the problem is not with the process but that OMAP3 is not been tested
correctly due lack of manpower. So now we have OMAP3 legacy boot broken and
deprecated but we are still far from having everything working with DT. I don't
really know how we can solve this...

> That said, in this particular case, it seems like audio doesn't work
> regarless of the boot method. But if audio gets fixed for DT based
> booting, it will be pretty useless: an IGEPv2 without Ethernet is not
> very useful.
> 

Yes, from your description it seems that audio is not working regardless the
boot method. I'll try to take a look to this issue this week.

> Best regards,
> 
> Thomas
> 

Best regards,
Javier

[1]: https://patchwork.kernel.org/patch/2275971/
[2]: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/195124
[3]
commit e1dcbd1d050ee901db9f827fc02449432c62a90d
Author: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date:   Wed Mar 13 18:16:43 2013 +0100

    ARM: OMAP: gpmc: (HACK) explicitly call request_gpio for smsc IRQ-GPIO

    Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ed946df..f74e081 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -14,6 +14,7 @@
  */
 #undef DEBUG

+#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -1520,6 +1521,11 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 		return ret;
 	}

+	if (gpio_request_one(176, GPIOF_IN, "smsc911x irq")) {
+		pr_err("Failed to request IRQ GPIO%d\n", 176);
+		return -1;
+	}
+
 	for_each_node_by_name(child, "nand") {
 		ret = gpmc_probe_nand_child(pdev, child);
 		if (ret < 0) {

[4]:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-omap2/board-generic.c#n38
