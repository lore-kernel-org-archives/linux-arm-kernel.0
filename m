From: treding@nvidia.com (Thierry Reding)
Date: Thu, 8 Jan 2015 19:04:18 +0100
Subject: [PATCH 1/4] usb: phy: Fix deferred probing
In-Reply-To: <20150108172411.GN31926@saruman>
References: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420559110-8043-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAOesGMhWgUu8wDyZyL63gq5JEDu=ecv=r0y7Aa+6SMt24N-Z+A@mail.gmail.com>
 <54AEB11B.6060403@linaro.org> <20150108172411.GN31926@saruman>
Message-ID: <20150108180417.GB17281@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 11:24:11AM -0600, Felipe Balbi wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Jan 08, 2015 at 06:32:27PM +0200, Grygorii.Strashko at linaro.org wrote:
> > Hi,
> > 
> > On 01/07/2015 06:41 AM, Olof Johansson wrote:
> > > On Tue, Jan 6, 2015 at 7:45 AM, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> wrote:
> > >> Commit 1290a958d48e ("usb: phy: propagate __of_usb_find_phy()'s error on
> > >> failure") actually broke the deferred probing mechanism, since it now returns
> > >> EPROBE_DEFER only when the try_module_get call fails, but not when the phy
> > >> lookup does.
> > >>
> > >> All the other similar functions seem to return ENODEV when try_module_get
> > >> fails, and the error code of either __usb_find_phy or __of_usb_find_phy
> > >> otherwise.
> > >>
> > >> In order to have a consistent behaviour, and a meaningful EPROBE_DEFER, always
> > >> return EPROBE_DEFER when __(of_)usb_find_phy fails to look up the requested
> > >> phy, that will be propagated by the caller, and ENODEV if try_module_get fails.
> > >>
> > > 
> > > Fixes:  1290a958d48e ("usb: phy: propagate __of_usb_find_phy()'s error
> > > on failure")
> > > 
> > >> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > 
> > > This also fixes USB on tegra/trimslice here.
> > > 
> > > Tested-by: Olof Johansson <olof@lixom.net>
> > > 
> > > Given that the regression went in during 3.19 merge window, this
> > > should go in as a fix during -rc, please.
> > 
> > 1) Pls note, there is a duplication patch https://www.mail-archive.com/linux-usb at vger.kernel.org/msg53893.html
> > but this one is more correct as for me. 
> > 
> > 2) This patch fixes USB regression on Keystone 2, so
> > 
> >  Tested-by: Grygorii Strashko <grygorii.strashko@linaro.org>
> 
> Are we asking that I drop Thierry's Patch or just apply the other hunks?

The above doesn't like to my patch. The original is here:

	http://www.spinics.net/lists/linux-usb/msg118358.html

That has the advantage of also handling the case where the PHY provider
is disabled and will therefore never become available, thus preventing
infinite deferred probe.

My patch doesn't handle the non-OF case, though I'm not sure that
it's safe to defer probe for those, since we don't have any indication
that the probe will ever succeed. In that case it might actually be
better to keep returning -ENODEV. Also the change to __usb_find_phy() is
unrelated to the commit that causes the regression, so if we want to
defer probe in that case, too it might be better to do so in a separate
patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/aaca6d34/attachment.sig>
