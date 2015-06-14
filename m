From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 14 Jun 2015 10:11:05 +0200
Subject: [PATCH v4 0/6] SA1100/PXA RTC clean-up
In-Reply-To: <5575C85A.6010802@gmail.com> (Rob Herring's message of "Mon, 08
 Jun 2015 11:52:42 -0500")
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
 <87pp62jdpj.fsf@belgarion.home>
 <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
 <877fs5k9ps.fsf@belgarion.home>
 <CAL_JsqKWNNH4stY+CNtKCiE7qcwDYaxZc36-iqqe1ddmG82g1Q@mail.gmail.com>
 <871thq54c7.fsf@belgarion.home>
 <CAL_JsqJnj+JLFoUmE6COqhr83_H0n1=Bdk_wYnMZEzsZRu=aew@mail.gmail.com>
 <87wpzg4ji2.fsf@belgarion.home> <5575C85A.6010802@gmail.com>
Message-ID: <87d20ybtgm.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robherring2@gmail.com> writes:

>> On platforms where all the OSes use only 1 RTC, the bootloader only touches one
>> RTC, that's correct. Or said differently : the bootloader touches the union of
>> all the RTCs the OSes it launches do touch.
>
> Sorry, I'm being dense here, but I'm not any less confused as to which 
> scenarios you think have an issue. Rather than go around again on this, 
> perhaps you can just provide the warning for the commit text. Here's 
> what I have.

> 8<-------------------------------------------------------------------
> From e43db14b27486faef8d8e74e4aa555aba7f31a0e Mon Sep 17 00:00:00 2001
> From: Rob Herring <robh@kernel.org>
> Date: Mon, 1 Jun 2015 07:53:01 -0500
> Subject: [PATCH] ARM: config: Switch PXA27x platforms to use PXA RTC driver
>
> With the SA1100 and PXA RTC drivers be mutually exclusive and no
> longer sharing hardware, PXA27x/PXA3xx platforms must use the PXA RTC
> driver as the SA1100 platform device is no longer registered.
>
> This change should be transparent to userspace, but the first reboot
> after the switch will have the wrong time.

I'll switch that last sentence to :
"This change should be almost transparent to userspace. Former users of pxa-rtc
should be aware that 2 rtc will be available on their kernels, rtc0 being
sa1100-rtc and rtc1 being pxa-rtc. Any userspace relying on the fact that rtc0
was pxa-rtc should be fixed.

As a consequence :
 - the first reboot after the switch will have the wrong time,
 - on dual boot platform where the other OS programs some logic into the sa1100
   rtc IP, a lack of fix in userspace, ie. a kernel changing sa1100-rtc thinking
   it is pxa-rtc could have dire consequence, such as wiping the other OS data
   partition.
"

And add :
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Philipp Zabel <philipp.zabel@gmail.com>

With that, I'll be happy. I'll throw this serie at my jenkins, but there's no
reason for it to complain, and unless I've forgotten some unaddressed comment,
you'll have my ack within the next couple of days.

Cheers.

--
Robert
