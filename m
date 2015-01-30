From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Jan 2015 13:27:14 +0100
Subject: [PATCH 2/9] regulator: core: Introduce set_optimum_mode op
In-Reply-To: <20150130000741.GP11960@sonymobile.com>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1422413199-17273-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20150128195204.GN21293@sirena.org.uk>
 <20150130000741.GP11960@sonymobile.com>
Message-ID: <20150130122714.GA26617@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 04:07:42PM -0800, Bjorn Andersson wrote:
> On Wed 28 Jan 11:52 PST 2015, Mark Brown wrote:

> > This is basically fine but can you please rename this to be something
> > that more directly reflects the fact that we're just informing the
> > driver about the operating parameters - there are other things a driver
> > could usefully do with this, for example set current limits so that if
> > something starts to consume excessive current the device will flag this
> > as an error.

> The purpose of the series was to be able to implement patch 9, which
> will utilize the load_uA to set the "mode" of the Qualcomm regulators.

> So I would like it to be a "setter of current consumption".

> I'm not sure what to name the function to have it cover these additional
> cases.

notify_load() or something?  That's what it's doing, what the driver
does with it is a separate thing.

> > It'd also be better to split the voltage specs out into a separate
> > function, especially for the output voltage where obviously we have a
> > separate range based interface for setting that.

> The current implementors of get_optimum_mode all ignore the voltages, so
> we could effectively simplify the interface to:

>  get_optimum_mode(rdev, load);

> Question is if there are any implementations where we don't know the
> output voltage in the regulator driver (as locking prevents us from
> using the standard interface of querying this). Input voltage is just a
> query away.

We can always fix the locking to let people query the voltage if they
need to.

> Having drms_uA_update() request an appropriate mode for the given load
> and then calling set_mode directly (the current implementation) gives us
> a single point of entry to the regulator drivers related to setting
> modes (regulator_set_mode and drms_uA_update calls set_mode). But seen
> from a consumer there's no consistency; the last call to
> regulator_set_mode() and regulator_set_optimum_mode() will win.

That's fine, consumers shouldn't be using both simultaneously anyway.
If a consumer is actually setting modes actively at runtime by name it
needs to be fairly closely tied to a specific system and regulator so
it's not clear if there's much use case anyway.

> I think this covers your concern about patch 3-7 as well, please let me
> know what you think.

Possibly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/52b1927a/attachment-0001.sig>
