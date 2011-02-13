From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 13 Feb 2011 22:24:38 +0100
Subject: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <4D55A7F7.5090700@mentor.com>
References: <4D55A7F7.5090700@mentor.com>
Message-ID: <AANLkTin+ZSNHX2iv=XwWCgxy330UJwhkf1T=4BMXZ22s@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/11 Meador Inge <meador_inge@mentor.com>:

>?This would entail the traditional
> generic/specific driver split:
>
> ? ?1. Hardware specific bits somewhere under '.../arch/*'. ?Drivers
> ? ? ? for the MPIC message registers on Power and OMAP4 mailboxes, for
> ? ? ? example.

Having any drivers under arch/* is no good tradition IMO.
Better move the whole shebang down to drivers/mailbox so
that the subsystem maintainer get the complete overview
of her/his driver family.

> ? ?2. A higher level driver under '.../drivers/mailbox/*'. ?That the
> ? ? ? pieces in (1) would register with. ?This piece would expose the
> ? ? ? main kernel API.

Cool...

> ? ?3. Userspace interfaces for accessing the mailboxes. ?A
> ? ? ? '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.

What kind of business does userspace have with directly using
mailboxes? Enlighten me so I get it... in our system these are
used by protocols, such as net/caif/* thru drivers/net/caif/*, and
we have similar kernelspace functionality for Phonet.

CAIF and Phonet on the other hand, have custom openings
down to the thing that exists on the other end of the mailbox.
Most of these systems tend to talk some funny protocol that
is often better handled by the kernel than by any userspace.

So is this for the situation when you have no intermediate
protocol between your userpace and the other CPU's
subsystem? Or are you thinking about handling that
protocol in userspace? That is generally not such a good idea
for efficiency reasons.

Yoursm
Linus Walleij
