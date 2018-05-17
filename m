From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 18:23:08 +0100
Subject: [PATCH v8 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
In-Reply-To: <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
 <20180517065544.GO20254@sirena.org.uk>
 <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
Message-ID: <20180517172308.GX20254@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 06:10:49PM +0100, Srinivas Kandagatla wrote:
> On 17/05/18 07:55, Mark Brown wrote:
> > On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:

> > This lock only protects the list, it does nothing to ensure that the
> > port we look up is still valid by the time we return to the caller.
> > That means we won't crash during list traversal but does nothing to
> > ensure we won't crash immediately afterwards if the port is deallocated
> > just after we look it up.  What stops that happening?

> Each port is allocated and de-allocated in dai probe and remove calls
> respectively.

> Lets say... So for this case to happen the dai has to be removed (unload
> module) at the same time when the interrupt callback happens due to delayed
> response from previous commands.

> This case would be almost impossible because all the calls to afe service
> are synchronous with timeouts, if any of the previous calls times out the
> respective caller would get an error, this should prevent him from unloading
> the module in the first place.

The user can also trigger manual unbinds without unloading the module,
and to be honet the scenario where the DSP has stopped responding well
and is delaying responses sounds like exactly the sort of time when
users might try to reload the driver...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/98b47dad/attachment.sig>
