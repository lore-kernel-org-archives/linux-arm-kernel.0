From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 3 Aug 2016 18:38:33 +0200
Subject: [PATCH] Add file permission mode helpers
In-Reply-To: <20160803081140.GA7833@gmail.com>
References: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
 <20160803081140.GA7833@gmail.com>
Message-ID: <20160803163832.GA18754@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2016-08-03 10:11:40, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > [ So I answered similarly to another patch, but I'll just re-iterate
> > and change the subject line so that it stands out a bit from the
> > millions of actual patches ]
> > 
> > On Tue, Aug 2, 2016 at 1:42 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
> > > S_IRCRP | S_IROTH (*). Please don't do this.
> > 
> > Absolutely. It's *much* easier to parse and understand the octal
> > numbers, while the symbolic macro names are just random line noise and
> > hard as hell to understand. You really have to think about it.
> > 
> > So we should rather go the other way: convert existing bad symbolic
> > permission bit macro use to just use the octal numbers.
> 
> In addition to that I'd love to have something even easier to read, a few common 
> variants of the permissions field of 'ls -l' pre-defined. I did some quick 
> grepping, and collected the main variants that are in use:
> 
> 		PERM_r________	0400
> 		PERM_r__r_____	0440
> 		PERM_r__r__r__	0444

I see 0400 and 0444 making sense, but does 0440 really make sense?
I assume it will be uid/gid 0/0? Is gid 0 really estabilished well
enough to give it special permissions?

And yes, these macros actually help readability.

> 		PERM__wx______	0300
> 		PERM__wx_wx___	0330
> 		PERM__wx_wx_wx	0333

Uh. This is for sysfs. Do we event want any __x variants? _wx
would certainly be strange.

(And yes, we can keep people from using strange permissions by simply
not defining those macros.)

> Allowing these would be nice too, because there were cases in the past where 
> people messed up the octal representation or our internal symbolic helpers,
> but this representation is fundamentally self-describing and pretty 'fool proof'.
> 
> An added advantage would be that during review it would stick out like a sore 
> thumb if anyone used a 'weird' permission variant.
> 
> For example, if you saw these lines in a driver patch:
> 
> +	__ATTR(l1, 0444, driver_show_l4, NULL);
> +		__ATTR(l3, 0446, driver_show_l4, NULL);
> +			__ATTR(l2, 04444, driver_show_l4, NULL);
> +		__ATTR(l4, 0444, driver_show_l4, NULL);
> 
> ... would you notice it at a glance that it contains two security holes?

I see two bugs but only one hole. How can you exploit s-bit without corresponding x-bit?

I'd delete these: I don't think we should encourage their use:

> +#define PERM_r__r_____	0440
> +#define PERM_rw_r_____	0640
> +#define PERM_rw_rw_r__	0664
> +
> +#define PERM__w__w__w_	0222
> +
> +#define PERM_r_x______	0500
> +#define PERM_r_xr_x___	0550
> +#define PERM_r_xr_xr_x	0555
> +
> +#define PERM_rwx______	0700
> +#define PERM_rwxr_x___	0750
> +#define PERM_rwxr_xr_x	0755
> +#define PERM_rwxrwxr_x	0775
> +#define PERM_rwxrwxrwx	0777
> +
> +#define PERM__wx______	0300
> +#define PERM__wx_wx___	0330
> +#define PERM__wx_wx_wx	0333

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
