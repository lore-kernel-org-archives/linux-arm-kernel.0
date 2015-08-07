From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Aug 2015 13:19:13 +0100
Subject: [PATCH v3 02/18] of/platform: add of_platform_probe
In-Reply-To: <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150807121913.GS20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 04:11:39PM +0200, Tomeu Vizoso wrote:

> Walks the OF tree up and finds the closest ancestor that has a platform
> device associated with it, probing it if isn't bound to a driver yet.

> The above should ensure that the dependency represented by the passed OF
> node is available, because probing a platform device should cause its
> descendants to be probed as well.

This sounds like it's going to break in the case where we have MFDs that
represent their functions in DT (not a pattern I'm a fan of but it's a
thing people do).  We'll walk back to the platform device for the MFD
function, try to probe it and then give up.  Perhaps that's good enough
anyway but it's not clear to me why we don't just try every parent we
find?

I'm also not a fan of the fact that the interface here is explicitly
saying that we want to probe a platform device, that's an implementation
detail that callers shouldn't need to know about.  From the point of
view of the callers what they're trying to do is kick any dependencies
into being instantiated, the fact that we currently try to accomplish it
with platform devices isn't something they care about.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/90403c12/attachment-0001.sig>
