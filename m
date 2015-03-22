From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 22 Mar 2015 15:42:14 -0700
Subject: [PATCH v3] input: Add support for ChipOne icn8318 based
 touchscreens
In-Reply-To: <550EA0E7.30608@redhat.com>
References: <1426007133-9606-1-git-send-email-hdegoede@redhat.com>
 <20150322040305.GA40622@dtor-ws> <550EA0E7.30608@redhat.com>
Message-ID: <20150322224214.GA9792@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 22, 2015 at 12:00:55PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 22-03-15 05:03, Dmitry Torokhov wrote:
> >Hi Hans,
> >
> >On Tue, Mar 10, 2015 at 06:05:33PM +0100, Hans de Goede wrote:
> >>+	error = devm_request_threaded_irq(dev, client->irq, NULL, icn8318_irq,
> >>+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >
> >Shouldn't we let DT data tell us what trigger to use? I.e. just leave
> >IRQF_ONESHOT here?
> 
> That is an interesting question, that new data is available is signalled by
> the irq pin of the chip going low is a property of the chip, not the board
> layout, so I believe it is best to leave this as is.

My concern is that even if pin behavior is property of chip maybe on
some boards we want to use level-triggered interrupts instead of edge?
And if we indeed want to hard-code the trigger then shouldn't the
binding document use onecell mapping (so that users do not attempt to
configure triggers from DT)?

> 
> Also note that if we want to get this from devicetree, that simply leaving out the
> flag is not enough, we must specifically get the data from devicetree and pass
> it into request_irq AFAICT. So the above would change to:
> 
> 	irqflags = irqd_get_trigger_type(irq_get_irq_data(client->irq)) | IRQF_ONESHOT,
> 	error = devm_request_threaded_irq(dev, client->irq, NULL, icn8318_irq, irqflags,

No, of_irq_get() that i2c core calls before probing driver should
already set the trigger type for us. There is no need for the individual
drivers to do that.

Thanks.

-- 
Dmitry
