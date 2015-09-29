From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 29 Sep 2015 11:04:40 +0100
Subject: [PATCH v2 1/9] dmaengine: st_fdma: Add STMicroelectronics FDMA
 DT binding documentation
In-Reply-To: <20150914081937.GF27591@x1>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-2-git-send-email-peter.griffin@linaro.org>
 <51503956.PMFrWKUjxX@wuerfel>
 <20150912120752.GA19897@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150914081937.GF27591@x1>
Message-ID: <20150929100440.GC16955@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, 14 Sep 2015, Lee Jones wrote:

> > On Fri, 11 Sep 2015, Arnd Bergmann wrote:
> > 
> > > On Friday 11 September 2015 15:14:23 Peter Griffin wrote:
> > > > +- st,fdma-id	: Must contain fdma controller number
> > > 
> > > What for?
> > 
> > It is used by the driver to generate a unique firmware name.
> > Basically we need to know which controller instance we
> > are as each controller has a different firmware which needs
> > to be loaded.
> > 
> > Rob did say that having a index type property is undesirable
> > over here, see my reply at the bottom
> > http://www.spinics.net/lists/devicetree/msg92529.html.
> > 
> > However I can't think of any other useful properties we could add
> > to derive this information.
> 
> I wouldn't use a property at all.  Why not use the compatible string?
> 
> Who chooses the naming scheme of the firmware binary?

ST

> 
> Is there any reason they can't be:
> 
>   fdma_STiH407_audio.elf
>   fdma_STiH407_app.elf
>   fdma_STiH407_free_running.elf

Not sure, we could easily rename them locally. Getting ST to change
the firmware names in the stlinux distro might be harder.
My personal preference is to leave the firmware names "as is", unless
there is a real show stopper reason where we *have* to change them e.g.
we can't support all STi platforms with the same userspace because
the firmware filenames aren't unique enough.

> 
> Then you can have a different compatible for each:
> 
>   compatible = "st,stih407-fdma-mpe31-audio";
>   compatible = "st,stih407-fdma-mpe31-app";
>   compatible = "st,stih407-fdma-mpe31-free-running";

I think if you took the approach of only using the compatible
you would still need to use the fdma instance number
otherwise you end up with the same problems discussed in the 
"Firmware filename in DT" thread [1] e.g.

   compatible = "st,stih407-fdma-mpe31-0";
   compatible = "st,stih407-fdma-mpe31-1";
   compatible = "st,stih407-fdma-mpe31-2";

Specifically the problem is related to

"The hardware is identical, and different firmware is used to apply
   it in different ways."

Which is the case with fdma. By encoding the "way you wish to apply it" into the
compatible string, it causes problems if you want to change for example fdma0
to do some other function other than audio.

You then require a DT update, (when the hardware hasn't changed, just the
firmware) which is the same problem as using the filename directly in DT.

Therefore I believe it is important that the DT binding does *not* encode the
way the hardware is to be applied into the binding in *any* way, and defers this
 decision to the driver.
That is the rationale / reasoning behind choosing the fdma instance number.

Assuming you agree with my arguments above, then the choice becomes between 
having a fdma instance DT property, or having lots of compatibles where the only
difference is the appending of the instance number. I think out of the two I prefer
my original approach.

Any thoughts from the DT folks?

regards,

Peter.

[1] http://comments.gmane.org/gmane.linux.drivers.devicetree/133782
