From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 30 Apr 2015 21:01:55 -0600
Subject: [PATCH 2/3 v7] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <CABb+yY0+Dd6RMJfmcqWrJfsSkPS8KjtpctJteoTZrj3QttJ71g@mail.gmail.com>
References: <1430254460-26754-1-git-send-email-eric@anholt.net>	<1430327374-6562-1-git-send-email-eric@anholt.net>
 <CABb+yY0+Dd6RMJfmcqWrJfsSkPS8KjtpctJteoTZrj3QttJ71g@mail.gmail.com>
Message-ID: <5542ECA3.8060104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2015 11:26 PM, Jassi Brar wrote:
> On Wed, Apr 29, 2015 at 10:39 PM, Eric Anholt <eric@anholt.net> wrote:
> 
>> +
>> +struct bcm2835_mbox {
>> +       struct device *dev;
>> +       void __iomem *regs;
>> +       spinlock_t lock;
>> +       struct mbox_controller controller;
>> +};
>> +
>> +static struct bcm2835_mbox *mbox;
>> +
>> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
>> +{
>> +       struct device *dev = mbox->dev;
>> +       struct mbox_chan *link = &mbox->controller.chans[0];
>> +
> I learn from Stephen's other post that the controller could have
> multiple channels. In which case this driver is poorly setup. Actually
> if the driver was designed properly there isn't anything special to be
> done.
>  Here you choose to waste 'dev_id' and hard-code dereferencing to channel-0

Now that I look a bit harder at the registers, I think there are 2
mailbox register sets, but each is uni-directional, so a pair makes up
the typical bi-directional mailbox. There are multiple "owner" areas (or
sets of registers); I'm not quite sure what that implies.

As such, limiting this driver to a single mailbox is probably correct.

I would expect to see #mbox-cells=<0> in the DT, which would require a
custom of_xlate though (or modifying the default to work with a 0 cell
count; IIRC the default of_xlate for some other subsystems will work in
that scenario).

(As an aside, if we ever did find the need to expand the driver to cover
more mailboxes in the future, extending it and the DT to support
#mbox-cells=<0> or #mbox-cells=<1> at run-time should be trivial).
