From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 May 2014 19:39:15 +0100
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <53763DFC.8070309@arm.com>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
 <53763DFC.8070309@arm.com>
Message-ID: <20140516183915.GP22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 05:34:04PM +0100, Sudeep Holla wrote:

> This is broken, IIRC Lorenzo commented on this in the previous version of the
> patch.

Could you please be specific?  Lorenzo was concerned about overflow but
that ought to be addressed here.

> Take a simple example of system with 2 Quad core clusters.
> The mpidr_hash.shift_aff[1] will be 6 as you need minimum 2 bits to represent
> aff[0]. So you will end up with second cluster with id = 4 instead of 1.

This isn't a problem, the clusters can have any numbers so long as they
are distinct.  There is no other requirement.

> I am not sure if we need this serialization, but even if we need it you can't
> simply use the hash bits generated for MPIDR.Aff{3..0} serialization directly
> as is for serializing parts of it.

Ah, now I look at what the hash is doing that is indeed directly useful
- we can mask or shift out the bits we don't want.  Equally well it just
looks like a preference?

This does seem like something that could be dealt with incrementally.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/29e065c5/attachment.sig>
