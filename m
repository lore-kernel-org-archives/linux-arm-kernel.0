From: martin@sperl.org (Martin Sperl)
Date: Thu, 11 Feb 2016 17:19:45 +0100
Subject: [PATCH 4/4] spi: bcm2835aux: fix CPOL/CPHA setting
In-Reply-To: <10547867.CcbLVQlgyH@chaos-desktop>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <87a8n94e3x.fsf@eliezer.anholt.net>
 <16A848EA-6E08-48C4-B3DD-DF27333B7458@sperl.org>
 <10547867.CcbLVQlgyH@chaos-desktop>
Message-ID: <50D0ECA7-8116-4248-AC85-6E1C8002A185@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 11.02.2016, at 17:05, Stephan Olbrich <stephanolbrich@gmx.de> wrote:
> 
> Martin,
> 
> Am Thursday 11 February 2016, 16:25:43 schrieb Martin Sperl:
>>> On 10.02.2016, at 01:13, Eric Anholt <eric@anholt.net> wrote:
>>> 
>>> stephanolbrich at gmx.de writes:
>>>> From: Stephan Olbrich <stephanolbrich@gmx.de>
>>>> 
>>>> The auxiliary spi supports only CPHA=0 modes as the first bit is
>>>> always output to the pin before the first clock cycle. In CPHA=1
>>>> modes the first clock edge outputs the second bit hence the slave
>>>> can never read the first bit.
>>>> 
>>>> Also the CPHA registers switch between clocking data in/out on
>>>> rising/falling edge hence depend on the CPOL setting.
>>>> 
>>>> Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
>>>> ---
>>>> drivers/spi/spi-bcm2835aux.c | 10 +++++-----
>>>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>>> 
>>>> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
>>>> index b90aa34..169f521 100644
>>>> --- a/drivers/spi/spi-bcm2835aux.c
>>>> +++ b/drivers/spi/spi-bcm2835aux.c
>>>> @@ -386,12 +386,12 @@ static int bcm2835aux_spi_prepare_message(struct
>>>> spi_master *master,>> 
>>>> 	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
>>>> 	
>>>> 	/* handle all the modes */
>>>> 
>>>> -	if (spi->mode & SPI_CPOL)
>>>> +	if (spi->mode & SPI_CPOL) {
>>>> 
>>>> 		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
>>>> 
>>>> -	if (spi->mode & SPI_CPHA)
>>>> -		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
>>>> -			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
>>>> -
>>>> +		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT;
>>>> +	} else {
>>>> +		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_IN;
>>>> +	}
>>>> 
>>>> 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
>>>> 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
>>> 
>>> (Note for other readers: A better name for CNTL0_CPHA_* would be
>>> CNTL0_*_RISING).
>>> 
>>> I think you're right about not actually supporting CPHA.  I don't see
>>> wany way to keep bit 1 out lasting through the first full clock cycle.
>>> I think Stefan's right that we should drop CPHA from MODE_BITS
>>> (actually, MODE_BITS would be nicer if we just merged it into its one
>>> user, I think).
>>> 
>>> However, this hunk appears to be correct and would fix the timing of our
>>> data going out in the CPOL=0 case and of sampling IN data for CPOL=1.
>> 
>> Are you sure that CPHA is not working?
>> 
>> I have used the following to test all combinations:
>> for C in "" "-C"; do
>>  for O in "" "-O"; do
>>   for H in "" "-H"; do
>>    spidev_test -vD /dev/*.1 $H $O -p "\x00\x82\x00" -s 1000000;
>>   done
>>  done
>> done
>> 
>> I have tested with the 4.5-rc3 kernel without any of your patches.
>> 
>> And looked at the logic-analyzer: I see distinct waveform pattern
>> for clk and data for all events!
> 
> The problem I see, is not that there is no waveform but that it has the wrong 
> timing.
> I'll make an example:
> Data is 0xAA,0xFF, CPOL=1, CPHA=1
> What happens is this:
> CS goes active and MOSI goes high (first bit in 1)
> After a short time, SCLK goes from low to high and MOSI goes to low (second 
> bit is 0)
> Then SCLK goes low (sampling data)
> Then SCLK goes high and MOSI goes high (third bit is 1) 
> and so on.
> At the end with the last rising edge of SCLK MOSI goes to low and stays there 
> while SCLK goes to low and then CS to inactive.
> 
> So the slave has no chance to get the first bit but gets an additional 0 at the 
> end.
> It may not be easy visible with 0x00,0x82,0x00 as data, so could you repeat 
> your test with 0xAA,0xFF if you see the same as I do or not?

I did retest also with 0x81,0x00,0x81 and saw my expected behavior - but maybe
me understanding of those modes is wrong.

I will send you the images for the pattern I have generated with 
0x81, 0x00, 0x81 as a personal email.

Martin
