From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 10 Jan 2011 10:59:26 -0600
Subject: [PATCH] ep93xx: add framebuffer support to edb93xx boards
In-Reply-To: <AANLkTi=uw2sxizgDBSnDQVMaokikirDQgxt1w6sP4C05@mail.gmail.com>
References: <0D753D10438DA54287A00B027084269764C41240B9@AUSP01VMBX24.collaborationhost.net>
	<AANLkTi=uw2sxizgDBSnDQVMaokikirDQgxt1w6sP4C05@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B027084269764CD96B587@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, January 08, 2011 12:53 PM, Martin Guy wrote:
> On Fri, Jan 7, 2011 at 11:38 PM, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>> The ep9307, ep9312, and ep9315 variants of the ep93xx processor include the
>> raster engine needed for framebuffer support.
>>
>> This allows the EDB93xx boards with those processors to use the framebuffer
>> driver.
>>
>> Tested on an EDB9307A with the following kernel parameters:
>> ? ? ? ?video=640x480-16 at 60
>> ? ? ? ?video=1024x768-16 at 60
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> The code looks good, but there are hardware bugs in the EP93XX that
> make the screen image jump a few pixels to the right once every few
> seconds.  We found that 800x600-16 and 1024x768-8 were the highest
> modes that are stable.

Hardware bugs in the EP93XX... No... ;-)

> Did you find 1024x768-16 to be stable, say when running X and moving a
> window? The effect was most visible on a phosphor CRT, less noticeable
> on an LCD.

I don't have any use for X on the EP93XX so, no I have not tested that.
My app uses the SDL library and has very little actual "motion" going on
so the screen looks pretty stable in my tests.

I have noticed some timing issues with the framebuffer driver, the requested
60Hz refresh is being reported as either 59 or 61Hz on the display, but I
haven't taken the time to look into it yet.

Could the problem you are seeing just be a bandwidth limitation?  Have you
tried changing the AHB master priority order with the SysCon BysMstrArb
register (0x8093_0054)?  The default priority (00) has the following order:

1 - Raster Cursor
2 - MAC
3 - USB
4 - DMA
5 - ARM920T
6 - Raster

The other priority's put the Raster first and shuffle the others around
various ways.

Regards,
Hartley
