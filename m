From: angus.clark@st.com (Angus Clark)
Date: Thu, 5 Dec 2013 14:35:47 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20131204184405.GE9468@ld-irv-0074.broadcom.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com>
 <1386082273.18201.61.camel@shinybook.infradead.org>
 <20131204184405.GE9468@ld-irv-0074.broadcom.com>
Message-ID: <52A08F43.6060307@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On 12/04/2013 06:44 PM, Brian Norris wrote:
> On this topic, I have one more stick to throw on this fire; I have some
> Broadcom hardware that consists of two pieces:
> 
>   (1) a true SPI controller, with single-line-I/O and
>   (2) a Serial Flash controller that can accelerate flash read, using
>       dual/quad I/O.

We support one platform with properties similar to the hardware you describe,
and such a hybrid configuration was in mind when I was thinking about the
spi-nor framework.  I am not sure how well this will come across over email, but
I envisage something like this:

                             spi-nor
                                |
                                v
                          [spi-nor-xfer]
                                |
         ------------------------------------------------
        |                       |                        |
        v                       v                        v
   spi-wrapper (<------)  hybrid-driver          serial-flash-driver
        |                       |                        |
      [SPI]                     |                        |
        |                       |                        |
        v                       |                        |
generic-spi-driver              |                        |
        |                       |                        |
        v                       v                        v
[generic-SPI-Cntrl]   [SPI-Flash-Read Cntrl]   [SPI-Flash-Controller]

The 'spi-nor' layer is responsible for Serial Flash domain knowledge, and how to
generate 'spi-nor-xfer' messages.  The 'spi-wrapper' would provide an interface
to the generic SPI framework, flattening the 'spi-nor-xfer' message to standard
SPI calls.  The combination of 'spi-nor' and 'spi-wrapper' should achieve what
we have today for the m25p80 driver.  The 'serial-flash-driver' in the example
provides an implementation for a dedicated Serial Flash Controller, making use
of the spi-nor-xfer semantics where required.  The 'hybrid-driver' could use the
'spi-wrapper' implementation for write and erase hooks, and optimised
implementations for read hooks.

[...]
> I mostly bring this up, though, because it is an example of hardware
> that
> 
>    (a) can operate as a true SPI device (hardware (1) can handle generic
>        SPI transfers), but
>    (b) requires knowledge of the details of SPI flash in order to get
>        optimal usage out of the acceleration from (2).
> 
> In my book, point (a) and (b) hold some bearing over the question of
> "where should this SPI NOR framework live", because it is reasonable
> that a single driver for this hardware should be able to handle either
> true SPI devices or accelerated SPI-NOR flash.
> 

Yes, I agree.  At present, within the m25p80 driver, the knowledge of how to
drive Serial Flash devices is entwined with an implementation that assumes a
pure SPI Controller.  Creating an additional layer of abstraction allows us to
separate the two issues, and write drivers that can make us of generic SPI
controllers, or take advantage of accelerated Serial Flash Controllers, or a
combination of both.

I realise it is going to take a significant effort to get this off the ground
and the framework will require some tuning to make sure it can accommodate the
eccentric range of hardware out there.  Unfortunately I am not in a position to
commit much time myself, although I will help advise where I can.  Ironically,
once the ST Bristol site closes next year, I will have lots of time available,
but no access to equipment!

Cheers,

Angus
