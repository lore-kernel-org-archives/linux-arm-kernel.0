From: gsi@denx.de (Gerhard Sittig)
Date: Tue, 17 Sep 2013 17:05:48 +0200
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130917105142.GO21013@sirena.org.uk>
References: <20130913041208.GD3051@gmail.com>
 <20130912205644.GW29403@sirena.org.uk>
 <52329AD3.2050608@freescale.com>
 <20130913102127.GD29403@sirena.org.uk>
 <52366F97.5030402@freescale.com>
 <20130916101912.GY29403@sirena.org.uk>
 <5236DD17.5090203@freescale.com>
 <20130916110634.GC29403@sirena.org.uk>
 <5237BB01.3080700@freescale.com>
 <20130917105142.GO21013@sirena.org.uk>
Message-ID: <20130917150548.GE14747@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ a lurker tries to summarize, and to outline an approach to
  introducing generic support for enhanced SPI communication,
  where QuadSPI just becomes "a byproduct" enabled by extensions
  to the common infrastructure ]

On Tue, Sep 17, 2013 at 11:51 +0100, Mark Brown wrote:
> 
> On Tue, Sep 17, 2013 at 10:14:25AM +0800, Huang Shijie wrote:
> 
> > The dummy is just a delay in a command sequence.
> > The dummy maybe only several clock cycles, less then 8 bit.
> 
> This is what the delay_usecs field in the spi_transfer struct is for,
> the flash code should be using that to ensure that the minimum delay
> requirement is met.

Not quite.  You talk about 'delay_usecs' which is about letting
time pass by between partial transfers.  The "dummies" mentioned
here in this thread are "bit times with _clock pulses_" that get
inserted between transfers with single and multiple data lines.

Compare this with M25P opcodes READ 0x03 vs FAST_READ 0x0b, where
the latter "communicates" a dummy byte before real data is
returned.  So far (AFAICS) those dummy bit cycles always were
multiples of 8 bits, i.e. complete bytes.  So they could be done
with bitbang as well as get simulated with "traditional" SPI
transfers by just sending another byte without looking at the
received data.


[ difference in quality compared to "traditional" SPI ]

There is a new qualitiy here that there are e.g. only 6 "dummy
bits" involved, which appear to be encoded in hardware, and are
hard to do with "old" SPI controllers.  But OTOH those old
controllers won't do dual or quad data line transfers either, so
they won't need to do sub-byte dummy cycles.

I liked the S25F datasheet that was referenced here recently,
it's useful for the discussion that is going on here.  I liked
the "Serial Peripheral Interface with Multi-I/O" subtitle, which
suggests that SPI gets enhanced while nothing of it is specific
to flash chips.  And I liked the sequence diagrams for their
overview or introduction nature, which you can compare to the SPI
message submission API in the Linux kernel which connects SPI
slave drivers and SPI controller drivers.


[ automatic feature use in the MTD layer considered harmful ]

The datasheet had "block diagrams" (section 3.16) which
demonstrated that transfers which involve multiple data lines do
depend on
- the SPI slave (the chip) supporting it
- the SPI controller (the chip, IP block) supporting it
- the wiring required to do it (the board)
- all involved software (the drivers) supporting it and
  (optionally) wanting to use it

which is why the flash chip's capability alone does not suffice
to enable the use of such an optional feature.  And users or
admins may want to control the use of optional features for
development, or diagnostics, or compatibility, or whatever
reason.


[ generic support for enhanced SPI communication ]

And the datasheet had "sequence diagrams" (section 4.2.1) which
one may use to check whether those "phases" in the course of
communicating "a command" can get expressed by means of the SPI
message submission API (struct spi_message, and struct
spi_transfer).  Currently "use DDR", "use single/dual/quad data
lines", "append dummy _bits_" appear to be missing, but might get
added similar to the existing "control the CS line".

The previous discussion suggests that we
- need to express the enhanced modes of SPI communication in
  terms of SPI message submission data structures (I believe that
  his can be done with a few straight forward extensions which
  remain neutral to existing setups)
- make SPI masters (controller drivers) support those optional
  additional features _if_ the hardware supports it (read: do
  nothing for existing drivers, and only add optional support to
  new drivers)
- announce the SPI master's optional support for enhanced
  features (do we have such a query API already? or is this
  another leap in quality for SPI?  I think bit order and SPI
  modes 0-3 may already get matched but are not explicitly
  queried)
- make SPI slave drivers optionally query those master
  capabilities (plus other sources of configuration information)
  before they may adjust the SPI messages which they create and
  emit (which again is to do nothing for all SPI slaves, except
  for another translation layer in those MTD drivers which happen
  to use SPI for communication to the chip)

The point is that the M25P80 driver needs to get split into what
is currently there (flash chip handling, detection of features
and geometry), plus a translation layer which maps "flash chip
access" level operations (erase/write/read) to specific "SPI
messages which carry out that access".

Consideration of optional features and adjusting the construction
of SPI messages (instruction opcodes, address field length,
delay/dummy flags, number of data lines, double data rate, et al)
all occur within that translation helper.  Because the flash chip
driver should not do this alone.  This helper later may even be
usable for other kinds of SPI slaves as well (or serve as a
template).

These enhanced modes of SPI communication may be inspired by or
may only now become visible because of flash chips, but they
should fit into the overall SPI setup and shall be re-usable for
other SPI slaves in the future.


[ potential "LUT" optimization, implementation details ]

Putting the "run this many dummy _bit_ cycles" at the "end" of a
partial transfer, like is done today for "delay for this many
microseconds", might help those controllers which want to get fed
a data pattern which automatically modifies characteristics of
subsequent data transmission.  But this is just an implementation
detail, another optional optimization (hopefully this "LUT" thing
is an option and not mandatory).

Implementing the "run this partial transfer and _then_ switch to
multiple data lines or double data rate" is another option which
may help better map those features to hardware implementations.

But I feel that these extensions need to remain isolated to
partial SPI message transfers or at the most to individual SPI
messages, and cannot get setup in advance nor should they apply
globally.  It's just not true that every SPI slave is a flash
chip.  If one of the slaves is a flash chip, no other slave needs
to be.  And even if there are several flash chips, potentially of
the same type or with similar capabilities, they need not be
connected in identical ways.

I certainly don't want the physical SPI communication to change
in arbitrary ways unexpectedly just because I happen to send a
random byte of data to an arbitrary slave that is attached to the
bus (like an EEPROM or LCD or any random sensor).  BTW I still
hope that I overestimate the hardware implementation's greed
(haven't checked the QuadSPI controller reference manual).  This
LUT feature should be optional, and everything that may be
changed in automatic ways should be adjustable by software in the
transfer setup phase as well -- without being forced to transfer
any data as a trigger.


There's a question whether an SPI master's
.transfer_one_message() callback (or common code which dispatches
messages to SPI controllers) should actively reject messages
which require features that aren't supported by the controller.
Or whether these flags need to tell "required, reject if not met"
and "optional, please use if available" apart.

And one may think of multi data line communication with arbitrary
numbers of lines and asymetric Rx/Tx numbers as well.  It may not
apply to current SPI implementations, but I've seen UARTs which
can bundle 1+4 or 2+3 or 3+2 or 4+1 lines, in addition to the
regular 1x RX and 1x TX setup.

It's essential to represent dummy cycles in terms of _bit_
numbers, since full bytes no longer universally apply (think:
software bitbang, not everything is done in hardware).  And there
are SPI controllers or slaves (can't remember who implemented it)
where the presence of dummies is known, yet their number isn't,
and the end of dummies and start of payload gets determined from
a dummy data byte pattern.  Is this generic enough a feature to
get represented in the SPI message submission API?


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
