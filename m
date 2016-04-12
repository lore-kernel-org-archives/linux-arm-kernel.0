From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 13:46:00 +0200
Subject: [PATCH v5 04/46] pwm: get rid of pwm->lock
In-Reply-To: <20160412133255.73cea027@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-5-git-send-email-boris.brezillon@free-electrons.com>
 <20160412112246.GJ18882@ulmo.ba.sec>
 <20160412133255.73cea027@bbrezillon>
Message-ID: <20160412114600.GL18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 01:32:55PM +0200, Boris Brezillon wrote:
> Hi Thierry,
> 
> On Tue, 12 Apr 2016 13:22:46 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
> 
> > On Wed, Mar 30, 2016 at 10:03:27PM +0200, Boris Brezillon wrote:
> > > PWM devices are not protected against concurrent accesses. The lock in
> > > pwm_device might let PWM users think it is, but it's actually only
> > > protecting the enabled state.
> > > 
> > > Removing this lock should be fine as long as all PWM users are aware that
> > > accesses to the PWM device have to be serialized, which seems to be the
> > > case for all of them except the sysfs interface.
> > > Patch the sysfs code by adding a lock to the pwm_export struct and making
> > > sure it's taken for all accesses to the exported PWM device.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >  drivers/pwm/core.c  | 19 ++++--------------
> > >  drivers/pwm/sysfs.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----------
> > >  include/linux/pwm.h |  2 --
> > >  3 files changed, 50 insertions(+), 28 deletions(-)
> > 
> > This is a little overzealous. Only accesses that can cause races need to
> > be protected by the lock. All of the *_show() callbacks don't modify the
> > PWM device in any way, so there is no need to protect them against
> > concurrent accesses.
> 
> This is probably true for this set of changes, but what will happen
> when we'll switch to the atomic API? There's no guarantee that
> pwm->state = *newstate is done atomically, and you may see a partially
> updated state when calling pwm_get_state() while another thread is
> calling pwm_apply_state().

I'd argue that for sysfs it doesn't matter since the userspace API is
non-atomic anyway. As such it doesn't really matter which part of the
state you're getting because only one field from the query is exposed
to userspace, hence the coherence of the state is irrelevant.

All other users should be taking care of the serialization themselves
already.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/95ad1c1a/attachment.sig>
