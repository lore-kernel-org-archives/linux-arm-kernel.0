From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Jul 2016 14:38:31 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <a90e1e01-b0c8-f57b-ada5-835f9d5736bf@linaro.org>
References: <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <ce78f577-d14a-7b12-c96f-a6ebd8866283@linaro.org>
 <20160726175447.GA28376@leverpostej>
 <a90e1e01-b0c8-f57b-ada5-835f9d5736bf@linaro.org>
Message-ID: <20160727133831.GD17195@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 12:19:59PM +0100, Daniel Thompson wrote:
> On 26/07/16 18:54, Mark Rutland wrote:
> >On Tue, Jul 26, 2016 at 10:50:08AM +0100, Daniel Thompson wrote:
> >>On 25/07/16 18:13, Catalin Marinas wrote:
> >>>You get more unexpected side effects by not saving/restoring the whole
> >>>stack. We looked into this on Friday and came to the conclusion that
> >>>there is no safe way for kprobes to know which arguments passed on the
> >>>stack should be preserved, at least not with the current API.
> >>>
> >>>Basically the AArch64 PCS states that for arguments passed on the stack
> >>>(e.g. they can't fit in registers), the caller allocates memory for them
> >>>(on its own stack) and passes the pointer to the callee. Unfortunately,
> >>>the frame pointer seems to be decremented correspondingly to cover the
> >>>arguments, so we don't really have a way to tell how much to copy.
> >>>Copying just the caller's stack frame isn't safe either since a
> >>>callee/caller receiving such argument on the stack may passed it down to
> >>>a callee without copying (I couldn't find anything in the PCS stating
> >>>that this isn't allowed).
> >>
> >>The PCS[1] seems (at least to me) to be pretty clear that "the
> >>address of the first stacked argument is defined to be the initial
> >>value of SP".
> >>
> >>I think it is only the return value (when stacked via the x8
> >>pointer) that can be passed through an intermediate function in the
> >>way described above. Isn't it OK for a jprobe to clobber this
> >>memory? The underlying function will overwrite whatever the jprobe
> >>put there anyway.
> >>
> >>Am I overlooking some additional detail in the PCS?
> >
> >I suspect that the "initial value of SP" is simply meant to be relative to the
> >base of the region of stack reserved for callee parameters. While it also uses
> >the phrase "current stack-pointer value", I suspect that this is overly
> >prescriptive.
> 
> I don't think so. Whilst writing my reply of yesterday I forced
> stacked arguments by creating a function with nine arguments (rather
> than large values). The ninth argument is, as expected, passed to
> the callee based on the value of the SP.

Ah. I'd failed to fully appreciate the distinction between large
structures (which get converted to pointers), and basic argument types
(including those converted pointers).

For basic argument types, I think you're right, and my wording above is
wrong.

However, for (large enough) structures I don't think we have any
guarantee as to their location.

Sorry for the confusion there!

Mark.
