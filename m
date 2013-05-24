From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 24 May 2013 14:10:10 +0200
Subject: [I2C] informations + advice about messages handling
In-Reply-To: <CAK7N6vqqG68c4vx1uBsNLF8zpSRQWwY5jERqjVYKE7NkEEzFSA@mail.gmail.com>
References: <CA78C307B8F06747967D122FC656B153986448@SERVEUR0.nvp.local>
 <CAK7N6vpg6QUAKODKO2Msr4+GTASLDpA2cG1teQV3yiwt7D4SSw@mail.gmail.com>
 <20130524094407.61d0ec42@endymion.delvare>
 <CAK7N6vqqG68c4vx1uBsNLF8zpSRQWwY5jERqjVYKE7NkEEzFSA@mail.gmail.com>
Message-ID: <20130524141010.1b3590b4@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 May 2013 16:29:36 +0530, anish singh wrote:
> On Fri, May 24, 2013 at 1:14 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Fri, 24 May 2013 12:52:40 +0530, anish singh wrote:
> >> http://thread.gmane.org/gmane.linux.kernel/1410276
> >
> > This is for a specific case. The general case is handled by the
> > per-adapter mutex for years now. 2.6.32 should be just fine in this
> > respect.
>
> I may be mis-understanding here but when two client wants to
> communicate with same master and at the same
> time how does that happen?

In general clients (slaves in I2C terminology) do not initiate
transactions, it's the master's job.

> In the thread I mentioned client pulls the line low indicating that
> it wants to own the bus and waits for some time and then checks
> if the line is still low or not.If it is still low then it owns the bus
> and start transaction and if clients see otherwise it releases the
> bus and tries again after some time.How is that handled in the
> previous kernel?

That particular scenario is not handled by earlier kernels, but this is
a very special case. In most cases (including Myl?ne's as far as I can
see) it is not needed because there is a single master on the segment.
And even with multiple masters, I2C bus arbitration normally takes place
transparently. Only when the standard bus arbitration can't work for
some reason, the code you mentioned is needed.

-- 
Jean Delvare
