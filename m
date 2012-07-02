From: balbi@ti.com (Felipe Balbi)
Date: Mon, 2 Jul 2012 14:54:23 +0300
Subject: [RFC PATCH 3/3] i2c: inititalise the actual transferred to zero
In-Reply-To: <20120629151832.0cb26bea@endymion.delvare>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
 <1340967927-27354-4-git-send-email-shubhrajyoti@ti.com>
 <20120629144002.3b4a31ee@endymion.delvare>
 <20120629145718.697b6955@endymion.delvare>
 <4FEDA9A8.1050504@ti.com>
 <20120629151832.0cb26bea@endymion.delvare>
Message-ID: <20120702115422.GC2730@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 29, 2012 at 03:18:32PM +0200, Jean Delvare wrote:
> On Fri, 29 Jun 2012 18:42:08 +0530, Shubhrajyoti wrote:
> > On Friday 29 June 2012 06:27 PM, Jean Delvare wrote:
> > > drivers/gpu/drm/nouveau/nouveau_bios.c:3535:3: warning: (near initialization for ?msg[1].actual?) [enabled by default]
> > >
> > > This needs to be all fixed (converted to C99-style struct
> > > initialization) before your patch is considered for inclusion. And
> > > there may be more that my config did not spot.
> > Yes,agree.
> > 
> > The idea of this patch was if the idea is agreed upon then.
> > then fixing all the callers could be worked on.
> 
> This is worth fixing anyway, C99-style initialization is always good to
> move to.
> 
> > However do you agree with this approach?
> 
> Well you've seen the caveats I mentioned, this will be no easy ride. If
> you are willing to take the risk, spend the time documenting the
> change, and help people if there are issues, then I'm OK. At least as
> long as someone else doesn't come saying it's a very bad idea ;)

This approach is a hard-requirement for devices which will pose any
interface/feedback with user. We have been working with a piezo driver
from TI (drv2665) and it will be used (in most cases at least) to give
the user a feedback based on e.g. touchscreen event.

Imagine drv2665 responds with a NAK while we're in the middle of driving
a wave through it (keep in mind a wave could take seconds to finish,
depending on the usecase), if we don't have a way to tell users that we
have writen X bytes, how should we make sure to continue driving the
wave from the exact byte where we got a NAK ?

If can't make sure that detail is true, then such usecases (as piezo
drivers) will never work.

Another approach would be to not add any field to struct i2c_msg but
instead return either the amount of bytes transferred, or an error case.
This would mean a series that would:

1) fix all users of struct i2c_master_send() and the like to check for
	errors as if (ret < 0) instead of if (ret);
2) fix all i2c buses to return the amount of bytes written instead of
	zero or error case
3) fix Documentation to state that we're now returning the amount of
	bytes, instead of zero or errno.

I'm not sure what will have minimum impact to userland, though. What do
you say Jean ? What would you prefer ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/29c54463/attachment.sig>
