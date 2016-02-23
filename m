From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 23 Feb 2016 15:00:44 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <6859810.tb1t0IEONi@wuerfel>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel>
Message-ID: <56CC57FC.20707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/02/16 13:22, Arnd Bergmann wrote:
> On Tuesday 23 February 2016 11:10:33 Linus Walleij wrote:
>>
>> ERROR (duplicate_label): ERROR (duplicate_label): Duplicate label
>> 'clcd_panel' on /panel at 1/port/endpoint and /panel at 0/port/endpoint
>> Duplicate label 'clcd_panel' on /panel at 1/port/endpoint and
>> /panel at 0/port/endpoint
>>
>> So the dtc does not allow duplicate node labels for the phandle
>> even if the node it resides in is disabled. Tough luck...
> 
> Ah, too bad. I guess we could still do it by also setting the
> remote-endpoint property to node->phandle, but then it's
> not as simple any more.

I think it could be done with all panels in an endpoint of their own, as
it is currently in this patch. All the panels would be disabled by
default, and one of them gets enabled at some early boot phase. The
fbdev driver would then iterate the endpoints and pick the first panel
that's enabled.

That would be almost the same as what's already in this patch, except
(if I'm not mistaken) the detection part could be in platform code, and
the fbdev driver itself would know nothing about board specific
detection or board specific panel lists.

So maybe that would be a bit cleaner. Still ugly, I think =). I really
don't like having possible-panels in the Schr?dinger's DT data
(http://www.angryflower.com/387.html).

That said, maybe this is the best way to deal with Versatile, without
requiring any change to the bootloader or the boot mechanism.

What is the current status of Versatile? Have we had working display
with Versatile when booting with device tree? Or has the display been
supported only with legacy boot?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160223/39c3ae95/attachment.sig>
