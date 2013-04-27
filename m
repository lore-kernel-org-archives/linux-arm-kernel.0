From: andy.green@linaro.org (Andy Green)
Date: Sat, 27 Apr 2013 09:48:05 +0800
Subject: [PATCHv3 00/14] drivers: mailbox: framework creation
In-Reply-To: <517B242D.7040902@ti.com>
References: <1363145021-14339-1-git-send-email-s-anna@ti.com>
 <CABb+yY0RYkVeo2Sb4WsDJY0jf17488FEz0d2CB994eQaSOEsVg@mail.gmail.com>
 <37C860A02101E749A747FA2D3C1E3C504A5DF7@DLEE11.ent.ti.com>
 <CABb+yY1x4x_A+QtGG9ohsLPgs8c3nEVnd_ExJBGOOR8=6YLPFA@mail.gmail.com>
 <37C860A02101E749A747FA2D3C1E3C504A63B4@DLEE11.ent.ti.com>
 <CAJe_ZhehnniZd730jjiOLrHozq8TOJZgFYLqUe4KqgBiQEu8PA@mail.gmail.com>
 <51779304.4040003@st.com>
 <CAJe_ZhdZv5LW6kdwyPtJe69mfW6t=WQ4OJnG2H4sUhibattN2A@mail.gmail.com>
 <517867E1.7050301@ti.com>
 <CAJe_ZhfDZzq+DzA9XDF3PWFUmwcZnDy-mhE4hLNHmf+V4GhOxw@mail.gmail.com>
 <5179AE2F.3040403@ti.com>
 <CAJe_Zhf4miUm4yTyuwc56kpD8Mu4=vsmX4wdQkFDT96JbKR=MQ@mail.gmail.com>
 <517B242D.7040902@ti.com>
Message-ID: <517B2E55.4070708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/04/13 09:04, the mail apparently from Suman Anna included:

Hi Suman -

> Even though both the scenarios look very similar, I believe there are
> some slight differences. All the devices belonging to a controller may
> not be of the same type (meaning, intended towards the same remote or be
> used interchangeably with one another). It is definitely possible if you
> have a similar scenario to the DMA physical channels and your remote
> rx interrupt can identify the device/channel to process. This would be
> very much dependent on the architecture of a controller. The particular
> example that I have in mind is s/w clients between the same set of
> remote and host entities using the same device - the send part is anyway
> arbitrated by the controller, and the same received message can be
> delivered to the clients, with the clients making the decision whether
> the packet belongs to them or not. I agree that all remote-ends will not
> be able to cope up intermixed requests, but isn't this again a
> controller architecture dependent?

Maybe it's helpful to describe our situation more concretely, because 
the problem is not coming from "the architecture of the [mailbox] 
controller".

In the SoC we work on clock and subsystem power control registers, a 
serial bus, and some other assets are not directly accessible from 
Linux.  We must ask a coprocessor to operate these for us, using the 
mailbox.

So at any one time, the clock driver or voltagedomain driver for the SoC 
may want to own the mailbox and perform one or more operations over it 
synchronously, in some cases on the remote side involving transactions 
on a serial bus.  We don't want other transactions to be occurring while 
we wait for the serial bus to complete what the driver who started that 
asked for, for example.

We can cope with this by having an outer driver mediate access to the 
mailbox.  But then there are multiple sync primitives like completions 
and notifiers per operation, because your core already does this.

In short the FIFO + sync operations approach your core implements 
doesn't fit our use case.  That can be our problem, in which case we'll 
live with the outer mediation driver on top of the mailbox, or it can be 
a sign the fixed choice of FIFO + sync operations in your core did not 
quite hit the nail on the head to really model all the facets of legit 
mailbox usage.

At least, this real scenario should be interesting to think about before 
rejecting ^^

-Andy

-- 
Andy Green | Fujitsu Landing Team Leader
Linaro.org ? Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  - 
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
