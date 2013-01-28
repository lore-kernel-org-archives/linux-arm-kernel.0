From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 28 Jan 2013 14:16:23 +0100
Subject: [PATCH v2 1/3] pwm: Add pwm_cansleep() as exported API to users
In-Reply-To: <510659A3.7070906@epfl.ch>
References: <1359121471-21457-1-git-send-email-florian.vaussard@epfl.ch>
 <1359121471-21457-2-git-send-email-florian.vaussard@epfl.ch>
 <20130126054024.GB29243@avionic-0098.adnet.avionic-design.de>
 <51063AB5.2060108@ti.com> <51064687.5090605@epfl.ch>
 <20130128095754.GA23134@avionic-0098.adnet.avionic-design.de>
 <510659A3.7070906@epfl.ch>
Message-ID: <20130128131622.GA1783@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 11:57:39AM +0100, Florian Vaussard wrote:
> Le 28/01/2013 10:57, Thierry Reding a ?crit :
> >On Mon, Jan 28, 2013 at 10:36:07AM +0100, Florian Vaussard wrote:
> >>Hello,
> >>
> >>Le 28/01/2013 09:45, Peter Ujfalusi a ?crit :
> >>>hi Thierry,
> >>>
> >>>On 01/26/2013 06:40 AM, Thierry Reding wrote:
> >[...]
> >>>>>+{
> >>>>>+	return pwm->chip->can_sleep;
> >>>>>+}
> >>>>>+EXPORT_SYMBOL_GPL(pwm_cansleep);
> >>>>
> >>>>Would it make sense to check for NULL pointers here? I guess that
> >>>>passing NULL into the function could be considered a programming error
> >>>>and an oops would be okay, but in that case there's no point in making
> >>>>the function return an int. Also see my next comment.
> >>>
> >>>While it is unlikely to happen it is better to be safe, something like this
> >>>will do:
> >>>
> >>>return pwm ? pwm->chip->can_sleep : 0;
> >>>
> >>
> >>Ok. And what about:
> >>
> >>BUG_ON(pwm == NULL);
> >>return pwm->chip->can_sleep;
> >
> >I don't think we need that. In case pwm == NULL, dereferencing it will
> >oops anyway. So either we make it safe and return an error code, or we
> >let it oops without explicit BUG_ON().
> >
> 
> Calling this function with a NULL pointer is a programming error, so there
> is no error codes for such errors.

You could return -EINVAL if pwm == NULL.

> I propose to return bool, and let it oops if such case happens.

My point was that it will oops even if you don't use BUG_ON() so there
isn't so much point in using it explicitly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130128/a79cde7f/attachment.sig>
