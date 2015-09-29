From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Sep 2015 13:17:20 +0200
Subject: [PATCH v2 1/9] dmaengine: st_fdma: Add STMicroelectronics FDMA DT
 binding documentation
In-Reply-To: <20150929100440.GC16955@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <20150914081937.GF27591@x1>
 <20150929100440.GC16955@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <35211759.Jca4RWVLIS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 September 2015 11:04:40 Peter Griffin wrote:
> 
> "The hardware is identical, and different firmware is used to apply
>    it in different ways."
> 
> Which is the case with fdma. By encoding the "way you wish to apply it" into the
> compatible string, it causes problems if you want to change for example fdma0
> to do some other function other than audio.
> 
> You then require a DT update, (when the hardware hasn't changed, just the
> firmware) which is the same problem as using the filename directly in DT.
> 
> Therefore I believe it is important that the DT binding does *not* encode the
> way the hardware is to be applied into the binding in *any* way, and defers this
>  decision to the driver.
> That is the rationale / reasoning behind choosing the fdma instance number.
> 
> Assuming you agree with my arguments above, then the choice becomes between 
> having a fdma instance DT property, or having lots of compatibles where the only
> difference is the appending of the instance number. I think out of the two I prefer
> my original approach.
> 
> Any thoughts from the DT folks?

To me both approaches sound wrong: basing the firmware name on the instance
number requires that each instance is always used in the same way, which
is not guaranteed to be the case, and you correctly describe the problem with
using the compatible string for the firmware name if the driver for the FDMA
does not actually care what firmware is being used here.

Whatever code makes the decision as to how the FDMA is used should also
decide on the name of the firmware file. You can have a mapping in the
driver that contains the file names that are used by ST's distro, possibly
with a fallback mechanism that tries more meaningful names first.

	Arnd
