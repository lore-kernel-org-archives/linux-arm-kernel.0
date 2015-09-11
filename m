From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 15:56:38 +0100
Subject: master build: 1 failures 73 warnings (v4.2-11142-gb0a1ea5)
In-Reply-To: <20150911125830.GA11833@n2100.arm.linux.org.uk>
References: <E1ZaL9B-0006QE-Kh@optimist> <20150911120150.GN12027@sirena.org.uk>
 <20150911125830.GA11833@n2100.arm.linux.org.uk>
Message-ID: <20150911145638.GL20922@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 01:58:30PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 11, 2015 at 01:01:51PM +0100, Mark Brown wrote:

> > Today's mainline fails to build on arm64 due to the above, introduced by
> > efaa6e266ba (firmware: qcom_scm-32: replace open-coded call to
> > __cpuc_flush_dcache_area()) which introduces a call to
> > secure_flush_area() which isn't defined on arm64.

> That commit has been in mainline for over a week now, so it shouldn't
> be "today's mainline" but mainline from a week ago.

I only noticed it today, given the thing selects with it's likely that
as you say it's been triggered by a change in another tree rather than
having been an issue in itself.

> However, I've educated myself to hardly ever look at arm64-allmodconfig
> because it's always broken for one reason or another, and the amount of
> warnings it spits out is rediculous, many of them not the fault of ARM64
> code, but of crappy driver code.

Indeed, the initial reason I set up my builder was that I was doing work
on arm64 and got fed up with the constant breakage in -next.  It's
getting better slowly, we mostly at least compile now which wasn't the
case originally.

> Changing the "depends" on QCOM_SCM won't fix it - I think something's
> been recently merged which has added another select QCOM_SCM which has
> the effect of enabling this on ARM64.  _That_ is the cause of this
> breakage.

Yes, it'll be the combination of the two commits (hopefully whatever
patch introduced the issue builds on its own branch as well).  There's a
fix been merged into -next somewhere which fixes this - like I said I'm
fairly sure that's 626ffb400e1e781 (firmware: qcom: scm: Add function
stubs for ARM64) which means that an alternative stub implementation in
qcom_scm-64.c gets build on arm64 but that's not hit mainline yet and
we're getting near the end of the merge window.

It would be sad to have yet another release where -rc1 doesn't build for
common test configurations :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/c70665e1/attachment.sig>
