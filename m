From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 22 Feb 2010 17:35:43 +0100
Subject: [PATCH] jffs2: fix memory leak if the sector was successfully
	erased
In-Reply-To: <a9e22dff1002220826p63209a33n27e84ea10e191a19@mail.gmail.com>
References: <a9e22dff1002220826p63209a33n27e84ea10e191a19@mail.gmail.com>
Message-ID: <20100222163543.GL28972@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2010 at 06:26:22PM +0200, Ni at m wrote:
> Memory allocated for erase instruction is not freed if the sector was
> successfully erased.
> 
> Signed-off-by: Dmytro Milinevskyy <niam.niam@gmail.com>

Can you forward that to the right people please? Call
scripts/get_maintainer.pl to get a list of maintainers.

Daniel



> ---
>  fs/jffs2/erase.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
> index b47679b..c0a5604 100644
> --- a/fs/jffs2/erase.c
> +++ b/fs/jffs2/erase.c
> @@ -74,8 +74,10 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
>         ((struct erase_priv_struct *)instr->priv)->c = c;
> 
>         ret = c->mtd->erase(c->mtd, instr);
> -       if (!ret)
> +       if (!ret) {
> +        kfree(instr);
>                 return;
> +    }
> 
>         bad_offset = instr->fail_addr;
>         kfree(instr);
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
