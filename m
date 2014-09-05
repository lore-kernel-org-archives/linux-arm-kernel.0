From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 5 Sep 2014 17:21:56 +0300
Subject: [PATCH 2/2] spi: davinci: support adding delay between
 transmission
In-Reply-To: <20140822150644.GX24407@sirena.org.uk>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
 <1408634706-5762-3-git-send-email-grygorii.strashko@ti.com>
 <20140821182035.GM24407@sirena.org.uk> <53F74695.3010902@ti.com>
 <20140822150644.GX24407@sirena.org.uk>
Message-ID: <5409C704.5070303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

I'm very sorry for delayed replay.

On 08/22/2014 06:06 PM, Mark Brown wrote:
> On Fri, Aug 22, 2014 at 04:33:09PM +0300, Grygorii Strashko wrote:
>> On 08/21/2014 09:20 PM, Mark Brown wrote:
>>> On Thu, Aug 21, 2014 at 06:25:06PM +0300, Grygorii Strashko wrote:
> 
>>>> +- ti,davinci-spi-wdelay : delay between transmissions.
> 
>>> I don't understand why this is here - there is already standard support
>>> in the SPI core for client drivers specifying inter-transfer delays.  If
>>> there is a need to provide platform configuration for this in addition
>>> to that then it should also be a standard property, there is nothing
>>> device specific about these.
> 
>> Sorry, may be I've missed smth, because I was not able to find such common
>> property in SPI bindings document and code. Could you point me on, pls?
> 
> It's not a property, it's what the delay_usecs in the transfer does.
> There is no obvious reason to apply something like this unconditionally
> on every transfer in DT - either it's needed only at particular points
> in the transfer for device reasons (in which case the device driver
> needs to know about it) or we need some sort of association with what
> the device is doing since the way the client driver splits up transfers
> is entirely up to it.

I think we have some misunderstanding here :(
1) All new properties a optional and should be specified for SPI Slave devices
2) Seems we are talking using different terms:
- you referring to the term "transfers" - sequence of packets.
  Each packet is one transfer (array of words).
- while these new properties affect on "transmissions" - sequence of words.
  Each word is one transmission.

Below is timing diagram which shows, in general, how these new parameters affect
on words transmission over Keystone/Davinci SPI bus:

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


Also, below is additional information about properties which
are used in 5-pin mode (SPI_READY) to improve error detection
[OMAP-L138/da830 - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf]:

>- ti,davinci-spi-t2e-delay: t2e delay

Transmit-data-finished-to-SPIx_ENA-pin-inactive-time-out.
T2EDELAY is used in master mode only. It defines a time-out value
as a multiple of SPI clock before the SPIx_ENA signal has to become
inactive and after the CS becomes inactive. The SPI clock depends
on which data format is selected. If the slave device is missing
one or more clock edges, it is becoming desynchronized. Although
the master has finished the data transfer the slave is still
waiting for the missed clock pulses and the SPIx_ENA signal is
not disabled. The T2EDELAY defines a time-out value that triggers
the DESYNC flag, if the SPIx_ENA signal is not deactivated in time.
The DESYNC flag is set to indicate that the slave device did not
deassert its SPIx_ENA pin in time to acknowledge that it has
received all the bits of the sent character. The DESYNC flag is
also set if the SPI detects a deassertion of the SPIx_ENA pin even
before the end of the transmission.

>- ti,davinci-spi-c2e-delay: c2e delay

Chip-select-active-to-SPIx_ENA-signal-active-time-out. C2EDELAY
is used only in master mode and it applies only if the addressed
slave generates an SPIx_ENA signal as a hardware handshake response.
C2EDELAY defines the maximum time between the SPI activates the chip
select signal and the addressed slave has to respond by activating
the SPIx_ENA signal. 


> 
>>>> +- ti,davinci-spi-odd-parity : odd partity enabled
>>>> +   OR
>>>> +  ti,davinci-spi-even-parity : even parity enabled
> 
>>> What do these mean?
> 
>> Supported by OMAP-L138/da830:
>> "
>> SPIFMTn[23].PARPOL - Parity polarity: even or odd. PARPOL can be modified in privilege mode only.
>>   0 An even parity flag is added at the end of the transmit data stream.
>>   1 An odd parity flag is added at the end of the transmit data stream.
> 
> Why would these be specified in DT and not with runtime flags enabled by
> the device?  It looks like they affect the data stream generated by the
> controller so the client device needs to know about them; I'd expect
> that it's device driver would be controlling when they are enabled if
> the controller supports them.
> 

Could you clarify, pls - Do you mean that struct spi_device.mode and 
common SPI DT bindings should be extended to support this?


>>>> +- ti,davinci-spi-io-type: io type (check platform_data/spi-davinci.h)
> 
>>> The bindings should be independent of the kernel, the values need to be
>>> included here (and the defines moved to include/dt-bindings so they can
>>> be used when writing DTs).
> 
>> Allowed values here are:
>> #define SPI_IO_TYPE_INTR	0
>> #define SPI_IO_TYPE_POLL	1
>> #define SPI_IO_TYPE_DMA		2
> 
>> I'll update.
> 
> Now I see these it's not at all clear why this is configurable at all -
> I would expect the controller driver to automatically select the most
> appropriate scheme for the transfers it's doing in order to obtain the
> best performance rather than having a global switch for this.  For
> almost all devices the best results will be obtained by doing a mix of
> these modes.
> 
> Typically for each level of transfer there will be some minimal size
> below which it doesn't make sense to use that control type, for example
> it's common to only DMA if there's more than a FIFO worth of data to
> transfer.
> 

Ok. It can be dropped from DT

Best regards,
-grygorii
