From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Aug 2018 15:56:47 +0200
Subject: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
In-Reply-To: <CA+sq2Cdn6ut3kdTWoOgCayO2evQrD9TjBaUpVUR3_rWZFxYeig@mail.gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
 <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
 <CAK8P3a1CvX1V8h20s_=XUUYfR-zYNwETg5p6dCtpVUqZ89K-tg@mail.gmail.com>
 <CA+sq2Cdn6ut3kdTWoOgCayO2evQrD9TjBaUpVUR3_rWZFxYeig@mail.gmail.com>
Message-ID: <CAK8P3a1W2D5YWEC-VDkvQ8y3W8257g6X7B8_At7g8f9iE73a8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 3:23 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> On Tue, Aug 28, 2018 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 28, 2018 at 2:48 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > >
> > > On Tue, Aug 28, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
> > > > >
> > > > > From: Aleksey Makarov <amakarov@marvell.com>
> > > > >
> > > > > This patch adds mailbox support infrastructure APIs.
> > > > > Each RVU device has a dedicated 64KB mailbox region
> > > > > shared with it's peer for communication. RVU AF has
> > > > > a separate mailbox region shared with each of RVU PFs
> > > > > and a RVU PF has a separate region shared with each of
> > > > > it's VF.
> > > > >
> > > > > These set of APIs are used by this driver (RVU AF) and
> > > > > other RVU PF/VF drivers eg netdev, crypto e.t.c.
> > > > >
> > > > > Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
> > > > > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > > > > Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
> > > >
> > > > Why does this driver not use the drivers/mailbox/ infrastructure?
> > > >
> > > This is a common administrative software driver which will be handling requests
> > > from kernel drivers and as well as drivers in userspace applications.
> > > We had to keep mailbox communication infrastructure same across all usages.
> >
> > Can you explain more about the usage of userspace applications
> > and what interface you plan to use into the kernel?
>
> Any PCI device here irrespective in what domain (kernel or userspace)
> they are in
> use common mailbox communication. Which is
> # Write a mailbox msg (format is agreed between all parties) into
> shared (between AF and other PF/VFs)
>    memory region and trigger a interrupt to admin function.
> # Admin function processes the msg and puts reply in the same memory
> region and trigger
>    IRQ to the requesting device. If the device has a driver instance
> in kernel then it uses
>    IRQ and userspace applications does polling on the IRQ status bit.

Ok, so the mailbox here is a communication mechanism between
two device drivers that may run on the same kernel, or in different
instances (user space, virtual machine, ...), but each driver
only talks to the mailbox visible in its own device, right?

What is the purpose of the exported interface then? Is this
just an abstraction so each of the drivers can talk to its own
mailbox using a set of common helper functions?

      Arnd
