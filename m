From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 10:41:01 +0000
Subject: [PATCH v5 8/8] arm64: enforce x1|x2|x3 == 0 upon kernel entry as
 per boot protocol
In-Reply-To: <CAKv+Gu9txVbj0es3UfC5-qVgM0RX7Wc66dZfNw4BSO0diYc-mw@mail.gmail.com>
References: <1426690527-14258-9-git-send-email-ard.biesheuvel@linaro.org>
 <20150318181315.GH19814@leverpostej>
 <CAKv+Gu_Psdg1PGbW8mydKGGUvyW=F1D125VSTdABLQEOHMaTwQ@mail.gmail.com>
 <CAKv+Gu_f=e4UG1GmtFh7j8fvq67v94VA=FwgaxHV5rECx0Wf=Q@mail.gmail.com>
 <20150318185737.GJ19814@leverpostej>
 <CAKv+Gu-PX4cPz=yuFeRUbB3COc7jRvGuCYR7h_xLVuUv7A9CfA@mail.gmail.com>
 <20150318202430.GA17417@leverpostej>
 <CAKv+Gu-o4x1H1JnWfizTnr_+6MKEQbMXL3yEzT-LggvgM6V0QQ@mail.gmail.com>
 <20150319103551.GA18473@leverpostej>
 <CAKv+Gu9txVbj0es3UfC5-qVgM0RX7Wc66dZfNw4BSO0diYc-mw@mail.gmail.com>
Message-ID: <20150319104100.GB18473@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> Does it matter at all that __inval_cache_range() will mostly end up
> >> doing a civac for the whole array, since it uses civac not ivac for
> >> both non-cachelined aligned ends of the region, and the typical
> >> cacheline size is larger then the size of the array? Couldn't that
> >> also clobber what we just wrote with a stale cacheline?
> >
> > Yes, though only if the memory were outside the footprint of the loaded
> > Image (which per the boot protocol should be clean to the PoC).
> >
> > So I guess we should move the boot_regs structure back into head.S so it
> > doesn't fall outside
> >
> 
> OK that means .data should be fine too. __cacheline_aligned variables
> are put into the .data section, so let me use that instead (.bss gets
> cleared after anyway, that is why i added the __read_mostly initially)

Great. Using __cachelign_aligned sounds good to me.

Mark.
