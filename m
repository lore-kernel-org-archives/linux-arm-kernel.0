From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 09:48:08 +0000
Subject: [PATCH] ARM: PXA: Make PXA27x/PXA3xx overlay actually work
In-Reply-To: <AANLkTi=AfxN73pSNZ5RiTiTWfxR7PhcyJUyXzzeaYNWw@mail.gmail.com>
References: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
	<AANLkTi=AfxN73pSNZ5RiTiTWfxR7PhcyJUyXzzeaYNWw@mail.gmail.com>
Message-ID: <20110215094808.GB4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 03:35:44PM +0800, Eric Miao wrote:
> > @@ -720,12 +726,10 @@ static int overlayfb_open(struct fb_info *info, int user)
> > ? ? ? ?if (user == 0)
> > ? ? ? ? ? ? ? ?return -ENODEV;
> >
> > - ? ? ? /* allow only one user at a time */
> > - ? ? ? if (atomic_inc_and_test(&ofb->usage))
> > - ? ? ? ? ? ? ? return -EBUSY;
> > + ? ? ? if (ofb->usage++ == 0)
> > + ? ? ? ? ? ? ? /* unblank the base framebuffer */
> > + ? ? ? ? ? ? ? fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
> 
> The change above allows multiple user at a time? Then I guess
> some other places need to be changed accordingly to avoid the
> racing conditions.

You can't prevent multiple users.  Think threaded applications which
share the same set of fds.

Any driver which tries to do so by restricting the number of open()s is
simply buggy.
