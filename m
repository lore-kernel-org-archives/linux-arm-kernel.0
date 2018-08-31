From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Fri, 31 Aug 2018 21:30:47 +0530
Subject: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
In-Reply-To: <CAK8P3a0wdXRmZOw+yyws00GU=xYAFkGm81xKTF3-DjNmjjZH5g@mail.gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
 <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
 <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
 <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com>
 <CA+sq2CfAvasZoNmnNQadhdsEz-eyXQPBtXbDmvt1nM0DQsm+8g@mail.gmail.com>
 <CAK8P3a0wdXRmZOw+yyws00GU=xYAFkGm81xKTF3-DjNmjjZH5g@mail.gmail.com>
Message-ID: <CA+sq2CfL-eBWPcu1H9UkvKuL4kPeKnL1qkiG0tLZa_GW8LEqXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 7:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 30, 2018 at 7:55 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > On Thu, Aug 30, 2018 at 7:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Aug 28, 2018 at 3:10 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > Ok, I think I understand the PF/VF distinction now. One (to me)
> > > surprising aspect here is that you not just have one physical function
> > > that you can use to assign resources to multiple virtual functions,
> > > but also a second level of virtualization that is used to assign
> > > resources to "physical functions" that are less physical than the
> > > name suggests.
> >
> > Yes, PF is just for name sake, on-boot there is no difference between
> > PFs/VFs as such.
> > PF0 has privilege access to assign resources to all PFs and their VFs.
> > This admin function driver loads for PF0.
>
> ok
>
> > > The part that I have not grasped yet is what the split between
> > > the CGX and the AF is for, how they relate to one another, and
> > > what the software abstraction for the two is going to be.
> >
> > In HW, CGX is a separate PCI device which handles the serdes and
> > physical ethernet interface.
> > Ethernet driver in drivers/net/ethernet can only communicate to
> > admin function driver since they share a mailbox memory.
> > So we had to bind both CGX and admin function drivers to almost work as one,
> > inorder to provide relavent info to ethernet drivers. That's why we
> > have many functions
> > from CGX driver which AF uses.
> >
> > eg: Firmware gets to know about a physical interface status change,
> > which CGX driver gets
> > to know and it uses AF's mailbox communication to inform ethernet
> > driver about the event.
>
> Would it make sense then to combine the CGX driver and the AF
> driver into a single module? It sounds like you can never really
> use one without the other anyway, and that would make it easier
> to have a sensible abstraction to user space.
>
>       Arnd

Thanks for the suggestion, that does makes sense.
Actually i did thought about it, but i was skeptical if it would be
acceptable to make
a single module out of drivers registering for two different PCI devices.

Will wait for few more days for more feedback from anyone and port v2 series.

Sunil.
