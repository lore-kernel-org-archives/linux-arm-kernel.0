From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Jun 2013 14:02:02 -0600
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <20130617072021.GB4465@atomide.com>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org> <20130617072021.GB4465@atomide.com>
Message-ID: <51C20E3A.8090304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2013 01:20 AM, Tony Lindgren wrote:
...
> First, I think the concept of remuxing (or even checking) _all_ the pins
> for a consumer device is wrong on most if not all hardware. For past 10
> years I have not seen a case where _all_ the pins for a device would need
> to be remuxed for any reason.
> 
> This means the named states "default", "idle" and "sleep" cannot represent
> the needs of hardware. So need to have a bit finer granularity for this.

Well, I don't think that's quite true.

We can certainly list configurations for all pins in each of those 3
states without any issue.

The only issue here is whether the data is normalized or not. By listing
the entire configuration in each state, it's not really normalized.

By separating the static and dynamic parts into separate states as you
propose below, it is more normalized.

However, the final configuration of HW is the same either way, and hence
the overall configuration.

> Below are the pin remuxing cases I'm aware of:
...
> Then for dealing with the above examples, I think we already have a
> pretty good setup in pinctrl framework to deal with this with the
> named modes. But I think that to do this properly with the named
> modes we should have named modes like the following:
> 
> "static" && ("active" || "idle")
> "static" && ("rx" || "tx")
> 
> Here the "static" pins would be set during driver probe and never
> need to change until the driver is unloaded. This is close to what we
> currently call "default". But we should probably make it clear that
> these will not change to avoid confusion. See below for more info.
> 
> The the non-static states like "active"/"idle", or "rx"/"tx", can
> be set in addition to "static", but they should not be subsets of
> "static" to avoid the issues Stephen described earlier. This way we
> allow the named modes to do the work for us while protecting the
> claimed pins.

Yes, I think this can certainly work conceptually. It's equivalent to
pre-computing which parts of the overall state don't change between the
currently-defined "global" active/idle states and then applying the
diffs at runtime - rather like what I suggested before, but without the
pinctrl code having to do the diff at runtime. I'm not sure if I have
(yet) a strong opinion on whether allowing multiple states to be active
at once (i.e. static plus active) is the correct way to go. Maybe once
I've finished reading the thread...
