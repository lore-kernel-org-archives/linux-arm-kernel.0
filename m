From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 1 Oct 2015 09:24:15 +0200
Subject: [PATCH 30/31] ARM: shmobile: r8a7791: add USB-DMAC device nodes
In-Reply-To: <SG2PR06MB0919932925BB68EC82538044D84D0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
 <e3e25edc1116ebf44b1813aff03b02b7737d41ca.1431565427.git.horms+renesas@verge.net.au>
 <560B11FF.3010305@cogentembedded.com>
 <SG2PR06MB0919932925BB68EC82538044D84D0@SG2PR06MB0919.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdVfmOifVdW2a4Ai2-T4WZPFd5d+OtNHhVhD9g+CF1zgxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shimoda-san,

On Wed, Sep 30, 2015 at 11:06 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> Sent: Wednesday, September 30, 2015 7:35 AM
>>     When the USB-DMAC driver is enabled, this causes kernel oops on at least
>> the R8A7791 Henninger/Porter boards (haven't checked the others yet) with
>> renesas-devel-20150928-v4.3-rc3 and even earlier tag. The oops can only be
>> seen with the earlyprintk=serial kernel parameter, otherwise the kernel just
>> hangs with a blank console.
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 00000014

>> [<c027f0cc>] (usb_dmac_chan_halt) from [<c027f1c8>] (usb_dmac_runtime_suspend+0)
>>   r5:eebdaf50 r4:00000001
>> [<c027f19c>] (usb_dmac_runtime_suspend) from [<c02d60e0>] (pm_generic_runtime_s)
>>   r6:00000000 r5:c02ddfc4 r4:ee93d810 r3:c027f19c

> I'm not sure but I am guessing this issue related runtime PM? (suspend)
> I checked the usb-dmac driver roughly, and if the usb_dmac_runtime_suspend()
> is called before usb_dmac_chan_probe() runs, it might happen because dmac->iomem is NULL.

That's exactly what's happening. Reproduced with CONFIG_PREEMPT=y (thanks
Sergei), and patch sent.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
