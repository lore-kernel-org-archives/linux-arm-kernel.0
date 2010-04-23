From: vernoninhand@gmail.com (Vernon Sauder)
Date: Fri, 23 Apr 2010 12:55:20 -0400
Subject: SPI trouble on Colibri 270 (PXA)...
In-Reply-To: <4BD05ED1.4020806@viketoft.se>
References: <4BCD96F0.5010506@viketoft.se>	<q2sf17812d71004200614n58fb6cabgd0686d3ab6788b23@mail.gmail.com>	<4BCDC645.5090001@viketoft.se>	<201004211144.41781.marek.vasut@gmail.com>	<j2tf17812d71004210347gd9ad8530w409b8d6e3a732c1c@mail.gmail.com>	<p2y56d259a01004210411ie5f4b723n6cfd25e96333813@mail.gmail.com>	<4BCEF3D4.2030704@viketoft.se>	<g2xf17812d71004210607n4f3d82f2m4712d3bb97ef4924@mail.gmail.com>
	<4BD05ED1.4020806@viketoft.se>
Message-ID: <4BD1D0F8.60705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jakob Viketoft wrote, On 04/22/2010 10:36 AM:
> Eric Miao wrote:
>> On Wed, Apr 21, 2010 at 8:47 PM, Jakob Viketoft <jakob@viketoft.se>
>> wrote:
>>> Martin Guy wrote:
>>>> On 4/21/10, Eric Miao <eric.y.miao@gmail.com> wrote:
>>>>
>>>>>  I thought we were talking about SPI?
>>>> We are. It affects boards that have a single SD/MMC card on the SPI
>>>> bus and use SFRMOUT as the chip select line, which impacts how the SPI
>>>> driver needs to handle multi-part messages without dropping CS between
>>>> transfers
>>> Does this mean that this is a know issue with the pxa2xx spi driver?
>>> At the
>>> moment I'm rather pressed for time and have instead opted for
>>> compressing
>>> the two transfers (read command and actual read) into one.
>>
>> I'm expecting this to be correct code, i.e. by combining read command
>> transfer and actual read transfer into a single message, with .cs_change
>> indicating that CS not changed during transfer. No?
> 
> The original code currently combines the two transfers in one message as
> you say (leaving CS asserted unless cs_change is set). However, I don't
> know if it's a problem with scheduling or that the interrupt takes too
> long to serve, but on my platform the two transfers (in the same
> message) doesn't go back-to-back as they should and CS gets deasserted
> in the middle. Thus I have combined the two transfers into one and the
> message only hold this single transfer. Now things work at my end, but
> it's annoying that I don't have time to track down the real issue at the
> moment...
> 
>     /Jakob
> 

As part of this thread:
http://permalink.gmane.org/gmane.linux.kernel.spi.devel/1517
I added the following note to Documentation/spi/pxa2xx. I have not
checked to see if the patch hit mainline. Is this part of the answer to
your question?

> +NOTE: the SPI driver cannot control the chip select if SSPFRM is used, so the
> +chipselect is dropped after each spi_transfer.  Most devices need chip select
> +asserted around the complete message.  Use SSPFRM as a GPIO (through cs_control)
> +to accomodate these chips.

That was my solution to using the pxa2xx SPI with M25Pxx flash.

-- 
Regards,
 Vernon Sauder
 (: !Have a great day! :)
