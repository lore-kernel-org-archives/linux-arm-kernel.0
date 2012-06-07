From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 7 Jun 2012 21:17:30 +0800
Subject: [alsa-devel] [PATCH v1 2/5] ASoC: mmp: add audio dma support
In-Reply-To: <1339068025.1927.66.camel@vkoul-udesk3>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-3-git-send-email-zhangfei.gao@marvell.com>
 <1339061042.1927.61.camel@vkoul-udesk3>
 <CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
 <1339063547.1927.63.camel@vkoul-udesk3>
 <CAMj5BkhtHaF=b=VDMoif_RxWR_Wdxc7qMpjH-SBO=yoA4W9LTA@mail.gmail.com>
 <1339068025.1927.66.camel@vkoul-udesk3>
Message-ID: <CAMj5BkhrxhvGEe3EinSQycb9aBo4rZriU7=Um9z=0mKyBz71HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 7:20 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Thu, 2012-06-07 at 18:44 +0800, zhangfei gao wrote:
>> Only exception is dmaengine_slave_config, since we have some specific config.
> And why?
>
>> +static bool filter(struct dma_chan *chan, void *param)
>> +{
>> + ? ? struct mmp_dma_data *dma_data = param;
>> + ? ? bool found = false;
>> + ? ? char *devname;
>> +
>> + ? ? devname = kasprintf(GFP_KERNEL, "%s.%d", dma_data->dma_res->name,
>> + ? ? ? ? ? ? dma_data->ssp_id);
>> + ? ? if ((strcmp(dev_name(chan->device->dev), devname) == 0) &&
>> + ? ? ? ? ? ? (chan->chan_id == dma_data->dma_res->start)) {
>> + ? ? ? ? ? ? chan->private = &dma_data->tdma_data;
> chan->private is deprecated and should not be used

Thanks for the info, will update accordingly.
The concern is DMA_SLAVE_BUSWIDTH_4_BYTES is used for S20, S24, S32.
And our controller handles differently, though they not seen much.

Besides, dmaengine_slave_config still have to be used for src/dst_addr
and src/dst_maxburst.

>> + ? ? ? ? ? ? found = true;
>> + ? ? }
>> +
>> + ? ? kfree(devname);
>> + ? ? return found;
>> +}
>
>
> --
> ~Vinod
>
