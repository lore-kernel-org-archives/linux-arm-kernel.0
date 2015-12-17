From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 17 Dec 2015 13:01:57 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <13702087.6o87OAVdIx@wuerfel>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <15285750.UWXWiNJ6YU@wuerfel> <20151214135206.GA1520@katana>
 <13702087.6o87OAVdIx@wuerfel>
Message-ID: <20151217120157.GC3958@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 11:27:22PM +0100, Arnd Bergmann wrote:
> On Monday 14 December 2015 14:52:06 Wolfram Sang wrote:
> > > > What about not ifdeffing the inline function and keep the build error
> > > > whenever someone uses it without I2C_SLAVE being selected?
> > > 
> > > The inline function is only added there for the case that I2C_SLAVE is
> > > disabled, so that would be pointless.
> > > 
> > > However, what we could do is move the extern declaration outside of
> > > the #ifdef to make it always visible. The if(IS_ENABLED(CONFIG_I2C_SLAVE))
> > > check should then ensure that it never actually gets called, and we
> > > get a link error if some driver gets it wrong.
> > 
> > Yes, that's what I meant: move the whole function (as it was before your
> > patch) out of the CONFIG_I2C_SLAVE block. We should get a compiler error
> > even, because for !I2C_SLAVE, the client struct will not have the
> > slave_cb member.
> > 
> 
> But we don't want a compile-error for randconfig builds, and we don't
> want unnecessary #ifdef in the driver. 

My conclusion for now is:

There needs something to be done surely, but currently I don't have the
bandwidth to do it or even play around with it. I am not fully happy
with your patches as well because __maybe_unused has some kind of "last
resort" feeling to me.

So, to get the build failures away immediately I'd simply submit a patch
for the emev driver to select I2C_SLAVE and postpone the proper fix to
later.

That being said, thanks a lot for your input. I will surely come back to it.

All the best,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151217/3aedb5c3/attachment.sig>
