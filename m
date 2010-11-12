From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 12 Nov 2010 08:17:06 +0100
Subject: Patch IMX audmux debugfs.
In-Reply-To: <BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
Message-ID: <20101112071706.GF6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 11, 2010 at 11:38:48AM -0500, Bill Pringlemeir wrote:
> On 10 Nov 2010, s.hauer at pengutronix.de wrote:
> 
> > On Tue, Nov 09, 2010 at 06:11:12PM -0500, Bill Pringlemeir wrote:
> 
> >> $ mount -t debugfs debugfs /sys/kernel/debug
> >> $ cd /sys/kernel/debug/audmux
> >> $ cat *
> >> [crashes when accessing ssi7]
> 
> >> The index is one based, but the register map is zero based.  So the
> >> ssi1 is actually sending info for ssi2.  Also, the ssi7 touches
> >> non-existent data and can cause an exception (only registers sets 1-6
> >> exist).
> 
> > I prefer passing (void *)(i - 1) here and skipping the first hunk.
> > Please add your Signed-off-by next time you send a patch.
> 
> Something similar occured in to me after reading Sergei message.  This
> patch treats i as the port instead of the file name.  The file name is
> generated from audmux_port_string making the filenames and file
> content the same.

Ok, looks sensible to me. I added Mark Brown to Cc as he added the
debugfs support in the first place. Maybe he has some comment to add.

Sascha

> 
> Signed-off-by: Bill Pringlemeir <bpringle@sympatico.ca>
> diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
> index f9e7cdb..ac30fdc 100644
> --- a/arch/arm/plat-mxc/audmux-v2.c
> +++ b/arch/arm/plat-mxc/audmux-v2.c
> @@ -142,7 +142,6 @@ static const struct file_operations audmux_debugfs_fops = {
>  static void audmux_debugfs_init(void)
>  {
>         int i;
> -       char buf[20];
>  
>         audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
>         if (!audmux_debugfs_root) {
> @@ -150,9 +149,9 @@ static void audmux_debugfs_init(void)
>                 return;
>         }
>  
> -       for (i = 1; i < 8; i++) {
> -               snprintf(buf, sizeof(buf), "ssi%d", i);
> -               if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
> +       for (i = 0; i < 6; i++) {
> +               if (!debugfs_create_file(audmux_port_string(i), 0444,
> +                                        audmux_debugfs_root,
>                                          (void *)i, &audmux_debugfs_fops))
>                         pr_warning("Failed to create AUDMUX port %d debugfs file\n",
>                                    i);
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
