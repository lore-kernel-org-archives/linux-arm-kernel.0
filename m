From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 11:14:30 +0200
Subject: [PATCH v5] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <CAGhQ9VwAe7d7fX1Lw22ocxDSXjOZbvXdmG1u6_d5v7ptmYMYeg@mail.gmail.com>
References: <1411360807-7750-1-git-send-email-pankaj.dubey@samsung.com>
 <2553182.6YgvmDLuEA@wuerfel>
 <CAGhQ9VwAe7d7fX1Lw22ocxDSXjOZbvXdmG1u6_d5v7ptmYMYeg@mail.gmail.com>
Message-ID: <3291391.H71MjevFsA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 September 2014 09:48:24 Joachim Eastwood wrote:
> On 26 September 2014 09:16, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 26 September 2014 07:34:12 Joachim Eastwood wrote:
> >> I am working on Cortex-M4 no-MMU platform that isn't upstream yet, btw.
> >>
> >
> > Sorry for drifting off-topic, but this is very interesting to me. Can you
> > say which one you are working on and what your timeline is for submitting
> > it upstream?
> 
> It's NXP LPC18xx/43xx which is Cortex-M3/M4.
> 
> 3.19 or 3.20 might be target.

Ah, very nice!

> Right now everything is in a github repository here:
> https://github.com/manabian/linux-lpc
> 
> Most stuff are working now and I am in the process of clean it up and
> adding documentation.

Ok, looks like you are making good progress. I noticed three high-level
issues that you may want to address:

- the watchdog driver should use the generic watchdog framework rather
  than registering a misc device.
- the ehci glue can probably go away if you make very small changes
  to the generic ehci platform driver
- I don't like the way that the stmmac glue drivers are added, I thought
  we had fixed this before but I think I need to dig up old emails.
  The driver should really be a loadable module that hooks calls into
  the common code rather than being linked into one module.

I also have a plan for doing multiplatform builds of nommu kernels, 
for build testing mostly, I wouldn't expect you to run that configuration.
No need for you to address that yourself though, we'll get there.

	Arnd
