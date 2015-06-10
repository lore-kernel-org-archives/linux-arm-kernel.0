From: carlo@endlessm.com (Carlo Caione)
Date: Wed, 10 Jun 2015 10:30:24 +0200
Subject: [PATCH] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
In-Reply-To: <CAD8Lp45c1GS=xYU3=6g1sdrP_afy7r=TgqL--FKjWbbwL=cReA@mail.gmail.com>
References: <1433783342-31243-1-git-send-email-carlo@caione.org>
 <CAD8Lp45c1GS=xYU3=6g1sdrP_afy7r=TgqL--FKjWbbwL=cReA@mail.gmail.com>
Message-ID: <CAL9uMOESJjJwZq2S2vd7h8Acg+VHQ2CJKow0_bma2HPCdc4-oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 1:15 AM, Daniel Drake <drake@endlessm.com> wrote:
> Hi Carlo,

Hey Daniel,

> On Mon, Jun 8, 2015 at 11:09 AM, Carlo Caione <carlo@caione.org> wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Add a driver for the SD/MMC host found on the Amlogic MesonX SoCs. It
>> is an MMC controller which provides an interface between the
>> application processor and various memory cards. It supports the SD
>> specification v2.0 and the eMMC specification v4.41. It also supports
>> SDSC, SDHC and SDXC memory card default speed.
>
> Nice work, thanks for this!
>
>> This patch adds also the bindinding documentation.
>
> "binding" typo

ops

>> +static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>> +{
>> +       struct meson_mmc_host *host = mmc_priv(mmc);
>> +       struct mmc_command *cmd = mrq->cmd;
>> +       struct mmc_data *data = mrq->data;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +
>> +       if (host->state != STATE_IDLE) {
>> +               dev_dbg(mmc_dev(mmc), "%s() rejected, state %u\n",
>> +                       __func__, host->state);
>> +               mrq->cmd->error = -EAGAIN;
>> +               spin_unlock_irqrestore(&host->lock, flags);
>> +               mmc_request_done(mmc, mrq);
>> +               return;
>> +       }
>> +
>> +       if (host->ferror) {
>> +               cmd->error = host->ferror;
>> +               spin_unlock_irqrestore(&host->lock, flags);
>> +               mmc_request_done(mmc, mrq);
>> +               return;
>> +       }
>> +
>> +       dev_dbg(mmc_dev(mmc), "CMD%d(%08x) arg %x len %d flags %08x\n",
>> +               cmd->opcode & 0x3f, cmd->opcode, cmd->arg,
>> +               mrq->data ? mrq->data->blksz * mrq->data->blocks : 0,
>> +               mrq->cmd->flags);
>> +
>> +       /* Filter out CMD 5/52/53 */
>> +       if (cmd->opcode == SD_IO_SEND_OP_COND ||
>> +           cmd->opcode == SD_IO_RW_DIRECT ||
>> +           cmd->opcode == SD_IO_RW_EXTENDED) {
>> +               dev_dbg(mmc_dev(host->mmc), "CMD%d not supported\n", cmd->opcode);
>> +               cmd->error = -EINVAL;
>> +               spin_unlock_irqrestore(&host->lock, flags);
>> +               mmc_request_done(mmc, mrq);
>> +               return;
>> +       }
>> +
>> +       host->state = STATE_REQUEST;
>> +
>> +       if (data) {
>> +               meson_mmc_map_dma(host, data, data->flags);
>> +               writel(host->sg_dma, host->base + SDIO_ADDR);
>
> As the sg_dma buffer is constant, can you do this register write just
> once at probe time? I wonder if we really need to do it on each
> request.

Unfortunately it doesn't work. It is not documented but I guess that
writing to that register triggers the DMA transfer and the register is
zeroed afterwards.

> Or, going deeper, I wonder if we can avoid this bounce buffer
> entirely. Can you try setting mmc->max_segs to 1 then passing the
> single data segment directly to the hardware with
>    writel(sg_dma_address(data->sg), host->base + SDIO_ADDR)
>
> If that turns out to be more complicated then it sounds, then feel
> free to push it off to a later driver revision.

Yup. I'll fix it in v2 putting in CC linux-mmc.

Thanks,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
