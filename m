From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 5 May 2015 07:48:31 +0530
Subject: [PATCH 2/3 v7] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <5542ECA3.8060104@wwwdotorg.org>
References: <1430254460-26754-1-git-send-email-eric@anholt.net>
 <1430327374-6562-1-git-send-email-eric@anholt.net>
 <CABb+yY0+Dd6RMJfmcqWrJfsSkPS8KjtpctJteoTZrj3QttJ71g@mail.gmail.com>
 <5542ECA3.8060104@wwwdotorg.org>
Message-ID: <CABb+yY2M-JLNrgtn+_Ti1F1S89BmV7ZuMpXuRCgUr0wf6E_V3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 1, 2015 at 8:31 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/29/2015 11:26 PM, Jassi Brar wrote:
>> On Wed, Apr 29, 2015 at 10:39 PM, Eric Anholt <eric@anholt.net> wrote:
>>
>>> +
>>> +struct bcm2835_mbox {
>>> +       struct device *dev;
>>> +       void __iomem *regs;
>>> +       spinlock_t lock;
>>> +       struct mbox_controller controller;
>>> +};
>>> +
>>> +static struct bcm2835_mbox *mbox;
>>> +
>>> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
>>> +{
>>> +       struct device *dev = mbox->dev;
>>> +       struct mbox_chan *link = &mbox->controller.chans[0];
>>> +
>> I learn from Stephen's other post that the controller could have
>> multiple channels. In which case this driver is poorly setup. Actually
>> if the driver was designed properly there isn't anything special to be
>> done.
>>  Here you choose to waste 'dev_id' and hard-code dereferencing to channel-0
>
> Now that I look a bit harder at the registers, I think there are 2
> mailbox register sets, but each is uni-directional, so a pair makes up
> the typical bi-directional mailbox. There are multiple "owner" areas (or
> sets of registers); I'm not quite sure what that implies.
>
Probably a mailbox is the send-recv pair, and the controller could
have many such pairs.

> As such, limiting this driver to a single mailbox is probably correct.
>
OK

> I would expect to see #mbox-cells=<0> in the DT, which would require a
> custom of_xlate though (or modifying the default to work with a 0 cell
> count; IIRC the default of_xlate for some other subsystems will work in
> that scenario).
>
Yeah the api could simply return the first free channel for 0-cell spec.
