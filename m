From: dianders@chromium.org (Doug Anderson)
Date: Mon, 28 Nov 2016 10:02:03 -0800
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
 <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
 <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
 <66751ab5-59a4-ec30-07cd-44ca03694723@laposte.net>
 <d1801c1e-cd74-b79c-0280-8fb5dc377c91@intel.com>
 <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
Message-ID: <CAD=FV=UhVtQQ1PPtLrvra20ja1k9GKs9hyFcrjBUYmyUmQK45Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 28, 2016 at 5:28 AM, Sebastian Frias <sf84@laposte.net> wrote:
> +static void sdhci_tango4_platform_init(struct sdhci_host *host)
> +{
> +       printk("%s\n", __func__);
> +
> +       /*
> +         pad_mode[2:0]=0    must be 0
> +         sel_sdio[3]=1      must be 1 for SDIO
> +         inv_sdwp_pol[4]=0  if set inverts the SD write protect polarity
> +         inv_sdcd_pol[5]=0  if set inverts the SD card present polarity
> +       */
> +       sdhci_writel(host, 0x00000008, 0x100 + 0x0);

If I were doing this, I'd probably actually add these fields to the
"sdhci_arasan_soc_ctl_map", then add a 3rd option to
sdhci_arasan_syscon_write().  Right now it has 2 modes: "hiword
update" and "non-hiword update".  You could add a 3rd indicating that
you set config registers by just writing at some offset of the main
SDHCI registers space.

So you'd add 4 fields:

.tango_pad_mode = { .reg = 0x0000, .width = 3, .shift = 0 },
.sel_sdio = { .reg = 0x0000, .width = 1, .shift = 3},
.inv_sdwp_pol = { .reg = 0x0000, .width = 1, .shift = 4},
.inv_sdcd_pol = { .reg = 0x0000, .width = 1, .shift = 5},

In your platform-specific init you're proposing you could set
tango_pad_mode to 0.  That seems tango-specific.

You'd want to hook into "set_ios" for setting sel_sdio or not.  That's
important if anyone ever wants to plug in an external SDIO card to
your slot.  This one good argument for putting this in
sdhci_arasan_soc_ctl_map, since you wouldn't want to do a
compatibility matching every time set_ios is called.

I'd have to look more into the whole SD/WP polarity issue.  There are
already so many levels of inversion for these signals in Linux that
it's confusing.  It seems like you might just want to hardcode them to
"0" and let users use all the existing ways to invert things...  You
could either put that hardcoding into your platform init code or (if
you're using sdhci_arasan_soc_ctl_map) put it in the main init code so
that if anyone else needs to init similar signals then they can take
advantage of it.

--

One random side note is that as currently documented you need to
specify a "shift" of -1 for any sdhci_arasan_soc_ctl_map fields you
aren't using.  That seems stupid--not sure why I did that.  It seems
better to clue off "width = 0" so that you could just freely not init
any fields you don't need.

-Doug
