From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 13 Sep 2016 16:52:21 +0100
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
In-Reply-To: <9969568a-f969-d904-52b3-14f80c3abec4@redhat.com>
References: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
 <dad2e7cc-f8cb-4e33-99c7-66effa7a6f5e@redhat.com>
 <20160909152047.GA3958@e103592.cambridge.arm.com>
 <d7fa9069-f952-0642-9668-2fea640cdb20@redhat.com>
 <20160912111749.GB3958@e103592.cambridge.arm.com>
 <57D6C33D.9020003@arm.com>
 <20160912153015.GD3958@e103592.cambridge.arm.com>
 <9969568a-f969-d904-52b3-14f80c3abec4@redhat.com>
Message-ID: <20160913155151.GA1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 11:28:21AM +0200, Florian Weimer wrote:
> On 09/12/2016 05:30 PM, Dave Martin wrote:
> >On Mon, Sep 12, 2016 at 04:01:17PM +0100, Szabolcs Nagy wrote:
> >>i assume the kernel can avoid saving SVE regs when
> >>they are not used by the process.
> >
> >I can (and do), in my patches (not posted yet).
> >
> >The real issue here is that a recently updated shared library might be
> >optimised to use SVE, where the program using it is an older, SVE-
> >unaware binary.
> >
> >(think of an optimised math library using some new fancy SVE-based
> >number crunching internally).
> 
> In my little world, binaries are expected to do run-time CPU feature
> discovery and fall back to the baseline ABI if the system does not support
> ABI extensions.  This means that a personality flag can disable the
> extension, the optimized math libraries run with the slower baseline code
> instead, and the rest of the application sees the expected kernel interface.
> 
> From this perspective, it is quite important that it is possible to get
> legacy applications running on newer hardware, preferably with out wrapping
> them in a dedicated VM.
> 
> I understand that there are other environments were this is less of a
> concern, but I also believe that the age of an architecture factors less
> into this than one might want.

Agreed.  I'll need to think some more about how this should work in
general.

This series by itself doesn't change the ABI unless something allocates
enough signal frame data to exceed the historical frame size -- which
for now cannot happen.

What I may do is split off the extra_context part of the series (without
which the signal frame never grows).

SVE will still fit if the vector length is below a certain limit.

Cheers
---Dave
