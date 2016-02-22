From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 22 Feb 2016 17:41:37 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <CACRpkdaXFUCR5=5mS28_4Dx_LfzqV13zwT=vVeJwuOzm_rGRBQ@mail.gmail.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
 <20160217213250.GK19428@n2100.arm.linux.org.uk> <56C5B080.9090007@ti.com>
 <CACRpkdaXFUCR5=5mS28_4Dx_LfzqV13zwT=vVeJwuOzm_rGRBQ@mail.gmail.com>
Message-ID: <56CB2C31.5040703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/02/16 00:39, Linus Walleij wrote:
> On Thu, Feb 18, 2016 at 12:52 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 
>> For panels we need DT fragments. The question is where these fragments
>> are and, possibly, who who loads them.
> 
> I hacked something up that augments the device tree from the kernel,
> given you have a node with all the props you want to augment, tell me
> what you think of this and whether I should continue in this direction...
> also the DT people need to be involved:

What you have there is almost like a legacy board file, isn't it? It's
just passing DT data forward, instead of device platform data. In fact,
if the driver in question supports platform data too, you could as well
generate platform data for it (but I'm not saying that's a better option).

After thinking this a bit and discussing it with Laurent P., generally
speaking I still think that the only sane option is that the bootloader
does any detection needed and provides the kernel a .dtb that contains
the HW that is connected. No board specific drivers are needed on the
kernel side.

In some cases userspace loaded DT overlays may be fine, if the userspace
can do the detection and the device in question is not somehow critical
to operation. But I think displays are critical, and afaik in Versatile
case the userspace can't even do the detection (?).

The third option is to have board specific display handling code and the
display HW data in the kernel, as you've done in the patches.

But, of course, which option should be used for which board is not
always clear...

What bootloader is used on Versatile? If it's some proprietary loader
which can't be changed, then the bootloader option is out, and I guess
it points to the third option, i.e. either the version in this patch or
the earlier version. If it's u-boot, I would suggest going for the
bootloader option.

Afaik u-boot doesn't support combining DT fragments yet. But (also
afaik) the u-boot maintainer is ok with the idea. And I know there are
others (for example TI) interested in the same functionality.

Now, adding that support might take some time, and in the meantime it'd
be good to get the HW working with kernel with a temporary solution. To
do that, my suggestion is basically "any solution which requires no
(temporary) changes to .dts".

While I don't like too much the solution in the patch here, it's all
inside kernel code and can be dropped easily, right? If we would merge
the the multi-endpoint solution you had in the earlier patch, you would
have to support that .dts in the future too.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160222/75449315/attachment.sig>
