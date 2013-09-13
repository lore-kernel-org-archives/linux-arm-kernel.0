From: cinifr@gmail.com (cinifr)
Date: Fri, 13 Sep 2013 21:09:55 +0800
Subject: [PATCH 3/4] Add physical count arch timer support for clocksource
 in ARMv7.
In-Reply-To: <5232DB49.4050701@arm.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
 <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
 <CAK3cCBwu4somtfc9J1ZDVcC-iYD1qDJwSWzWeOomTqY9tQA2kg@mail.gmail.com>
 <5231EE43.5090900@arm.com>
 <CAK3cCBzr8_LTYarZDgPYZY7_-5Qco_Qw+ACi=c2uOrn7MqwkBg@mail.gmail.com>
 <5232DB49.4050701@arm.com>
Message-ID: <CAK3cCBw4EKypLmhf4L5_P3d27QzsrB+ZxUTgF58YhmUhBa00xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I urge you to read the ARM ARM, and specifically the section dedicated
> to trapping access to CP15 operations. If you do, you'll quickly notice
> that you *cannot* trap accesses to the timer subsystem.
>
I read it again. The ARMv7 manual said "Is accessible from Non-secure
PL1 modes only when CNTHCTL.PL1PCTEN is set to 1. When
CNTHCTL.PL1PCTEN is set to 0, any attempt to access CNTPCT from a
Non-secure PL1 mode ***generates a Hyp Trap exception***, see Hyp Trap
exception on page B1-1206" in B8.1.2. but I dont find  a  special hyp
trap control  for accessing CNTPCT in manual. As you said HSTR cannot
trap accessing of CP15 c14. What happer when OS access CNTPCT from PL1
NS=1 mode with CNTHCTL.PL1PCTEN=0 ???  AmI  wrong for understanding
the manual?
Thanks.
BTW: And I fond xen have support to trap accessing   CNTPCT by this
patch on http://lists.xen.org/archives/html/xen-devel/2012-08/msg00452.html.

> All you can do is disable access to the physical timer/counter,
> resulting in an UNDEF in the *guest*.
>
> Additionally, please realise the overhead of trapping is enormous, and
> that we do try very hard to minimise it. Why do you think we went out of
> our way to ensure that host and guest would use different timers, always?

>
> CNTVOFF can only be setup from either HYP or Secure Monitor mode with
> SCR.NS == 1, so if you run your kernel in secure mode, it is always best
> to do it in the bootloader.
I agree it, Bootloader do  it better.

         Fan
