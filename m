From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 9 Sep 2014 13:09:27 -0400
Subject: [PATCH v2] spi: davinci: add support for adding delay between
 word's transmission
In-Reply-To: <20140909165555.GD2601@sirena.org.uk>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
 <20140909165555.GD2601@sirena.org.uk>
Message-ID: <540F3447.3020609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2014 12:55 PM, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 07:07:31PM +0300, Grygorii Strashko wrote:
>
>> - ti,spi-c2t-delay: Chip-select-active-to-transmit-start delay
>> 	(SPIDELAY.C2TDELAY)
>
>> - ti,spi-t2c-delay: Transmit-end-to-chip-select-inactive delay
>> 	(SPIDELAY.T2CDELAY)
>
> Now I look at these they look very much like the standard delay feature
> that the SPI subsystem has already - are they?
Mark,

As Grygorii explained in previous postings (reproduced below), these 
delays are handled by the SPI hardware on Keystone and affect the delay 
between successive word tranmssion and has nothing to do with the delay 
you are talking about. Isn't the standard delay you mention here is 
between successive packets send down to the lower level driver (in this 
case spi-davinci.c) ?

Murali

Below is timing diagram which shows, in general, how these new 
parameters affect on words transmission over Keystone/Davinci SPI bus:

              +-+ +-+ +-+ +-+ +-+                           +-+ +-+ +-+
SPI_CLK      | | | | | | | | | |                           | | | | | |
   +----------+ +-+ +-+ +-+ +-+ +---------------------------+ +-+ +-+ +-

SPI_SOMI/SIMO+-----------------+                           +-----------
   +----------+ word1           +---------------------------+word2
              +-----------------+                           +-----------
                                           WDELAY
                                          <--------->
                                         +           +
SPI_CS                                  |           |
   +----+                                +-----------+
        |                                |           |
        +-----+-----------------+--------+           +-----+------------
        |     |                 |        |           |     |
        +     +                 +        |           +     +
         <--->                   <------>             <--->
        C2TDELAY                 T2CDELAY            C2TDELAY

Where:
         WDELAY - Delay in between transmissions
	C2TDELAY - Chip-select-active-to-transmit-start-delay
	T2CDELAY - Transmit-end-to-chip-select-inactive-delay
