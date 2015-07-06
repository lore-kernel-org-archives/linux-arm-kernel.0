From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 6 Jul 2015 18:36:03 +0200
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <201507061820.35789@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <CAL_Jsq+ysDqxTgfW1JvG5czHa4UkZQDv1BN63iK4jvV9kDXM8w@mail.gmail.com>
 <201507061820.35789@pali>
Message-ID: <201507061836.03293@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 July 2015 18:20:35 Pali Roh?r wrote:
> > > "/chosen/linux,atags"
> > 
> > This one. ATAGs are a Linux data struct.
> > 
> > Rob
> 
> Ok, and how read that property "/chosen/linux,atags" in function
> setup_machine_fdt() from file arch/arm/kernel/devtree.c ?
> 
> of_get_flat_dt_prop() cannot be used unless somebody get me offset to
> node "/chosen"...
> 
> Any idea?
> 

fdt_path_offset() from libfdt.h seems to work...

Is solution like this one acceptable?

#include <linux/libfdt.h>
#include "atags.h"

... setup_machine_fdt(unsigned int dt_phys) {

dt_virt = phys_to_virt(dt_phys);
dt_chosen = fdt_path_offset(dt_virt, "/chosen");
atags = of_get_flat_dt_prop(dt_chosen, "linux,atags", NULL);
save_atags(atags);

}

(this is without checks for errors)

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/320d18e1/attachment.sig>
