From: punnaia@xilinx.com (punnaiah choudary kalluri)
Date: Fri, 17 Jul 2015 09:54:48 +0530
Subject: [PATCH v3 2/2] dma: Add Xilinx zynqmp dma engine driver support
In-Reply-To: <20150717030545.GB5086@localhost>
References: <CAHLkNH+VLccurDfxEnwSEbr9YFv8ymZuibci7TW=WPutL7qbAQ@mail.gmail.com>
 <CAGnW=BbUBOzm5V_LP_YcCfJ9X+Yw8qGp6PE2xSM13E=qUXxUsw@mail.gmail.com>
 <20150717030545.GB5086@localhost>
Message-ID: <CAGnW=BYbBnngujcMuEf3=jvra6DiBmN1xhM9DBPmXoa83xLSJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 8:35 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Fri, Jul 17, 2015 at 06:22:42AM +0530, punnaiah choudary kalluri wrote:
>> On Thu, Jul 16, 2015 at 6:05 PM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Tue, Jun 16, 2015 at 08:04:43AM +0530, Punnaiah Choudary Kalluri wrote:
>> >> +/* Register Offsets */
>> >> +#define ISR                          0x100
>> >> +#define IMR                          0x104
>> >> +#define IER                          0x108
>> >> +#define IDS                          0x10C
>> >> +#define CTRL0                                0x110
>> >> +#define CTRL1                                0x114
>> >> +#define STATUS                               0x11C
>> >> +#define DATA_ATTR                    0x120
>> >> +#define DSCR_ATTR                    0x124
>> >> +#define SRC_DSCR_WRD0                        0x128
>> >> +#define SRC_DSCR_WRD1                        0x12C
>> >> +#define SRC_DSCR_WRD2                        0x130
>> >> +#define SRC_DSCR_WRD3                        0x134
>> >> +#define DST_DSCR_WRD0                        0x138
>> >> +#define DST_DSCR_WRD1                        0x13C
>> >> +#define DST_DSCR_WRD2                        0x140
>> >> +#define DST_DSCR_WRD3                        0x144
>> >> +#define SRC_START_LSB                        0x158
>> >> +#define SRC_START_MSB                        0x15C
>> >> +#define DST_START_LSB                        0x160
>> >> +#define DST_START_MSB                        0x164
>> >> +#define TOTAL_BYTE                   0x188
>> >> +#define RATE_CTRL                    0x18C
>> >> +#define IRQ_SRC_ACCT                 0x190
>> >> +#define IRQ_DST_ACCT                 0x194
>> >> +#define CTRL2                                0x200
>> > Can you namespace these and other defines
>>
>> Ok. just to be clear, you want to me to prefix ZYNQMP_DMA?
>> or you want me to add comments ?
>> I have defined the exact register names as per the zynqmp dma
>> spec,
>
> former please
>
>> > Btw is ZYNQMP_DMA_NUM_DESCS sw or HW limit
>>
>> Sw limit.
> so why put the limit then?

Considering the performance,  i want to avoid runtime memory
allocation for each dma
request and want to use pre-allocated pool for each request. Since its
a pre-allocated
pool during the channel resource allocation, i need to limit the size
and one can change
this as per the requirement.

>
>> >> +static void zynqmp_dma_start_transfer(struct zynqmp_dma_chan *chan)
>> >> +{
>> >> +     struct zynqmp_dma_desc_sw *desc;
>> >> +
>> >> +     if (!zynqmp_dma_chan_is_idle(chan))
>> >> +             return;
>> >> +
>> >> +     desc = list_first_entry_or_null(&chan->pending_list,
>> >> +                                     struct zynqmp_dma_desc_sw, node);
>> >> +     if (!desc)
>> >> +             return;
>> >> +
>> >> +     if (chan->has_sg)
>> >> +             list_splice_tail_init(&chan->pending_list, &chan->active_list);
>> >> +     else
>> >> +             list_move_tail(&desc->node, &chan->active_list);
>> >> +
>> >> +     if (chan->has_sg)
>> >> +             zynqmp_dma_update_desc_to_ctrlr(chan, desc);
>> >> +     else
>> >> +             zynqmp_dma_config_simple_desc(chan, desc->src, desc->dst,
>> >> +                                           desc->len);
>> >> +     zynqmp_dma_start(chan);
>> >> +}
>> > Lots of the list management will get simplified if you use the vchan to do
>> > so
>>
>> I have explored using the virt-dma to reduce the common list processing, But
>> in this driver descriptor processing and cleaning is happening inside
>> the tasklet
>> context and virt-dma assumes it is happening in interrupt context and using the
>> spin locks accordingly. So, added code for the list management in side
>> the driver.
> And why would it bother you. There is a reson for that, it tries to submit
> next txn as soon as possible, which is the right thing

We have implemented hw descriptor queuing in tx_submit function, so
controller can
process descriptors with out interruption. We want to minimize
disabling all the interrupts
for the purpose of submitting new req or cleaning the descriptors.
Also if we adopt virt-dma, need to override the  tx_submit function
So, decided to go with
any one cleaner approach.

>
>> >> +/**
>> >> + * zynqmp_dma_chan_desc_cleanup - Cleanup the completed descriptors
>> >> + * @chan: ZynqMP DMA channel
>> >> + */
>> >> +static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
>> >> +{
>> >> +     struct zynqmp_dma_desc_sw *desc, *next;
>> >> +
>> >> +     list_for_each_entry_safe(desc, next, &chan->done_list, node) {
>> >> +             dma_async_tx_callback callback;
>> >> +             void *callback_param;
>> >> +
>> >> +             list_del(&desc->node);
>> >> +
>> >> +             callback = desc->async_tx.callback;
>> >> +             callback_param = desc->async_tx.callback_param;
>> >> +             if (callback)
>> >> +                     callback(callback_param);
>> >> +
>> > and you are calling the callback with lock held and user can do further
>> > submissions so this is wrong!
>>
>> is it that driver should have separate temp list and fill this list
>> with the descriptors in
>> done_list and process them with out lock held ?
>>
>> please suggest.
> Nope, you need to drop locks while invoking callback

Got it

>
>> >> +static struct dma_async_tx_descriptor *zynqmp_dma_prep_memcpy(
>> >> +                             struct dma_chan *dchan, dma_addr_t dma_dst,
>> >> +                             dma_addr_t dma_src, size_t len, ulong flags)
>> >> +{
>> >> +     struct zynqmp_dma_chan *chan;
>> >> +     struct zynqmp_dma_desc_sw *new, *first = NULL;
>> >> +     void *desc = NULL, *prev = NULL;
>> >> +     size_t copy;
>> >> +     u32 desc_cnt;
>> >> +
>> >> +     chan = to_chan(dchan);
>> >> +
>> >> +     if ((len > ZYNQMP_DMA_MAX_TRANS_LEN) && !chan->has_sg)
>> > why sg?
>>
>> Controller supports two types of modes.
>>
>> Simple dma mode:
>>    In this mode, DMA transfer parameters are specified in APB registers
>>    So, queuing the new request in hw is not possible when the channel
>> is busy with
>>    previous transfer and also it doesn't have SG support.
>>    Max transfer size per transfer is 1GB.
>>
>> Scatter gather dma mode:
>>    Transfer parameters are specified in the buffer descriptors (BD).
>>    Max transfer size per BD is 1GB and Dma transaction can have multiple BDs
>>
>> The above condition is to ensure that when the controller is
>> configured for Simple
>> Dma mode, allow the transfers that are with in 1GB size if not it return error.
> But then you can "queue" up in SW and switch from sg to simple mode and
> vice-versa right?

 It can be done. Idea is first to upstream basic version and add this kind of
features and support later.

>
>> >> +static int zynqmp_dma_remove(struct platform_device *pdev)
>> >> +{
>> >> +     struct zynqmp_dma_device *xdev = platform_get_drvdata(pdev);
>> >> +
>> >> +     of_dma_controller_free(pdev->dev.of_node);
>> >> +     dma_async_device_unregister(&xdev->common);
>> >> +
>> >> +     zynqmp_dma_chan_remove(xdev->chan);
>> > Please free up irq here explictly and also ensure tasklet is not running
>>
>> irq free is not required as cleaning will be taken care by the devm framework.
>> tasklet cleaning is happening inside the zynqmp_chan_remove function.
> Wrong on two counts
> - did you ensure tasklet would not be traoggered again after cleanup, i
>   think no
> - did you ensure irq will not be triggered again before you return remove, i
>   think no.
> devm_irq_free should be invoked explictly here to ensure this

Ok.

Regards,
Punnaiah

>
> --
> ~Vinod
>
