From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Oct 2016 19:03:54 +0100
Subject: Question about arm64 earlycon
In-Reply-To: <CADaLNDk2pYMXQ-EYVw_vM23rsazFAHe_5qcjTajii13tRMD5Ew@mail.gmail.com>
References: <CADaLNDnB3QBjODYNTndBsexGQfnL1rj6DAUPcf1nT9+aJaqCtw@mail.gmail.com>
 <4966376.bRx4fgSjbT@wuerfel>
 <1f1eeb4a-925a-9fac-d442-fbee503deb0a@arm.com>
 <20161024110904.GF15620@leverpostej>
 <CADaLNDk2pYMXQ-EYVw_vM23rsazFAHe_5qcjTajii13tRMD5Ew@mail.gmail.com>
Message-ID: <20161024180353.GS15620@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 10:24:19AM -0700, Duc Dang wrote:
> On Mon, Oct 24, 2016 at 4:09 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Oct 24, 2016 at 11:17:36AM +0100, Marc Zyngier wrote:
> > > On 24/10/16 11:06, Arnd Bergmann wrote:
> > > > On Sunday, October 23, 2016 12:26:59 AM CEST Duc Dang wrote:
> > > >> Hi Catalin, Marc, Mark, Arnd,
> > > >>
> > > >> I am testing with 3.12 kernel with earlyprintk enabled and I see some
> > > >> garbage characters in the console log right before the message
> > > >> indicating that the real console device is initialized:
> >
> > What exactly are you passing on the command line?
> 
> This is what I have:
> earlyprintk=uart8250-32bit,0x1c020000
> 
> I should be more specific: the early console prints characters just
> fine (I see all the early boot log). Only at the moment before
> switching to the real console, I occasionally see some garbage
> characters.

Sorry, I managed to miss that previously. Sorry for the noise.

As Marc said, it sounds like the problem is the lack of synchronisation
between the drivers at hand-over time. Perhaps there's a FIFO still
draining, or the "real" driver doesn't put the UART in a quiescent state
before reinitialising it.

Generally earlycon/earlyprintk is there to debug early boot issues, and
is not there just to get UART output earlier. If you don't need to debug
an issue, turning it off will avoid problems.

If there's a simple change to the "real" driver init sequence to avoid
the temporary glitching, that would be great, but not many people are
going to care. We'd rather keep the earlycon code simple so as to ensure
we can use it to debug early boot failures.

Thanks,
Mark.
