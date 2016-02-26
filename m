From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 26 Feb 2016 12:47:04 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
 <56CF2FB1.106@ti.com>
 <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>
Message-ID: <56D02D28.9080109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/02/16 21:30, Linus Walleij wrote:
> On Thu, Feb 25, 2016 at 5:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On 25/02/16 16:04, Linus Walleij wrote:
> 
>>> *All* the others
>>> will be very happy with *ONE* display defined as panel in the
>>> device tree, and off they go. Usually VGA. And that will look
>>
>> You keep mentioning VGA. So is there are VGA output? Or do you just mean
>> MIPI DPI panels, which happen to take the same video timings as VGA?
> 
> Russell beat me to it, yes there is an external VGA encoder.
> It needs some bits set up through the "misc registers" system
> controller as indicated. From the CLCD hardware point of view
> it's no different than any other panel. So the DTS fragment looks
> like so:
> 
>                         panel {
>                                 compatible = "panel-dpi";
> 
>                                 port {
>                                         clcd_panel: endpoint {
>                                                 remote-endpoint = <&clcd_pads>;
>                                         };
>                                 };
> 
>                                 /* Standard 640x480 VGA timings */
>                                 panel-timing {
>                                         clock-frequency = <25175000>;
>                                         hactive = <640>;
>                                         hback-porch = <48>;
>                                         hfront-porch = <16>;
>                                         hsync-len = <96>;
>                                         vactive = <480>;
>                                         vback-porch = <33>;
>                                         vfront-porch = <10>;
>                                         vsync-len = <2>;
>                                 };
>                         };
> 
> 
> This is reported as the default display type if no LCD panel
> is connected.
> 
> If a LCD panel is also connected, it take precedence.

Ok. Well... It's all wrong, but I don't know how much time we want to
spend on fixing that.

Although one thing to consider is that if there is ever going to be a
DRM driver for CLCD, it would be good to have the device tree parts
correctly representing the hardware, so that the DRM driver could be
implemented in a cleaner, more generic way.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/2d0bbf63/attachment.sig>
