From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Feb 2015 15:08:47 +0800
Subject: [PATCH 2/9] regulator: core: Introduce set_optimum_mode op
In-Reply-To: <CAJAp7OjEKHut7jamChycfj_DHX7OaTm3kuKMWaY=hj4UZfyhaA@mail.gmail.com>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1422413199-17273-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20150128195204.GN21293@sirena.org.uk>
 <20150130000741.GP11960@sonymobile.com>
 <20150130122714.GA26617@finisterre.sirena.org.uk>
 <CAJAp7OjEKHut7jamChycfj_DHX7OaTm3kuKMWaY=hj4UZfyhaA@mail.gmail.com>
Message-ID: <20150210070847.GH2593@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 02:08:41PM -0800, Bjorn Andersson wrote:

> You said something when we talked that I interpreted to
> regulator_set_optimum_mode() is not a good name for the consumer API;
> was that a correct interpretation or was your comment limited to the
> driver facing API?

> Should we go ahead and rename it to regulator_notify_load()
> (regulator_set_load() perhaps?) before we get more consumers as well?
> (would be a separate patch set)

This can be _set_load() I think since we are actually telling the
framework about the expected load but yes, we should rename it to
reflect what we're actually doing.

> But if we're only considering load in drms_uA_update() does it make
> sense to check this against the valid ranges of min_uA, max_uA and
> hence instead of checking REGULATOR_CHANGE_DRMS just check for
> REGULATOR_CHANGE_CURRENT?
> We have reduced the interface to not necessarily be dynamic _mode_ setting.

No, _CHANGE_CURRENT is about current reglators which are a different
thing to voltage regulators.

> >> I think this covers your concern about patch 3-7 as well, please let me
> >> know what you think.

> > Possibly.

> Well, my question is still there:

> Unless we replace the get_optimum_mode()/set_mode() pair with
> notify_load() the driver API logic will become confusing; so for the
> regulators that to day implement that combo I think we need patch 3-7
> as well.

That's not a question, that's a statement...  Since we don't currently
have a notify_load() interface we obviously don't have any drivers using
it so I'm not sure what drivers will become confusing here or how this
addresses the part about keeping the operations split for the common
pattern?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150210/d614391a/attachment-0001.sig>
