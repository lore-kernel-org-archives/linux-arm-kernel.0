From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 9 Aug 2013 22:32:57 +0800
Subject: [PATCH 06/12] dma: mmp_pdma: make the controller a DMA provider
In-Reply-To: <5204EA60.4060502@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
 <1375870770-14263-7-git-send-email-zonque@gmail.com>
 <201308071812.15420.arnd@arndb.de> <5204EA60.4060502@gmail.com>
Message-ID: <CAMj5Bkj5PmvdOV307PSpXvTomJsad_7G91X-UFxYJ2KukcqX6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 9, 2013 at 9:10 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 07.08.2013 18:12, Arnd Bergmann wrote:
>> On Wednesday 07 August 2013, Daniel Mack wrote:
>>> +    if (op->dev.of_node) {
>>> +            mmp_pdma_info.dma_cap = pdev->device.cap_mask;
>>> +
>>> +            /* Device-tree DMA controller registration */
>>> +            ret = of_dma_controller_register(op->dev.of_node,
>>> +                                             of_dma_simple_xlate,
>>> +                                             &mmp_pdma_info);
>>
>> of_dma_simple_xlate can not be used if there is a chance that multiple instances
>> of the same dma engine, or multiple different DMA engines are present in the
>> system. I generally advise against using it.
>>
>> Please have a look at the changes that Zhangfei Gao proposed in
>> http://comments.gmane.org/gmane.linux.ports.arm.kernel/249077
>> and see if you can do the same here.
>
> I had another look at that and Zhangfei's case is not really applicable
> to mine, unfortunately.
>
> In his case, one specific out of many channels has to be used, depending
> on the first argument of the phandle. In my case though, the pdma
> controller may just take any of its channels, and just assign the
> correct DMA request to it.

Dear Daniel

Though any physical channel is workable, the virtual channel does not.
Each device has to set specific request line.

pdma.c
chan->drcmr = cfg->slave_id;
nand.c
  conf.slave_id = info->drcmr_dat;

The specific virtual channel can be directly specificied by request line.
While pdma.c choose the free physical channel inside, which is
transparent to client.

It should be same.

Thanks

>
> So if I provide a private xlate function, I need a way to obtain *any*
> of the channels in my instance. Open-coding that is not easily possible,
> as I need to hold the dmaengine's local dma_list_mutex for that.
>
> I have to dig deeper here, but if anyone has a hint, please let me know :)
>
>
> Daniel
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
