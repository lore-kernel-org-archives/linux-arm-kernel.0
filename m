From: stern@rowland.harvard.edu (Alan Stern)
Date: Sun, 28 Oct 2012 17:09:46 -0400 (EDT)
Subject: [PATCH] spi/pl022: Activate resourses before deactivate them in
 suspend
In-Reply-To: <CAPDyKFoOJz6608b4z2PoW8ODvTJVZRq-yB0itfXnuoXdR1SpGQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1210281659520.9245-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Oct 2012, Ulf Hansson wrote:

> On 28 October 2012 20:52, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Sat, Oct 27, 2012 at 11:46 PM, Mark Brown
> > <broonie@opensource.wolfsonmicro.com> wrote:
> >> On Fri, Oct 05, 2012 at 09:43:32AM +0200, Ulf Hansson wrote:
> >>
> >>> To be able to deactivate resourses in suspend, the resourses must
> >>> first be surely active. This is done with a pm_runtime_get_sync.
> >>> Once the resourses are restored to active state again in resume,
> >>> the runtime pm usage count can be decreased with a pm_runtime_put.
> >>
> >> The PM core will ensure devices are runtime resumed before we enter
> >> suspend precisely due to this sort of issue.
> >
> > I asked the very same question to Ulf (in speech, sorry
> > so you couldn't see it...)
> >
> > So I guess we are talking about drivers/base/main.c
> >
> > in device_prepare()
> > pm_runtime_get_noresume() is called
> 
> This will increase the "usage_counter" for the device. It will not
> "runtime_resume" the device, though it will prevent it from being
> "runtime_suspended".

Indeed.  The PM core does _not_ insure that devices are runtime resumed
before going into system suspend.  Some subsystems may do this (the PCI
subsystem does, for example -- see
drivers/pci/pci-driver.c:pci_pm_prepare()), but the PM core doesn't.

Alan Stern
