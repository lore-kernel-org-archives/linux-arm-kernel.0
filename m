From: matt@genesi-usa.com (Matt Sealey)
Date: Tue, 7 Aug 2012 18:06:27 -0500
Subject: [PATCH 2/2] ARM i.MX5: Hard reset the IPU during startup
In-Reply-To: <20120807170428.GI18957@n2100.arm.linux.org.uk>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
 <1338888630-25930-3-git-send-email-s.hauer@pengutronix.de>
 <20429.57208.228315.164637@ipc1.ka-ro> <20120605110834.GQ30400@pengutronix.de>
 <CAKGA1bkA3eEHn4sM277mzcRT5OUyipW18-k-X0nK+T9rrotJNw@mail.gmail.com>
 <20120807170428.GI18957@n2100.arm.linux.org.uk>
Message-ID: <CAKGA1bn8AEWhX_ZwuzB28mej7Y3da5_dFz+aOXcBaqMsJx9SBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2012 at 12:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 06, 2012 at 04:31:50PM -0500, Matt Sealey wrote:
>> There used to be an ATAG for finding the linear framebuffer and it's
>> details but it got removed. This
>> was from a long forgotten time when you could initialize a VGA
>> graphics card and never care that
>> it had an interrupt or not, since it never got used for your average,
>> simple linear framebuffer operations.
>
> No ATAG definitions have been removed from the kernel.  The one you
> are referring to is:
>
> #define ATAG_VIDEOLFB   0x54410008
>
> and the associated struct tag_videolfb, which is still in the kernel
> today.  What isn't there is the implementation which reads this data,
> because only a few boards supported it, and they passed over some data
> from this to their FB drivers.
>
> So, when the boards were updated such that this became unnecessary,
> unsurprisingly the users disappeared (because they were all in platform
> code.)
>
> We have never had a generic "framebuffer" driver which has used this
> ATAG.  Or if one was created, it never came anywhere near mainline.
>
> Either way, the situation is not as you describe above.

That's funny, I was absolutely certain the complete removal was done
in the kernel, especially since it
was patched out of U-Boot (commit 47ea6ed) a long, long time ago based
on it being unsupported in
the ATAG parser.

I also saw a patch for OMAP which you nacked (violently :) long before
that, because it was parsing
ATAG_VIDEOLFB and passing it to it's display driver. Just found it again:

http://www.spinics.net/lists/linux-omap/msg08287.html

I must have just assumed that since the kernel doesn't pay attention
to it, which caused it to be
patched out of U-Boot since around June 2010, it would actually have
completely gone away by now.

Since no future boards use it (because you refuse to let them do it
anymore, and also because the
Device Tree is better anyway), no drivers use it anyway, wouldn't it
be time to remove it completely,
or is it there just for legacy's sake, a sepia-toned halcyon reminder
of what we used to do to boot
ARM boards? We are in 2012 though and the git history will always
reflect the day it got removed.
I think the only reason people haven't noticed it's still defined is
because U-Boot doesn't pass it
anymore and most of us are running U-Boots compiled much newer than June 2010.

Who's really going to miss it?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
