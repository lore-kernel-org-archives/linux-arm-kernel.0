From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 19 Jan 2014 22:01:29 +0100
Subject: [PATCH 13/15] fbdev: sh-mobile-lcdcfb: Enable driver compilation
 with COMPILE_TEST
In-Reply-To: <52D8F14A.7030100@ti.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <52CD0CBB.3070801@ti.com> <52D8F14A.7030100@ti.com>
Message-ID: <22423852.GiH1NBjiii@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

On Friday 17 January 2014 11:00:58 Tomi Valkeinen wrote:
> Hi,
> 
> On 2014-01-08 10:30, Tomi Valkeinen wrote:
> > On 2014-01-07 17:15, Laurent Pinchart wrote:
> >> On Wednesday 11 December 2013 13:51:18 Laurent Pinchart wrote:
> >>> Hi Jean-Christophe and Tomi,
> >>> 
> >>> Could you please pick this patch up for v3.14 ?
> >> 
> >> Ping ?
> > 
> > Queued for 3.14.
> 
> I'll drop this patch, as it causes compile break (from kbuild test robot):
> 
> All error/warnings:
> 
>    drivers/built-in.o: In function `sh_mobile_lcdc_pan':
> >> sh_mobile_lcdcfb.c:(.text+0x77373): undefined reference to
> `sh_mobile_meram_cache_update'
>    drivers/built-in.o: In function `sh_mobile_lcdc_start':
> >> sh_mobile_lcdcfb.c:(.text+0x79320): undefined reference to
> `sh_mobile_meram_cache_free'
> >> sh_mobile_lcdcfb.c:(.text+0x79394): undefined reference to
> `sh_mobile_meram_cache_alloc'
> >> sh_mobile_lcdcfb.c:(.text+0x793d4): undefined reference to
> `sh_mobile_meram_cache_update'
>    drivers/built-in.o: In function `sh_mobile_lcdc_stop':
> >> sh_mobile_lcdcfb.c:(.text+0x79616): undefined reference to
> `sh_mobile_meram_cache_free'

The lcdc driver can be compiled without meram support. This is handled by 
conditional compilation in include/video/sh_mobile_meram.h that defines the 
meram functions as stubs when meram support isn't selected.

The problem comes from the combination of FB_SH_MOBILE_MERAM=m and 
FB_SH_MOBILE_LCDC=y. The former makes the meram function non-stubs, while the 
later makes the LCDC driver fail to link, as meram support is then compiled as 
a module.

How do you usually handle this ?

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140119/329d9343/attachment.sig>
