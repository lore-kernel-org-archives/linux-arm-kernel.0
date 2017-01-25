From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Wed, 25 Jan 2017 10:08:34 +0000
Subject: [PATCH] media: platform: constify vb2_ops structures
In-Reply-To: <1484990984-16136-1-git-send-email-bhumirks@gmail.com>
References: <1484990984-16136-1-git-send-email-bhumirks@gmail.com>
Message-ID: <CA+V-a8scvMreQDdftDsP3B75ENSMu+OaUM0tUD-c1NPSZnznDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the patch.

On Sat, Jan 21, 2017 at 9:29 AM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> Declare vb2_ops structures as const as they are only stored in
> the ops field of a vb2_queue structure. This field is of type
> const, so vb2_ops structures having same properties can be made
> const too.
> Done using Coccinelle:
>
> @r1 disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct vb2_ops i at p={...};
>
> @ok1@
> identifier r1.i;
> position p;
> struct sta2x11_vip vip;
> struct vb2_queue q;
> @@
> (
> vip.vb_vidq.ops=&i at p
> |
> q.ops=&i at p
> )
>
> @bad@
> position p!={r1.p,ok1.p};
> identifier r1.i;
> @@
> i at p
>
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct vb2_ops i;
>
> Cross compiled the media/platform/blackfin/bfin_capture.o file for
> blackfin architecture.
>
> File size before:
>   text     data     bss     dec     hex filename
>   6776      176       0    6952    1b28 platform/blackfin/bfin_capture.o
>
The description doesnt match the changes. Can you please split the
patches separately one for vpif_capture.c and vpif_display.c,
one for mtk_mdp_m2m.c and lastly for pxa_camera.c .


Cheers,
--Prabhakar Lad
