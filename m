From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Mar 2016 11:58:39 +0000
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
 <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
 <20160317114308.GF2566@sirena.org.uk>
 <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
Message-ID: <20160317115839.GG2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 12:54:08PM +0100, Michal Suchanek wrote:

> That's what the driver does. The discussion revolves around the fact
> that the driver does not attempt to work (even for very short
> transfers) when the DMA channels are not configured and just bails
> out. AFAICT the channels are always available when the system is
> properly configured and the dmaengine driver loaded.

The driver should tell the core about this constraint so the core can
split the transfers for it.

> Very few device drivers would work with 63byte transfers only and the
> code for manually driving the CS line in case the DMA engine fails to
> configure will necessarily go untested most of the time since most
> systems will have DMA configured properly.

A lot of devices will be perfectly happy with 63 byte transfers,
register accesses for example tend to be much smaller than that.  The
manual /CS might be an issue but for most SoCs that is easily addressed
by driving the pin as a GPIO if there's an issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/93e66928/attachment.sig>
