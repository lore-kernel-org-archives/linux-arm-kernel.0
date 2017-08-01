From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Aug 2017 15:57:04 +0100
Subject: [PATCH] arm64: acpi/gtdt: validate CNTFRQ after having enabled
 the frame
In-Reply-To: <20170801113120.GD9347@leverpostej>
References: <20170724151053.17769-1-ard.biesheuvel@linaro.org>
 <20170801105345.GB9347@leverpostej>
 <CAKv+Gu8jD_oJV138qWGQm2dOnqJTSxSNNQ7xFCPtb4efyR9n1Q@mail.gmail.com>
 <20170801113120.GD9347@leverpostej>
Message-ID: <20170801145704.GA27566@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 12:31:21PM +0100, Mark Rutland wrote:
> On Tue, Aug 01, 2017 at 12:09:32PM +0100, Ard Biesheuvel wrote:

> > The point here is that CNTFRQ cannot differ between frames. It either
> > returns the value of the base frame or RES0.
> 
> Sorry; you had mentioned this before, and I had forgotten.
> 
> I'm under the impression that the ARM ARM may be misleading (and
> potentially erroneous) in that regard. In the past I had been told that
> each instance of a CNTFRQ register was independent, and each must be
> writeable for system initialization.

FWIW, I took a look at a Juno R1 with a DSTREAM.

I can independently configure CNTCTLBase.CNTFRQ and CNTBase1.CNTFRQ,
with the latter being RW from the Non-secure side. It seems that
firmware I'm using doesn't bother to initialise either. :/

So regardless of what the architectural intent is, there exist platforms
where these can differ.

I'll try to fix up the patch accordingly, to check all instances.

Thanks,
Mark.
