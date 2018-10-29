From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Oct 2018 15:52:46 +0100
Subject: [PATCH v4 1/4] soc: Add TmFifo driver for Mellanox BlueField Soc
In-Reply-To: <DB6PR05MB322336054C526251D2A3780CA1F30@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <CAK8P3a0VJkQgqaq7na1_KTQzVs4-PvxYghv5_LysW7EdeBM7fw@mail.gmail.com>
 <AM4PR05MB322089E21DD27295C1B0A946A1F00@AM4PR05MB3220.eurprd05.prod.outlook.com>
 <CAK8P3a3pi26FJ=vfU3QN=xUS+ktv1W-oqGWkdxc9s_S2HaYf6w@mail.gmail.com>
 <DB6PR05MB322336054C526251D2A3780CA1F30@DB6PR05MB3223.eurprd05.prod.outlook.com>
Message-ID: <CAK8P3a1_VgAUF4k8RbjOyWBM6F-oXv2WR1GMWF=E8_G0LtidCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 3:17 PM Liming Sun <lsun@mellanox.com> wrote:

> > >> > +/* Interrupt handler. */
> > >> > +static irqreturn_t tmfifo_irq_handler(int irq, void *dev_id)
> > >> > +{
> > >> > +        int i = (uintptr_t)dev_id % sizeof(void *);
> > >> > +        struct tmfifo *fifo = dev_id - i;
> > >> > +
> > >> > +        if (i < TM_IRQ_CNT && !test_and_set_bit(i, &fifo->pend_events))
> > >> > +                schedule_work(&fifo->work);
> > >> > +
> > >> > +        return IRQ_HANDLED;
> > >> > +}
> > >>
> > >> Maybe using a request_threaded_irq() would be a better way to defer
> > >> the handler into IRQ context.
> > >
> > > Not sure if I understand this comment correctly... In this case, the
> > > implemented handler
> > > has some mutex_lock() used, which tries to make the logic simple since
> > > multiple services
> > > (network & console) are sharing the same fifo. Thus schedule_work() is
> > > used.
> >
> > schedule_work() and threaded IRQs are just two different ways of deferring
> > into process context where you can do the mutex_lock(). The effect is
> > almost the same, but work queues can be delayed for a substantial
> > amount of time depending on what other work functions have been
> > queued at the same time, and request_threaded_irq() is the more normal
> > way of doing this specifically for an IRQ handler, probably saving a couple
> > of lines of source code.
> >
> > If you have any kind of real-time requirement, you can also assign a
> > specific realtime priority to that interrupt thread.
>
> Good information! Currently this FIFO is mainly for mgmt purpose. I'll try the threaded
> IRQs approach to see whether it can be easily converted and make it into the v5 patch.
> If not easily, probably a separate commit to improve it later?

Sure, no problem. This is not an important change, but I also think it should
be easy to do, in particular as it is meant to simplify the code.

       Arnd
