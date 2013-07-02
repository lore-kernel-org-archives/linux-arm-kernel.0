From: mhu4@marvell.com (Mingliang Hu)
Date: Mon, 1 Jul 2013 20:00:34 -0700
Subject: [PATCH] mmp: irq: Don't clear unused interrupt enable bits
In-Reply-To: <CAMPhdO8jAN5kCT_tgH4NxTJ=GOGQqXukUrxNWsHExUSXZ+44bA@mail.gmail.com>
References: <20130627175118.8A9FEFAACF@dev.laptop.org>
 <CAMPhdO_Ccp_JeuNNkqP6Q+ubmG8rah_hkxFJmOBsetysu-+dNw@mail.gmail.com>
 <CAMLZHHSS75dSd_PM5-Gu2K-kP+RF0Fx1E+TL=d-TeXzYSLsQPg@mail.gmail.com>
 <CAMPhdO8jAN5kCT_tgH4NxTJ=GOGQqXukUrxNWsHExUSXZ+44bA@mail.gmail.com>
Message-ID: <27A9CDBCD298C74285705477D186E0C918133E94F4@sc-vexch3.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Chao to comment.

-----Original Message-----
From: Eric Miao [mailto:eric.y.miao at gmail.com] 
Sent: 2013?6?29? 12:55
To: Daniel Drake
Cc: Haojian Zhuang; linux-arm-kernel; paul fox; Mingliang Hu
Subject: Re: [PATCH] mmp: irq: Don't clear unused interrupt enable bits

On Fri, Jun 28, 2013 at 10:24 PM, Daniel Drake <dsd@laptop.org> wrote:
> On Thu, Jun 27, 2013 at 11:15 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> Is there any way to check this at run-time or at least by boot parameters?
>
> The only thing that occurs to me would be checking for the device tree 
> node that corresponds to our input serio. But doing that from platform 
> code would be horrible, and it would also be nasty doing it from the 
> input driver.

I think that should be OK and clean, e.g.

  if (of_property_read_bool(np, "irq-route-to-sp")) {
     ....
  }

I'm fine with leaving these bits out as your patch does, the only concern is some other code may have a chance to depend on this, and may benefit from this boot configuration flexibility as well.

>
>> Decide whether the interrupt gets delivered to SP seems to be a 
>> choice that the main CPU should be doing, as well as the interrupt priority.
>
> Incidentally the main CPU does make these choices - just before Linux 
> has booted.
>
> While Linux has no interaction with the SP (it is not even aware of 
> it), I would say not stomping on its configuration is an OK policy to 
> have.
>
>> And this is really all about bit 4 right?
>
> Yes, bit 4 is the crucial one, it is required for the OLPC inbuilt 
> keyboard/touchpad to work.
>
> However on numerous occasions during interactions with Marvell they 
> have stressed the importance of setting interrupt priorities on 
> interrupts used for wakeups. We don't think it makes a difference for 
> the issues that we have seen, but we do not ignore the request. As 
> that cannot be done in Linux, we do it in the firmware, and it seems 
> like while Linux does not work with interrupt priorities it should not 
> overwite any earlier setup.

Haojian & Mingliang, could you help check this is the case, and that no known driver (including those for upstream) is depending on this behavior?

>
> Daniel
