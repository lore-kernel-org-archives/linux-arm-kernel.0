From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 May 2016 14:19:17 +0200
Subject: [PATCH] pwm: atmel-hlcdc: Fix default PWM polarity
In-Reply-To: <20160517140803.078e3f5e@bbrezillon>
References: <1463476352-7485-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160517110005.GA26166@ulmo.ba.sec>
 <20160517140803.078e3f5e@bbrezillon>
Message-ID: <20160517121917.GD26166@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 02:08:03PM +0200, Boris Brezillon wrote:
> Hi Thierry,
> 
> On Tue, 17 May 2016 13:00:05 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
> 
> > On Tue, May 17, 2016 at 11:12:32AM +0200, Boris Brezillon wrote:
> > > The PWM device exposed by the HLCDC IP is configured with an inverted
> > > polarity by default. Registering the PWM chip with the normal polarity
> > > was not a problem before commit 42e8992c58d4 ("pwm: Add core
> > > infrastructure to allow atomic updates") because the ->set_polarity()
> > > hook was called no matter the current polarity state, but this is no longer
> > > the case.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Fixes: 42e8992c58d4 ("pwm: Add core infrastructure to allow atomic updates")  
> > 
> > That's not technically correct, because it's the driver that has the
> > bug. The core change merely exposes it. How about if I sort this into
> > the pwm-atomic branch and reword the commit message accordingly? That
> > way things should all stay bisectible.
> > 
> > Then again, given the breakage caused by the pwm_args patch I suppose
> > it doesn't matter much because that's part of a stable branch that I
> > can't rebase.
> 
> If I understood correctly, you plan to rebase your pwm-atomic branch to
> insert this commit before commit 42e8992c58d4 ("pwm: Add core
> infrastructure to allow atomic updates").
> 
> Could you consider taking the following commit (or something similar if
> you already have a fix) as the first commit of your pwm-atomic branch?
> 
> Sorry for the mess around the introduction of pwm_args and pwm_state
> (that's not an excuse, but I've reworked this series so many time that I
> forgot to check bisectibility on the last versions :-().
> 
> ---
> From ad73fa3a56c7320979425d64ab54c09b9d83d4cf Mon Sep 17 00:00:00 2001
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> Date: Tue, 17 May 2016 13:55:02 +0200
> Subject: [PATCH] pwm: Fix pwm_apply_args() call sites
> 
> pwm_apply_args() is supposed to initialize a PWM device according to the
> arguments provided by the DT or the PWM lookup, but this function was
> called inside pwm_device_request(), which in turn was called before the
> core had a chance to initialize the pwm->args fields.
> 
> Fix that by calling pwm_apply_args directly in pwm_get() and of_pwm_get()
> after initializing pwm->args field.
> 
> This commit also fixes an invalid pointer dereference introduced by
> commit e39c0df1be5a ("pwm: Introduce the pwm_args concept").
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes: e39c0df1be5a ("pwm: Introduce the pwm_args concept")
> ---
>  drivers/pwm/core.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)

This looks good to me. However I can't easily apply this because git
gets confused by the existing headers. Also manually copying out the
patch yields patch corruption that I don't exactly know how to fix.

I think you can inline patches by using a scissor mark (--- >8 ---)
instead of the signature separator (---). Or you can attach the patch
with "Content-Disposition: inline".

Rather than putting this into the pwm-atomic branch, I'll probably stick
it into the pwm-args branch on top of the existing patch. Technically
only the existing patch needs to be stable, so the branch can still
evolve.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160517/596c6957/attachment.sig>
