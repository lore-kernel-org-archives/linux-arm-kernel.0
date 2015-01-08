From: balbi@ti.com (Felipe Balbi)
Date: Thu, 8 Jan 2015 11:24:11 -0600
Subject: [PATCH 1/4] usb: phy: Fix deferred probing
In-Reply-To: <54AEB11B.6060403@linaro.org>
References: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420559110-8043-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAOesGMhWgUu8wDyZyL63gq5JEDu=ecv=r0y7Aa+6SMt24N-Z+A@mail.gmail.com>
 <54AEB11B.6060403@linaro.org>
Message-ID: <20150108172411.GN31926@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 06:32:27PM +0200, Grygorii.Strashko at linaro.org wrote:
> Hi,
> 
> On 01/07/2015 06:41 AM, Olof Johansson wrote:
> > On Tue, Jan 6, 2015 at 7:45 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> >> Commit 1290a958d48e ("usb: phy: propagate __of_usb_find_phy()'s error on
> >> failure") actually broke the deferred probing mechanism, since it now returns
> >> EPROBE_DEFER only when the try_module_get call fails, but not when the phy
> >> lookup does.
> >>
> >> All the other similar functions seem to return ENODEV when try_module_get
> >> fails, and the error code of either __usb_find_phy or __of_usb_find_phy
> >> otherwise.
> >>
> >> In order to have a consistent behaviour, and a meaningful EPROBE_DEFER, always
> >> return EPROBE_DEFER when __(of_)usb_find_phy fails to look up the requested
> >> phy, that will be propagated by the caller, and ENODEV if try_module_get fails.
> >>
> > 
> > Fixes:  1290a958d48e ("usb: phy: propagate __of_usb_find_phy()'s error
> > on failure")
> > 
> >> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > This also fixes USB on tegra/trimslice here.
> > 
> > Tested-by: Olof Johansson <olof@lixom.net>
> > 
> > Given that the regression went in during 3.19 merge window, this
> > should go in as a fix during -rc, please.
> 
> 1) Pls note, there is a duplication patch https://www.mail-archive.com/linux-usb at vger.kernel.org/msg53893.html
> but this one is more correct as for me. 
> 
> 2) This patch fixes USB regression on Keystone 2, so
> 
>  Tested-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Are we asking that I drop Thierry's Patch or just apply the other hunks?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/fc39e5b5/attachment.sig>
