From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 May 2014 13:33:14 +0100
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140519105405.GC5935@e102568-lin.cambridge.arm.com>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
 <53763DFC.8070309@arm.com> <20140516183915.GP22111@sirena.org.uk>
 <5379D594.2000200@arm.com>
 <20140519105405.GC5935@e102568-lin.cambridge.arm.com>
Message-ID: <20140519123314.GU12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 11:54:05AM +0100, Lorenzo Pieralisi wrote:

> As to what should we use as cluster id, honestly I do not know.

> I am quite tempted to use just three affinity levels for the moment
> and fix it when need arises, after all on ARM we have aff2 completely
> unused at the moment for the non-SMT systems (ie all ARM SMP systems in
> the mainline) and we are not coalescing affinity 2 into affinity 1 in
> any way.

> So either you ignore aff3, or can do something like that (non-SMT):

> cluster_id = MPIDR_EL1[39:32] << 16 | MPIDR_EL1[23:16] << 8 | MPIDR_EL1[15:8]

Which is roughly what the original code that you were worried about did
IIRC?  It seems silly to ignore the higher affinity levels since it's
trivial to look at them and means the kernel will@least split
everything into clusters if it does encounter some hardware that uses
them as opposed to merging those distinguished only by the higher
affinity levels.

> Also please remove the warning on the missing topology information, if
> we fall back to MPIDR_EL1 we will always have a topology of sorts, as
> borked as it might be, so that warning becomes useless, ie it is never
> triggered.

I'll add something to this patch - the warning is needed if the DT code
gets merged without this and it seems this one still going round the
loop.  :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/36dee615/attachment.sig>
