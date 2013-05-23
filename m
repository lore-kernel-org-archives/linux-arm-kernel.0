From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 23 May 2013 19:51:46 +0200
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <1369322904.4142.36.camel@weser.hi.pengutronix.de>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <201305221305.09579.marex@denx.de> <201305230920.18200.jbe@pengutronix.de>
 <201305231648.17356.marex@denx.de>
 <1369322904.4142.36.camel@weser.hi.pengutronix.de>
Message-ID: <519E5732.1040800@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/05/2013 17:28, Lucas Stach wrote:
> Am Donnerstag, den 23.05.2013, 16:48 +0200 schrieb Marek Vasut:
>> Dear Juergen Beisert,
>>
>>> Hi Marek,
>>>
>>> Marek Vasut wrote:
>>>>>> i2c slowness is a different issue.
>>>>> Same happens here for my i.M23 based platform. It seems the PIO mode
>>>>> does not work, or at least not like it works on a i.MX28. Each short
>>>>> transfer needs about one second (without an error message) but does
>>>>> not send anything on the I2C lines.
>>>>>
>>>>> I need the following patches to make I2C master work within a 3.10-rc2
>>>>> kernel:
>>>>>
>>>>> Subject: [PATCH] I2C/MXS: distinguish i.MX23 and i.MX28 based I2C
>>>> I'm all for it, but then ... won't it be better if you actually fixed the
>>>> PIO and mixed-mode on MX23 instead of implementing such hack?
>>> If the PIO mode or my patch is a hack depends on the point of view: Lucas
>>> told me the PIO mode is *mentioned* but *not specified* in the
>>> i.MX23/i.MX28 datasheets.
>> The PIO works the same way DMA does -- set up bits and then pump data into the 
>> DATA register. 
>>> So, the PIO mode seems to depend on some undocumented status bits in the
>>> i.MX28 I2C controller implementation.
>> How would DMA work then if it used undocumented registers ? It's in the 
>> documentation, just read it or ask FSL ;-)
>>
> While the PIO mode might use the same controller mechanisms as the DMA
> mode, PIO mode is _not_ a documented mode of operation for the i.MX23.
>
> To quote the i.MX28 RM: "The I2C block on the i.MX28 supports a new PIO
> mode or soft-DMA mode.", which implies the PIO mode to be a new mode of
> operation not found on earlier i.MX SoCs.
> The doc is slightly fuzzy here as the i.MX23 RM in contrary states:
> "Short transmission (up to three bytes plus address) can be easily
> triggered using only PIO operations, i.e., no DMA setup required." But
> again it's not a documented mode of operation, i.MX23 doc only describes
> the DMA mode.
>
> So while we _might_ be able to get the PIO mode to work on the i.MX23
> there is nothing in the doc stating that it's even meant to work. Even
> while PIO and DMA mode use the same internal mechanisms, there's still
> plenty of opportunities of fail in there. After all PIO mode relies on
> reading a debug register in the course of normal operation.
>
> Only more extensive experimentation could show if we are in fact able to
> make it work, a first shot of using PIO mode on MX23 failed, so it might
> as well be that Juergens quick fix is correct and we have to disable PIO
> mode on MX23 altogether. That said please stop slapping the word "hack"
> over this patch until proven otherwise.

Still, Fabio and I have been experiencing the one second delay on
i.mx28. From my experience, it appeared between 3.7 and 3.9, see:
http://www.spinics.net/lists/linux-i2c/msg11985.html. I still didn't
take the time to investigate more yet but it confirms that PIO mode is
working on i.mx28 though with an annoying delay.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
