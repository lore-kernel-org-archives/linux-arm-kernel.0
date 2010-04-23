From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 24 Apr 2010 07:40:28 +0800
Subject: SPI trouble on Colibri 270 (PXA)...
In-Reply-To: <4BD1FB9B.9030902@viketoft.se>
References: <4BCD96F0.5010506@viketoft.se> <4BCDC645.5090001@viketoft.se>
	<201004211144.41781.marek.vasut@gmail.com>
	<j2tf17812d71004210347gd9ad8530w409b8d6e3a732c1c@mail.gmail.com>
	<p2y56d259a01004210411ie5f4b723n6cfd25e96333813@mail.gmail.com>
	<4BCEF3D4.2030704@viketoft.se>
	<g2xf17812d71004210607n4f3d82f2m4712d3bb97ef4924@mail.gmail.com>
	<4BD05ED1.4020806@viketoft.se> <4BD1D0F8.60705@gmail.com>
	<4BD1FB9B.9030902@viketoft.se>
Message-ID: <j2vf17812d71004231640raaf0cc04zcb715ee9c15bc4c4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 24, 2010 at 3:57 AM, Jakob Viketoft <jakob@viketoft.se> wrote:
> Vernon Sauder wrote:
>>
>> Jakob Viketoft wrote, On 04/22/2010 10:36 AM:
>
> <...>
>>>
>>> The original code currently combines the two transfers in one message as
>>> you say (leaving CS asserted unless cs_change is set). However, I don't
>>> know if it's a problem with scheduling or that the interrupt takes too
>>> long to serve, but on my platform the two transfers (in the same
>>> message) doesn't go back-to-back as they should and CS gets deasserted
>>> in the middle. Thus I have combined the two transfers into one and the
>>> message only hold this single transfer. Now things work at my end, but
>>> it's annoying that I don't have time to track down the real issue at the
>>> moment...
>>>
>>> ? ?/Jakob
>>>
>>
>> As part of this thread:
>> http://permalink.gmane.org/gmane.linux.kernel.spi.devel/1517
>> I added the following note to Documentation/spi/pxa2xx. I have not
>> checked to see if the patch hit mainline. Is this part of the answer to
>> your question?
>>
>>> +NOTE: the SPI driver cannot control the chip select if SSPFRM is used,
>>> so the
>>> +chipselect is dropped after each spi_transfer. ?Most devices need chip
>>> select
>>> +asserted around the complete message. ?Use SSPFRM as a GPIO (through
>>> cs_control)
>>> +to accomodate these chips.
>>
>> That was my solution to using the pxa2xx SPI with M25Pxx flash.
>>
>
> Yes, I saw that note in the documentation. Unfortunately it wasn't what was
> causing my problem. I think a code patch has been applied to control ?the
> SSPFRM as a gpio through the .gpio_cs option, but this seem to be missing
> from the documentation.
>

You want to configure the SSPFRM pin as generic GPIO with MFP API
as well, if you want to set that pin as .gpio_cs.

> From the sound of it, I think I'm running into the same kind of trouble as
> shown by the SPI controller on the EP93xx.
>
> ? ? ? ?/Jakob
>
