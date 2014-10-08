From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Oct 2014 21:56:28 +0100
Subject: [PATCH] arm64: topology: Fix handling of multi-level cluster
 MPIDR-based detection
In-Reply-To: <20141003163715.GB13939@e102568-lin.cambridge.arm.com>
References: <1408462379-27968-1-git-send-email-broonie@kernel.org>
 <CAFpQJXWkL_ge8XT9y6vSNwgQgXcvQtUh4PaWxdH1dK0QhFWu2A@mail.gmail.com>
 <20141003163715.GB13939@e102568-lin.cambridge.arm.com>
Message-ID: <20141008205628.GO4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 05:37:16PM +0100, Lorenzo Pieralisi wrote:

> To be honest with you all I would have preferred to sort this out with
> DT, that's already doable now without this patch.

We'd still have to make sure there's a complete topology binding for
ACPI and get through standardisation if any changes are needed.  I guess
it's probably mostly OK as the scenarios should all be shared with x86
systems but I've not looked to see if some of the subsetting that's
being done for ACPI on ARMv8 causes issues.

> Having said that, for platforms setting MPIDR_EL1 to reasonable values,
> I think that's what we should do, squash the upper MPIDR levels (for
> the non SMT case too). Please stick a proper comment for that to the code.
> We can always rely on DT to fix other cases that can't be treated
> properly with code above.

OK, I'll send a patch.

> I took some time to think about that, since I am aware of tools (ie
> powertop) taking the socket id value verbatim, which can become a big
> number when we squash it. Since it is not a userspace API (or at least
> it is written nowhere that the socket id value must be a sequential,
> monotonic value starting from 0 and and on top of that that's an arch specific
> id that as far as I know must only be unique) I think the change above (plus
> additional code for non-SMT case) is acceptable.

More than that, it's explicitly documented as being intended to be the
hardware platform's ID in cputopology.txt.  I've no idea where this
assumption that the numbers have to be sequential came from but it's
been such a source of pain :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141008/ac38c69e/attachment.sig>
