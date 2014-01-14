From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 13:43:10 +0000
Subject: [PATCH v10 4/4] arm64: topology: Provide relative power numbers
 for cores
In-Reply-To: <52D48FF9.1070501@nvidia.com>
References: <1389287106-29979-1-git-send-email-broonie@kernel.org>
 <1389287106-29979-5-git-send-email-broonie@kernel.org>
 <52D48FF9.1070501@nvidia.com>
Message-ID: <20140114134310.GF15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 05:16:41PM -0800, Paul Walmsley wrote:

> As I think someone else proposed, ideally both arch/arm32 and
> arch/arm64 should be determining these metrics dynamically, and
> allowing the metrics to be overridden from DT data.  These metrics
> can vary significantly based on variables other than just the core
> type.

> For example, for some ARMv7 CPUs, we know that different revision
> levels of the same core type can result in significant performance
> differences.  Also CPU bug workarounds applied early by the
> bootloader, or different integrator hardware core configurations,
> can impact these metrics.

So, determining any numbers dynamically is obviously the ideal (and
shouldn't really be an architecture thing - there is nothing obviously
architecture specific about that) and we ought to take things like core
revision differences into account.

However doing this by putting specific tunable numbers into the DT isn't
good practice since the implementation that interprets those numbers is
subject to change.  The numbers are basically just benchmark numbers
with all the specificness and so on that this entails, saying "this is
core with rating X" isn't robust for the long term since it's not really
objective information and is heavily tied to the the specific software
doing the parsing (and most likely also some particular application
stack that was being tuned).

The best practice is therefore for any relevant information that needs
to be factored in and can't be read from the silicon at runtime to be
put in the DT in a way that describes something objective like the core
revisions.  This lets the system take account of these factors in a way
that makes sense within the implementation rather than having to try to
interpret numbers which may not apply well to the current implementation
and may hide information which would help the implementation tune itself.

The other option here is runtime tunables via sysfs or whatever which
avoids baking numbers into the DT in the same way, though that is partly
just a punt of the same problem to userspace.  That's probably also more
helpful to people doing the tuning since it can be tweaked dynamically.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/aab2d266/attachment.sig>
