From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 May 2013 15:49:07 +0100
Subject: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
In-Reply-To: <201305081638.23100.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022260-2197-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081638.23100.arnd@arndb.de>
Message-ID: <20130508144907.GB20820@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 03:38:22PM +0100, Arnd Bergmann wrote:
> On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> > From: Stuart Menefy <stuart.menefy@st.com>
> > 
> > This is a simple driver for the global timer module found in the Cortex
> > A9-MP cores from revision r1p0 onwards. This should be able to perform
> > the functions of the system timer and the local timer in an SMP system.
> > 
> > The global timer has the following features:
> >     The global timer is a 64-bit incrementing counter with an
> > auto-incrementing feature. It continues incrementing after sending
> > interrupts. The global timer is memory mapped in the private memory
> > region.
> >     The global timer is accessible to all Cortex-A9 processors in the
> > cluster. Each Cortex-A9 processor has a private 64-bit comparator that
> > is used to assert a private interrupt when the global timer has reached
> > the comparator value. All the Cortex-A9 processors in a design use the
> > banked ID, ID27, for this interrupt. ID27 is sent to the Interrupt
> > Controller as a Private Peripheral Interrupt. The global timer is
> > clocked by PERIPHCLK.
> > 
> > Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> >
> 
> Are you sure we don't already have a driver for this? It sounds unlikely
> that you are the first one to do this when the hardware is so common.

An additional reason why people don't make use of this timer (on top of the
power domain concerns raised by Rob) is due to the following from the A9
TRM:

  `From r2p0 the comparators for each processor with the global timer fire
   when the timer value is greater than or equal to. In previous revisions
   the comparators fired when the timer value was equal to.'

So you'll get into all sorts of horrible races on those older revisions if
you're not careful.

Will
