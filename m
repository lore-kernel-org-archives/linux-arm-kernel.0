From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 14 Jun 2012 13:18:02 +0800
Subject: MMC: commit dba3c29 ruins mmc card data on beagle-xm revB
In-Reply-To: <CANrkHUaxJGcv2bdUWTCB_oKct-iFCKCdb7OQPTUjS4MuKeCS2w@mail.gmail.com>
References: <CACVXFVO-Wm1Qwporby1M=+yPz81AWHpZRBZSbr5tgT32b6sSEA@mail.gmail.com>
 <CANrkHUYd8Ww6De4MiZ8_oPfcnhvtsZXOySLRiWSBU4QUQ6beHw@mail.gmail.com>
 <CACVXFVP16UmHe-GGydrSMgGHwnkSvYhnY339=zr=BfCehvS8Kw@mail.gmail.com>
 <CANrkHUaxJGcv2bdUWTCB_oKct-iFCKCdb7OQPTUjS4MuKeCS2w@mail.gmail.com>
Message-ID: <CACVXFVOofn0GjH3WyxKbVgt00zv2ic257yJhSSmbQ7sj8N3WmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 1:26 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> Ming,
> ?Just to keep you posted, Balaji and myself are trying to reproduce
> the issue and haven't hit the problem yet.
> This patch was in use internaly for sometime before we sent it upstream.
> Meanwhile, is is possible for you to reproduce this problem with
> MMC_DEBUG enabled ? That would be helpful.

See attachment.

On Wed, Jun 13, 2012 at 11:28 PM, T Krishnamoorthy, Balaji
> Hi,
>
> Couldn't reproduce the issue with BeagleXM rev C, Might be a combination

Maybe, the problem can't be observed on my beagle revC and Panda,
but can be observed on the beagle XM revB.

Also it is only triggered on my two 8GB kingston mmc cards(class 4).
Looks no such problem on another 4GB kingston mmc card(class 4).

> of rev and SD card. How often do you see mis-match in file content?
>
> Can you please try the inlined patch to get more info?

No any extra info got after applying your patch.

>
> ---
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 9a7a60a..77aabe6 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -60,6 +60,7 @@
> ?#define OMAP_HSMMC_STAT ? ? ? ? ? ? ? ?0x0130
> ?#define OMAP_HSMMC_IE ? ? ? ? ?0x0134
> ?#define OMAP_HSMMC_ISE ? ? ? ? 0x0138
> +#define OMAP_HSMMC_AC12 ? ? ? ? ? ? ? ?0x013C
> ?#define OMAP_HSMMC_CAPA ? ? ? ? ? ? ? ?0x0140
>
> ?#define VS18 ? ? ? ? ? ? ? ? ? (1 << 26)
> @@ -177,6 +178,7 @@ struct omap_hsmmc_host {
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? reqs_blocked;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? use_reg;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? req_in_progress;
> + ? ? ? int ? ? ? ? ? ? ? ? ? ? autocmd_err;
> ? ? ? ?unsigned int ? ? ? ? ? ?flags;
> ? ? ? ?struct omap_hsmmc_next ?next_data;
>
> @@ -983,6 +985,7 @@ static void omap_hsmmc_do_irq(struct
> omap_hsmmc_host *host, int status)
> ?{
> ? ? ? ?struct mmc_data *data;
> ? ? ? ?int end_cmd = 0, end_trans = 0;
> + ? ? ? u32 autocmd12;
>
> ? ? ? ?if (!host->req_in_progress) {
> ? ? ? ? ? ? ? ?do {
> @@ -998,6 +1001,13 @@ static void omap_hsmmc_do_irq(struct
> omap_hsmmc_host *host, int status)
>
> ? ? ? ?if (status & ERR) {
> ? ? ? ? ? ? ? ?omap_hsmmc_dbg_report_irq(host, status);
> + ? ? ? ? ? ? ? if (status & (1 << 24)) {
> + ? ? ? ? ? ? ? ? ? ? ? host->autocmd_err = 1;
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(mmc_dev(host->mmc), "AutoCMD error STAT 0x%x\n", status);
> + ? ? ? ? ? ? ? ? ? ? ? autocmd12 = OMAP_HSMMC_READ(host->base, AC12);
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(mmc_dev(host->mmc), "AutoCMD error 0x%x\n", autocmd12);
> + ? ? ? ? ? ? ? }
> +
> ? ? ? ? ? ? ? ?if ((status & CMD_TIMEOUT) ||
> ? ? ? ? ? ? ? ? ? ? ? ?(status & CMD_CRC)) {
> ? ? ? ? ? ? ? ? ? ? ? ?if (host->cmd) {
> ---
>>

Thanks,
--
Ming Lei
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mmc-ruin.tar.gz
Type: application/x-gzip
Size: 117172 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/306f9199/attachment-0001.gz>
