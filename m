From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Feb 2015 11:29:55 +0100
Subject: [PATCH v5 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <CAJe_Zhfyr9ts=k_=kyXqC=aGtQdrq9MtrRXt6LQKR7iofKjqKg@mail.gmail.com>
References: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <4344803.3qsb2TUUaZ@wuerfel>
 <CAJe_Zhfyr9ts=k_=kyXqC=aGtQdrq9MtrRXt6LQKR7iofKjqKg@mail.gmail.com>
Message-ID: <4418090.U8XOXMKsEU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 February 2015 08:57:43 Jassi Brar wrote:
> On 3 February 2015 at 20:55, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 03 February 2015 14:46:11 Russell King - ARM Linux wrote:
> >> On Tue, Feb 03, 2015 at 08:09:34PM +0530, Jassi Brar wrote:

> > I had expected to see here something like:
> >
> > static int mhu_send_data(struct mbox_chan *chan, void *data)
> > {
> >         struct mhu_link *mlink = chan->con_priv;
> >         u32 *arg = data;
> >
> >         writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
> > }
> >
> > i.e. dereferencing the pointer instead of using the actual value.
> >
> OK, just curious how is this (dereferencing to the u32 variable on
> stack of the client driver) better?

The API as I understand is defined to use the pointer to point to
a chunk of data of fixed size, with the size being known to both
the client driver and the mailbox driver. This is the reason for
having a pointer in the first place.

Using the bits of the pointer as the message instead of pointing
to the message feels like an abuse of the API.

Maybe it would have been better to pass the size explictly as 
a third argument in the API to make that clear.

	Arnd
