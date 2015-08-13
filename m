From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 13 Aug 2015 16:40:42 +0530
Subject: [PATCH v2 5/6] mailbox: Add generic mechanism for testing Mailbox
 Controllers
In-Reply-To: <20150813110008.GD8782@x1>
References: <1437990272-23111-1-git-send-email-lee.jones@linaro.org>
 <1437990272-23111-6-git-send-email-lee.jones@linaro.org>
 <CABb+yY20nQbiEEZeRvWTMUsJ2qgwRn8CrWvnFDSB-b1dgVaAuw@mail.gmail.com>
 <20150812102328.GD18282@x1>
 <CABb+yY0A74Vy3-KOvj0URU_4zb2FAC7Yp3gmEwnFaBrD0mzt0w@mail.gmail.com>
 <20150813091914.GB8782@x1>
 <CABb+yY0cgbtM68-E_Xqgh5O6GRLXESYTLa5WcAwUBoVL3ufrxA@mail.gmail.com>
 <20150813102335.GC8782@x1>
 <CABb+yY3z7p97eOhncQ2i+g6yoYGfDgSN9BDPKmiDaVLa3oPocA@mail.gmail.com>
 <20150813110008.GD8782@x1>
Message-ID: <CABb+yY34i=VUnswUE21vgeQYAGOS=7uwvdnTAFFgYkTV0CFk=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 4:30 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 13 Aug 2015, Jassi Brar wrote:
>
>> On Thu, Aug 13, 2015 at 3:53 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Thu, 13 Aug 2015, Jassi Brar wrote:
>> >
>> >> On Thu, Aug 13, 2015 at 2:49 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> >> > On Thu, 13 Aug 2015, Jassi Brar wrote:
>> >>
>> >> >> >> > +
>> >> >> >> > +static void mbox_test_prepare_message(struct mbox_client *client, void *message)
>> >> >> >> > +{
>> >> >> >> > +       struct mbox_test_device *tdev = dev_get_drvdata(client->dev);
>> >> >> >> > +
>> >> >> >> > +       if (tdev->mmio)
>> >> >> >> > +               memcpy(tdev->mmio, message, MBOX_MAX_MSG_LEN);
>> >> >> >> >
>> >> >> >> This is unlikely to work. Those platforms that need to send a 2 part
>> >> >> >> message, they do :
>> >> >> >> (a) Signal/Command/Target code via some controller register (via
>> >> >> >> mbox_send_message).
>> >> >> >> (b) Setup the payload in Shared-Memory (via tx_prepare).
>> >> >> >>
>> >> >> >> This test driver assumes both are the same. I think you have to
>> >> >> >> declare something like
>> >> >> >
>> >> >> > This driver assumes that the framework will call client->tx_prepare()
>> >> >> > first, which satisfies (b).  It then assumes controller->send_data()
>> >> >> > will be invoked, which will send the platform specific
>> >> >> > signal/command/target code, which then satisfies (a).
>> >> >> >
>> >> >> Yeah, but what would be that code? Who provides that?
>> >> >>
>> >> >> > In what way does it assume they are the same?
>> >> >> >
>> >> >> notice the 'message' pointer in
>> >> >> mbox_send_message(tdev->tx_channel, message);
>> >> >>     and
>> >> >> memcpy(tdev->mmio, message, MBOX_MAX_MSG_LEN);
>> >> >>
>> >> >> >> struct mbox_test_message { /* same for TX and RX */
>> >> >> >>           unsigned sig_len;
>> >> >> >>           void *signal;               /* rx/tx via mailbox api */
>> >> >> >>           unsigned pl_len;
>> >> >> >>           void *payload;           /* rx/tx via shared-memory */
>> >> >> >> };
>> >> >> >
>> >> >> > How do you think this should be set and use these?
>> >> >> >
>> >> >> The userspace would want to specify the command code (32bits or not)
>> >> >> that would be passed via the fifo/register of the controller. So we
>> >> >> need signal[]
>> >> >>
>> >> >> The data to be passed via share-memory could be provided by userspace
>> >> >> via the payload[] array.
>> >> >
>> >> > Okay, so would the solution be two userspace files 'signal' and
>> >> > 'message', so in the case of a client specified signal we can write it
>> >> > into there first.
>> >> >
>> >> > echo 255  > signal
>> >> > echo test > message
>> >> >
>> >> > ... or in the case where no signal is required, or the controller
>> >> > driver taking care of it, we just don't write anything to signal?
>> >> >
>> >> file_operations.write() should parse signal and message, coming from
>> >> userspace, into a local structure before routing them via
>> >> mbox_send_message and tx_prepare respectively.
>> >
>> > Okay.  So before I code this up we should agree on syntax.
>> >
>> > How would you like to represent the break between signal and message?
>> > Obviously ' ' would be a bad idea, as some clients may want to send
>> > messages with white space contained.  How about '\t' or '\n'?
>> >
>> Yeah, I am not a fan of markers and flags either.
>>
>> Maybe we should share with userspace
>>   struct mbox_test_message { /* same for TX and RX */
>>            unsigned sig_len;
>>            void __user *signal;        /* rx/tx via mailbox api */
>>            unsigned pl_len;
>>            void __user *payload;    /* rx/tx via shared-memory */
>>   };
>>
>> First copy_from_user the structure of length sizof(struct
>> mbox_test_message) and then copy_from_user length sig_len and pl_len
>> from signal[] and payload[] respectively (usually ioctls would carry
>> such data).
>
> Simplicity and ease of use should be the goals here.  Testers should
> not have to write applications to use this driver.  Can we come up
> with a simple/effective method that uses SYSFS/DEBUGFS please?
>
> The easiest way I can think of which avoids markers/separators AND the
> requirement for users to have to write applications is to have two
> files, 'signal' and 'message' as mentioned before.  Once both are
> populated I can get this driver to draft the message appropriately and
> fire it off.
>
And then write to more files for RX data? ... which should also be in
the form of 'signal' and 'message'.

BTW like for spi there is a stock application in
Documentation/spi/spidev_test.c we could do the same?
