From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 12 Aug 2015 15:46:06 +0530
Subject: [PATCH v2 2/6] mailbox: dt-bindings: Add shared [driver <=>
 device tree] defines
In-Reply-To: <20150812085309.GB18282@x1>
References: <1437990272-23111-1-git-send-email-lee.jones@linaro.org>
 <1437990272-23111-3-git-send-email-lee.jones@linaro.org>
 <CABb+yY2asjH-c+VJXvG+RK0=2p=P4Y21pznNP0riaKMWLxYZog@mail.gmail.com>
 <20150810082445.GA3249@x1>
 <CABb+yY3jUKXXJys32bHY1u+dbdsix71Xq_H1Lrkkt27vZzmf7w@mail.gmail.com>
 <20150812085309.GB18282@x1>
Message-ID: <CABb+yY3LdX1Lk7jfPbdXr4Zw=zKGJ=TsRRhB5a4CeYHOsjb90A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 2:23 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 10 Aug 2015, Jassi Brar wrote:
>
>> On Mon, Aug 10, 2015 at 1:54 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Mon, 10 Aug 2015, Jassi Brar wrote:
>> >> On Mon, Jul 27, 2015 at 3:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> >> > This header is currently only used for defines pertaining to data
>> >> > direction i.e. Rx, Tx or Loopback.
>> >> >
>> >> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> >> > ---
>> >> >  include/dt-bindings/mailbox/mailbox.h | 14 ++++++++++++++
>> >> >  1 file changed, 14 insertions(+)
>> >> >  create mode 100644 include/dt-bindings/mailbox/mailbox.h
>> >> >
>> >> > diff --git a/include/dt-bindings/mailbox/mailbox.h b/include/dt-bindings/mailbox/mailbox.h
>> >> > new file mode 100644
>> >> > index 0000000..82e929a
>> >> > --- /dev/null
>> >> > +++ b/include/dt-bindings/mailbox/mailbox.h
>> >> > @@ -0,0 +1,14 @@
>> >> > +/*
>> >> > + * This program is free software; you can redistribute it and/or modify
>> >> > + * it under the terms of the GNU General Public License version 2 as
>> >> > + * published by the Free Software Foundation.
>> >> > + */
>> >> > +
>> >> > +#ifndef __MAILBOX_CONTROLLER_DT_BINDINGS_H
>> >> > +#define __MAILBOX_CONTROLLER_DT_BINDINGS_H
>> >> > +
>> >> > +#define MBOX_TX                0x1
>> >> > +#define MBOX_RX                0x2
>> >> > +#define MBOX_LOOPBACK  (MBOX_RX | MBOX_TX)
>> >> > +
>> >> Not sure I understand 'loopback'.  Does it mean h/w has some
>> >> 'loopback' mode for testing purposes? Or it simply means the
>> >> controller can send as well as receive messages?
>> >
>> > 'loopback' allows firmware to conduct some early function tests.
>> > However, channels are simplex, so we provide protection against
>> > multiple allocation of single channel.  By allocating a LOOPBACK
>> > channel we over-ride this protection and allow a single channel to be
>> > allocated twice, once for Rx and the other for Tx.
>> >
>> So basically hardware is half-duplex, not simplex. I think maybe you
>> should simply allow for RX and TX always. It should work. Just
>> handover any received data before send_data (reflecting the h/w
>> limitation). That way you don't need any such special flag.
>
> Unfortunately no, that's not correct.  Only Mailbox 0 is half-duplex.
> The others are simplex (Rx only).
>
Assuming that is indeed the case (though code and comments suggest
otherwise), it is still not a matter of choice for clients to 'make' a
channel RX or TX or RXTX. That is the property/constraint of the
controller and the controller driver should simply check for channel
ID to be zero in send_data() and return error if its non-zero.

>  Ideally I'd like to keep the
> LOOPBACK flag, as it's easier to figure out if what someone is
> attempting to do is actually valid.
>
I am not for such paranoia. Provider drivers is not the place to check
for valid user data.
The controller driver should simply reject send_data() request on any
mailbox > 0 while the consumer driver should scream for attention
because that's where the problem is.

Please note, what I suggest will only make the code simpler while not
breaking anything.

Thanks.
