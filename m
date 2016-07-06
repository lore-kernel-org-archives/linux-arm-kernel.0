From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 6 Jul 2016 10:50:59 -0600
Subject: [PATCH V2 02/10] mailbox: tegra-hsp: Add HSP(Hardware
 Synchronization Primitives) driver
In-Reply-To: <577CCA0A.4000203@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-3-josephl@nvidia.com>
 <CAAVeFuK1nY2M3vU9j-D5TJwZCEj+sXRDy=W4XMTqSdsveTTQww@mail.gmail.com>
 <577CCA0A.4000203@nvidia.com>
Message-ID: <577D36F3.9010806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 03:06 AM, Joseph Lo wrote:
> On 07/06/2016 03:05 PM, Alexandre Courbot wrote:
>> On Tue, Jul 5, 2016 at 6:04 PM, Joseph Lo <josephl@nvidia.com> wrote:
>>> The Tegra HSP mailbox driver implements the signaling doorbell-based
>>> interprocessor communication (IPC) for remote processors currently. The
>>> HSP HW modules support some different features for that, which are
>>> shared mailboxes, shared semaphores, arbitrated semaphores, and
>>> doorbells. And there are multiple HSP HW instances on the chip. So the
>>> driver is extendable to support more features for different IPC
>>> requirement.
>>>
>>> The driver of remote processor can use it as a mailbox client and deal
>>> with the IPC protocol to synchronize the data communications.

>>> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c

>>> +static irqreturn_t hsp_db_irq(int irq, void *p)
>>> +{
>>> +       struct tegra_hsp_mbox *hsp_mbox = p;
>>> +       ulong val;
>>> +       int master_id;
>>> +
>>> +       val = (ulong)hsp_readl(hsp_mbox->db_base[HSP_DB_CCPLEX],
>>> +                              HSP_DB_REG_PENDING);
>>> +       hsp_writel(hsp_mbox->db_base[HSP_DB_CCPLEX],
>>> HSP_DB_REG_PENDING, val);
>>> +
>>> +       spin_lock(&hsp_mbox->lock);
>>> +       for_each_set_bit(master_id, &val, MAX_NUM_HSP_CHAN) {
>>> +               struct mbox_chan *chan;
>>> +               struct tegra_hsp_mbox_chan *mchan;
>>> +               int i;
>>> +
>>> +               for (i = 0; i < MAX_NUM_HSP_CHAN; i++) {
>>
>> I wonder if this could not be optimized. You are doing a double loop
>> on MAX_NUM_HSP_CHAN to look for an identical master_id. Since it seems
>> like the same master_id cannot be used twice (considering that the
>> inner loop only processes the first match), couldn't you just select
>> the free channel in of_hsp_mbox_xlate() by doing
>> &mbox->chans[master_id] (and returning an error if it is already
>> used), then simply getting chan as &hsp_mbox->mbox->chans[master_id]
>> instead of having the inner loop below? That would remove the need for
>> the second loop.
>
> That was exactly what I did in the V1, which only supported one HSP
> sub-module per HSP HW block. So we can just use the master_id as the
> mbox channel ID.
>
> Meanwhile, the V2 is purposed to support multiple HSP sub-modules to be
> running on the same HSP HW block. The "ID" between different modules
> could be conflict. So I dropped the mechanism that used the master_id as
> the mbox channel ID.

I haven't looked at the code in this patch since I'm mainly concerned 
about the DT bindings. However, I will say that nothing in the change to 
the mailbox specifier in DT should have required /any/ changes to the 
code, except to add a single check to validate that the "mailbox type" 
encoded into the top 16 bits of the mailbox ID were 0, and hence 
represented a doorbell rather than anything else. Any enhancements to 
support other mailbox types could have happened later, and I doubt would 
require anything dynamic even then.

>>> +static int tegra_hsp_db_init(struct tegra_hsp_mbox *hsp_mbox,
>>> +                            struct mbox_chan *mchan, int master_id)
>>> +{
>>> +       struct platform_device *pdev = to_platform_device(hsp_mbox->mbox->dev);
>>> +       struct tegra_hsp_mbox_chan *hsp_mbox_chan;
>>> +       int ret;
>>> +
>>> +       if (!hsp_mbox->db_irq) {
>>> +               int i;
>>> +
>>> +               hsp_mbox->db_irq = platform_get_irq_byname(pdev, "doorbell");
>>
>> Getting the IRQ sounds more like a job for probe() - I don't see the
>> benefit of lazy-doing it?
>
> We only need the IRQ when the client is requesting the DB service. For
> other HSP sub-modules, they are using different IRQ. So I didn't do that
> at probe time.

All resources provided by other devices/drivers must be acquired at 
probe time, since that's the only time it's possible to defer probe if 
the provider of the resource is not available.

If you don't follow that rule, what happens is:

1) This driver probes.

2) Some other driver calls tegra_hsp_db_init(), and it fails since the 
provider of the IRQ is not yet available. This likely ends up returning 
something other than -EPROBE_DEFER since the HSP driver was found 
successfully (thus there is no deferred probe situation as far as the 
mailbox core is concerned), it's just that the mailbox channel 
lookup/init/... failed.

3) The other driver's probe() fails due to this, but since the error 
wasn't a probe deferral, the other driver's probe() is never retried.
