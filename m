From: eric@anholt.net (Eric Anholt)
Date: Wed, 10 Feb 2016 13:24:37 -0800
Subject: [PATCH 4/4] spi: bcm2835aux: fix CPOL/CPHA setting
In-Reply-To: <7621387.PU4Z2tGlUh@chaos-desktop>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-5-git-send-email-stephanolbrich@gmx.de>
 <87a8n94e3x.fsf@eliezer.anholt.net> <7621387.PU4Z2tGlUh@chaos-desktop>
Message-ID: <871t8k9s2y.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephan Olbrich <stephanolbrich@gmx.de> writes:

> Am Tuesday 09 February 2016, 16:13:06 schrieb Eric Anholt:
>> stephanolbrich at gmx.de writes:
>> > From: Stephan Olbrich <stephanolbrich@gmx.de>
>> > 
>> > The auxiliary spi supports only CPHA=0 modes as the first bit is
>> > always output to the pin before the first clock cycle. In CPHA=1
>> > modes the first clock edge outputs the second bit hence the slave
>> > can never read the first bit.
>> > 
>> > Also the CPHA registers switch between clocking data in/out on
>> > rising/falling edge hence depend on the CPOL setting.
>> > 
>> > Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
>> > ---
>> > 
>> >  drivers/spi/spi-bcm2835aux.c | 10 +++++-----
>> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
>> > index b90aa34..169f521 100644
>> > --- a/drivers/spi/spi-bcm2835aux.c
>> > +++ b/drivers/spi/spi-bcm2835aux.c
>> > @@ -386,12 +386,12 @@ static int bcm2835aux_spi_prepare_message(struct
>> > spi_master *master,> 
>> >  	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
>> >  	
>> >  	/* handle all the modes */
>> > 
>> > -	if (spi->mode & SPI_CPOL)
>> > +	if (spi->mode & SPI_CPOL) {
>> > 
>> >  		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
>> > 
>> > -	if (spi->mode & SPI_CPHA)
>> > -		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
>> > -			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
>> > -
>> > +		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT;
>> > +	} else {
>> > +		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_IN;
>> > +	}
>> > 
>> >  	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
>> >  	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
>> 
>> (Note for other readers: A better name for CNTL0_CPHA_* would be
>> CNTL0_*_RISING).
>
> Should I rename them? 

Up to you.  I'm happy to see the work you've done fixing the driver
here, and I don't want to pile things on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160210/3685dd6e/attachment.sig>
