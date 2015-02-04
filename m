From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 4 Feb 2015 08:57:43 +0530
Subject: [PATCH v5 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <4344803.3qsb2TUUaZ@wuerfel>
References: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <CAJe_ZhdL6=4bMPRitFeCqrO2jeYQuDa9071estTBd3PTbmURYA@mail.gmail.com>
 <20150203144611.GS8656@n2100.arm.linux.org.uk>
 <4344803.3qsb2TUUaZ@wuerfel>
Message-ID: <CAJe_Zhfyr9ts=k_=kyXqC=aGtQdrq9MtrRXt6LQKR7iofKjqKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2015 at 20:55, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 03 February 2015 14:46:11 Russell King - ARM Linux wrote:
>> On Tue, Feb 03, 2015 at 08:09:34PM +0530, Jassi Brar wrote:
>> > On 3 February 2015 at 18:02, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> > > On Tue, Feb 03, 2015 at 05:29:23PM +0800, Vincent Yang wrote:
>> > >> +static int mhu_send_data(struct mbox_chan *chan, void *data)
>> > >> +{
>> > >> +     struct mhu_link *mlink = chan->con_priv;
>> > >> +
>> > >> +     pr_debug("%s:%d\n", __func__, __LINE__);
>> > >> +     if (!mhu_last_tx_done(chan)) {
>> > >> +             dev_err(chan->mbox->dev, "Last TX(%d) pending!\n", mlink->irq);
>> > >> +             return -EBUSY;
>> > >> +     }
>> > >> +
>> > >> +     writel_relaxed((u32)data, mlink->tx_reg + INTR_SET_OFS);
>> > >
>> > > Doesn't that cause a GCC warning?
>> > >
>> > I don't see any, but I'll drop the cast.
>>
>> A cast is probably needed.  You're right that GCC no longer warns about
>> this - I'm pretty sure it used to complain about casting pointers to
>> ints, and we used to need to cast to "unsigned long" first.
>
> It definitely warns about converting an u64 to pointer or back,
> and it warns on 64-bit machines about this conversion.
>
> On a related note, I wonder why the driver actually converts a pointer to
> int. I believe we have discussed this in the past but don't remember the
> outcome.
We never discussed this (MHU) driver. It was the generic mailbox API
where, IIRC, I did take into account all your comments. The API does
do what you had asked.

> I had expected to see here something like:
>
> static int mhu_send_data(struct mbox_chan *chan, void *data)
> {
>         struct mhu_link *mlink = chan->con_priv;
>         u32 *arg = data;
>
>         writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
> }
>
> i.e. dereferencing the pointer instead of using the actual value.
>
OK, just curious how is this (dereferencing to the u32 variable on
stack of the client driver) better?

Thanks.
