From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 25 Nov 2016 18:32:07 +0800
Subject: [PATCH v6 3/5] ARM: dts: sun8i-h3: add HDMI video nodes
In-Reply-To: <20161125112213.83420594eb435b6bb1a4d164@free.fr>
References: <cover.1479641523.git.moinejf@free.fr>
 <cdf50b8433e2d9a053e35f8788bfcd5d41504312.1479641523.git.moinejf@free.fr>
 <3188681480066911@web3h.yandex.ru>
 <20161125112213.83420594eb435b6bb1a4d164@free.fr>
Message-ID: <9050701480069927@web15h.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



25.11.2016, 18:22, "Jean-Francois Moine" <moinejf@free.fr>:
> On Fri, 25 Nov 2016 17:41:51 +0800
> Icenowy Zheng <icenowy@aosc.xyz> wrote:
>
>> ?After removing CLK_PLL_DE's assigned-clock, the kernel passes compilation.
>
> The 'pll-de' and 'de' must have a fixed rate. Otherwise, if you do not
> use the legacy u-boot, I don't know which can be the rate of the DE.

Can't CCU deal with this?

I still kept the CLK_DE's assigned-clock...

>
>> ?However, it cannot recognize any HDMI screen...
>>
>> ?(My board is Orange Pi One, and I manually added status="okay"; to &lcd0, &de, &hdmi)
>>
>> ?[ 16.507802] sun8i-de2 1000000.de-controller: bound 1c0c000.lcd-controller (ops de2_lcd_ops [sun8i_de2_drm])
>> ?[ 16.675948] sun8i-de2 1000000.de-controller: bound 1ee0000.hdmi (ops de2_hdmi_fini [sun8i_de2_hdmi])
>> ?[ 16.685120] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> ?[ 16.695876] [drm] No driver support for vblank timestamp query.
>> ?[ 16.701862] sun8i-de2 1000000.de-controller: No connectors reported connected with modes
>> ?[ 16.713061] [drm] Cannot find any crtc or sizes - going 1024x768
>> ?[ 16.734214] Console: switching to colour frame buffer device 128x48
>> ?[ 16.751022] sun8i-de2 1000000.de-controller: fb0: frame buffer device
>
> I put a 'pr_warn' message is case the EDID cannot be read.
> Have you this message?

Seems no...

>
> Anyway, there is a problem with the EDID:
> - my Orange Pi 2 (H3) randomly fails to read it. But this succeeds after
> ??rebooting once or twice.
> - my Banana Pi M2+ (H3) reads it correctly each time.
> - my Banana Pi M3 (A83T) can never read it.
>
> BTW, on first tries, I was forcing a CEA mode thru the kernel command
> line. This was working with the OPi2 and BPiM3, but there was no sound.
> In the last version, I use a EDID in edid_firmware for having sound
> with the BPiM3. This works fine.
> But, forcing a CEA mode is no more possible, so, when the OPi2 cannot
> read the EDID, the system switches to a VGA mode (default 1024x768)
> which is not supported. It seems that this is your case.
>
> So, in brief, if your board cannot read the EDID, put a EDID somewhere
> and its path in /sys/module/drm_kms_helper/parameters/edid_firmware.
> There will be no console, but X11 will work correctly.

The problem seems to be that the CRTC is not properly initialized...

>
> --
> Ken ar c'henta? | ** Breizh ha Linux atav! **
> Jef | http://moinejf.free.fr/
