From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Aug 2018 16:16:04 +0200
Subject: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
In-Reply-To: <CA+sq2CfjJjswOwypNMtro+g8TeHGoBqAeKpFrf2ys-1=Xg+qHw@mail.gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
 <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
 <CAK8P3a1CvX1V8h20s_=XUUYfR-zYNwETg5p6dCtpVUqZ89K-tg@mail.gmail.com>
 <CA+sq2Cdn6ut3kdTWoOgCayO2evQrD9TjBaUpVUR3_rWZFxYeig@mail.gmail.com>
 <CAK8P3a1W2D5YWEC-VDkvQ8y3W8257g6X7B8_At7g8f9iE73a8w@mail.gmail.com>
 <CA+sq2CfjJjswOwypNMtro+g8TeHGoBqAeKpFrf2ys-1=Xg+qHw@mail.gmail.com>
Message-ID: <CAK8P3a3q_rY6VHwX9xQ9VMNC_4EmJLKzzDPL28SE13qNHX7=aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 8:37 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> On Thu, Aug 30, 2018 at 7:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Aug 28, 2018 at 3:23 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > On Tue, Aug 28, 2018 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Aug 28, 2018 at 2:48 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > Any PCI device here irrespective in what domain (kernel or userspace)
> > > they are in
> > > use common mailbox communication. Which is
> > > # Write a mailbox msg (format is agreed between all parties) into
> > > shared (between AF and other PF/VFs)
> > >    memory region and trigger a interrupt to admin function.
> > > # Admin function processes the msg and puts reply in the same memory
> > > region and trigger
> > >    IRQ to the requesting device. If the device has a driver instance
> > > in kernel then it uses
> > >    IRQ and userspace applications does polling on the IRQ status bit.
> >
> > What is the purpose of the exported interface then? Is this
> > just an abstraction so each of the drivers can talk to its own
> > mailbox using a set of common helper functions?
> >
>
> Yes, that's correct.
>
> In kernel there will be a minimum of 3 drivers which will use this
> mailbox communication.
> So instead of duplicating APIs and structures in every driver, we
> thought of adding them in this AF driver and export them to ethernet
> and crypto drivers.

Ok. My feeling is then that the API is fine, but that it should not
be part of the AF module but rather be a standalone module.

My comment about the generic mailbox API no longer applies
here: you don't have a single shared mailbox hardware interface,
but each device has its own mailbox register set, so there
is no point in setting up a separate device for it, but I see
no need for creating an artificial dependency on the AF
driver. E.g. in a virtual machine that only has one ethernet
interface, you otherwise wouldn't load that driver, right?

         Arnd
