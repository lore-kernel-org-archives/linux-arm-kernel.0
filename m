From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 13 Aug 2015 15:31:36 +0530
Subject: [PATCH v2 5/6] mailbox: Add generic mechanism for testing Mailbox
 Controllers
In-Reply-To: <20150813091914.GB8782@x1>
References: <1437990272-23111-1-git-send-email-lee.jones@linaro.org>
 <1437990272-23111-6-git-send-email-lee.jones@linaro.org>
 <CABb+yY20nQbiEEZeRvWTMUsJ2qgwRn8CrWvnFDSB-b1dgVaAuw@mail.gmail.com>
 <20150812102328.GD18282@x1>
 <CABb+yY0A74Vy3-KOvj0URU_4zb2FAC7Yp3gmEwnFaBrD0mzt0w@mail.gmail.com>
 <20150813091914.GB8782@x1>
Message-ID: <CABb+yY0cgbtM68-E_Xqgh5O6GRLXESYTLa5WcAwUBoVL3ufrxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 2:49 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 13 Aug 2015, Jassi Brar wrote:

>> >> > +
>> >> > +static void mbox_test_prepare_message(struct mbox_client *client, void *message)
>> >> > +{
>> >> > +       struct mbox_test_device *tdev = dev_get_drvdata(client->dev);
>> >> > +
>> >> > +       if (tdev->mmio)
>> >> > +               memcpy(tdev->mmio, message, MBOX_MAX_MSG_LEN);
>> >> >
>> >> This is unlikely to work. Those platforms that need to send a 2 part
>> >> message, they do :
>> >> (a) Signal/Command/Target code via some controller register (via
>> >> mbox_send_message).
>> >> (b) Setup the payload in Shared-Memory (via tx_prepare).
>> >>
>> >> This test driver assumes both are the same. I think you have to
>> >> declare something like
>> >
>> > This driver assumes that the framework will call client->tx_prepare()
>> > first, which satisfies (b).  It then assumes controller->send_data()
>> > will be invoked, which will send the platform specific
>> > signal/command/target code, which then satisfies (a).
>> >
>> Yeah, but what would be that code? Who provides that?
>>
>> > In what way does it assume they are the same?
>> >
>> notice the 'message' pointer in
>> mbox_send_message(tdev->tx_channel, message);
>>     and
>> memcpy(tdev->mmio, message, MBOX_MAX_MSG_LEN);
>>
>> >> struct mbox_test_message { /* same for TX and RX */
>> >>           unsigned sig_len;
>> >>           void *signal;               /* rx/tx via mailbox api */
>> >>           unsigned pl_len;
>> >>           void *payload;           /* rx/tx via shared-memory */
>> >> };
>> >
>> > How do you think this should be set and use these?
>> >
>> The userspace would want to specify the command code (32bits or not)
>> that would be passed via the fifo/register of the controller. So we
>> need signal[]
>>
>> The data to be passed via share-memory could be provided by userspace
>> via the payload[] array.
>
> Okay, so would the solution be two userspace files 'signal' and
> 'message', so in the case of a client specified signal we can write it
> into there first.
>
> echo 255  > signal
> echo test > message
>
> ... or in the case where no signal is required, or the controller
> driver taking care of it, we just don't write anything to signal?
>
file_operations.write() should parse signal and message, coming from
userspace, into a local structure before routing them via
mbox_send_message and tx_prepare respectively.

> Just for clarification, in the case where a signal is required, do
> clients usually pass that through mbox_send_message() too?
>
>   mbox_send_message(tdev->tx_channel, signal);
>   mbox_send_message(tdev->tx_channel, message);
>
No. Command/Signal code is passed via mbox_send_message(signal). The
payload is passed via Shared-Memory during tx_prepare(message)


>> >> > +static void mbox_test_message_sent(struct mbox_client *client,
>> >> > +                                  void *message, int r)
>> >> > +{
>> >> > +       if (r)
>> >> > +               dev_warn(client->dev,
>> >> > +                        "Client: Message could not be sent: %d\n", r);
>> >> > +       else
>> >> > +               dev_info(client->dev,
>> >> > +                        "Client: Message sent\n");
>> >> > +}
>> >> > +
>> >> > +static struct mbox_chan *
>> >> > +mbox_test_request_channel(struct platform_device *pdev, const char *name)
>> >> > +{
>> >> > +       struct mbox_client *client;
>> >> > +
>> >> > +       client = devm_kzalloc(&pdev->dev, sizeof(*client), GFP_KERNEL);
>> >> > +       if (!client)
>> >> > +               return ERR_PTR(-ENOMEM);
>> >> > +
>> >> > +       client->dev             = &pdev->dev;
>> >> > +       client->rx_callback     = mbox_test_receive_message;
>> >> > +       client->tx_prepare      = mbox_test_prepare_message;
>> >> > +       client->tx_done         = mbox_test_message_sent;
>> >> > +       client->tx_block        = true;
>> >> > +       client->knows_txdone    = false;
>> >> > +       client->tx_tout         = 500;
>> >> > +
>> >> > +       return mbox_request_channel_byname(client, name);
>> >> > +}
>> >> > +
>> >> > +static int mbox_test_probe(struct platform_device *pdev)
>> >> > +{
>> >> > +       struct mbox_test_device *tdev;
>> >> > +       struct resource *res;
>> >> > +       int ret;
>> >> > +
>> >> > +       tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev), GFP_KERNEL);
>> >> > +       if (!tdev)
>> >> > +               return -ENOMEM;
>> >> > +
>> >> > +       /* It's okay for MMIO to be NULL */
>> >> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >> > +       tdev->mmio = devm_ioremap_resource(&pdev->dev, res);
>> >> > +       if (IS_ERR(tdev->mmio))
>> >> > +               tdev->mmio = NULL;
>> >> > +
>> >> > +       tdev->tx_channel = mbox_test_request_channel(pdev, "tx");
>> >> > +       if (IS_ERR(tdev->tx_channel))
>> >> > +               return PTR_ERR(tdev->tx_channel);
>> >> > +
>> >> > +       tdev->rx_channel = mbox_test_request_channel(pdev, "rx");
>> >> > +       if (IS_ERR(tdev->rx_channel))
>> >> > +               return PTR_ERR(tdev->rx_channel);
>> >> > +
>> >> Should it really fail on TX or RX only clients?
>> >
>> > Good question.  Probably not, but I guess we'd need a flag for that.
>> >
>> Just assume 1 channel. You can't make it receive if the controller
>> can't do rx, so the userspace will simply block on read requests. And
>> you can't make the controller send, if it can't. So any write attempt
>> will simply return with an error.
>>  And we are going to need very platform specific knowledge to execute
>> the tests. It's not like some loop enumerating all possible
>> combinations of parameters that the api must pass... so we are good.
>
> I'm guessing most tests will be some kind of send-reply test, so we'd
> need two channels for that.  I can make it so the driver does not fail
> if 'tx' or 'rx' is missing, but will fail if both are.
>
I have seen more channels to be rx+tx, than rx/tx only. And for latter
case the user should run 2 test threads, one each for RX and TX.

> Bare in mind that this test driver isn't designed to cover all of the
> corner cases, but more designed as a helpful boiler plate where it
> will tick some use-case boxes, but is clear enough to be hacked around
> by other vendors who have different requirements.
>
> With regards to you comments on userspace; I suggest that whoever is
> testing the controller will know it and will not attempt to check for
> a reply from a controller (or co-proc) which is write-only.
>
That's actually my point :)
When the userspace already has all that platform specific knowledge,
why check for 'valid' usage in controller driver? Simply reject any
request that the controller isn't capable of (which is practically
never supposed to happen).

Thanks.
