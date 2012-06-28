From: kbaidarov@dev.rtsoft.ru (Konstantin Baydarov)
Date: Thu, 28 Jun 2012 14:26:28 +0400
Subject: [PATCH v3 2/7] mfd: omap: control: core system control driver
In-Reply-To: <4FEC2E1D.5040309@dev.rtsoft.ru>
References: <4FEB4B46.9020904@dev.rtsoft.ru> <20120628045028.GC2471@besouro>
 <4FEC25CA.10105@dev.rtsoft.ru>
 <CAGF5oy9heLnjcHj4H=hMK9NAkrDoOocR-Lbv1Z4cQ4G1C5kSeQ@mail.gmail.com>
 <4FEC2E1D.5040309@dev.rtsoft.ru>
Message-ID: <4FEC3154.9050103@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2012 02:12 PM, Konstantin Baydarov wrote:
> The interface(design) of omap-control-core.c has already been discussed many times :(
> Eduardo, in his patch set, suggested following design:
> - omap-control-core.c ioremaps SCM window and provide functions to read/write SCP register for bandgap and usb.
>
> IIRC, this approach didn't satisfy and it was suggested to have private read/write in bandgap and usb.
>
> So, my patch set introduces following design:
> - omap-control-core.c don't provide read/write functions for bandgap and usb.
> - bandgap and usb use their own private read/write functions
> - Each omap-control-core.c, bandgap and usb drivers remap SCM window. It's OK because SCM window is statically mapped to the same virtual address. But the problem is that SMP memory window isn't protected. I'm not sure whether it's possible to protect SCM window using this approach.
I mean:

- Each omap-control-core.c, bandgap and usb drivers remap SCM window. It's OK because SCM window is statically mapped. So each call of ioremap in omap-control-core.c, bandgap and usb drivers returns the same virtual address. But the problem is that SCM memory window isn't protected. I'm not sure whether it's possible to protect SCM window using this approach(when each driver remaps the same IOMEM).

>
> Another possible design is:
> - omap-control-core.c ioremaps and reserves SCM IOMEM window
> - omap-control-core.c exports omap_control_get_base(virtual base address is returned) to use in bandgap and usb_phy driver.
> - Bandgap and usb phy uses their own private read/write function.
> IIUC, this way was suggested by Tony.
>
> I guess It's better to settle the design(interface) of omap-control-core.c, bandgap and usb phy and then submit the next version of patch set.
