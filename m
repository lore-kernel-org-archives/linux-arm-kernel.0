From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 16 Mar 2010 07:25:14 +0100
Subject: [PATCH] locomo: replace locomo_{readl/writel} macros with
	__raw_{readw/writew}
In-Reply-To: <0D753D10438DA54287A00B027084269763682CDA12@AUSP01VMBX24.collaborationhost.net>
References: <BD79186B4FD85F4B8E60E381CAEE1909022427CF@mi8nycmail19.Mi8.com>
	<f17812d71003090526r33325407n250c92b1947d9fcf@mail.gmail.com>
	<0D753D10438DA54287A00B027084269763682CDA12@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100316062514.GA1528@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2010-03-09 11:25:44, H Hartley Sweeten wrote:
> On Tuesday, March 09, 2010 6:26 AM, Eric Miao wrote:
> > On Tue, Mar 9, 2010 at 8:18 AM, H Hartley Sweeten
> > <hartleys@visionengravers.com> wrote:
> >> The locomo_readl and locomo_writel macros are misnamed. Both
> >> use (*(volatile u16 *)(addr)) so they should be a *w variety.
> >>
> >> Instead of renaming the macros just replace them tree wide with
> >> __raw_readw and __raw_writew.
> >>
> >> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Cc: Eric Miao <eric.y.miao@gmail.com>
> >>
> >
> > Hey Hartley,
> >
> > Could you please rebase this on top of my 'devel' branch? And note
> > locomo_{read,write}l() may also be used in sub-device drivers like
> > keyboard, LEDs and etc.
> 
> Follow up to my previous reply.
> 
> If there are out-of-tree users of locomo_writel and locomo_readl, the
> following should allow leaving the macros temporarily and get them to
> switch.
> 
> When I rebase to your devel branch I can include this if you think it
> is necessary.

> -#define locomo_writel(val,addr)	({ *(volatile u16 *)(addr) = (val); })
> -#define locomo_readl(addr)	(*(volatile u16 *)(addr))
> +static inline void __deprecated locomo_writel(u16 val, void __iomem *addr)
> +{
> +	/* deprecated; use the function below instead */
> +	__raw_writew(val, addr);
> +}

I'm not sure if we want people to commonly use function begining with
__raw_. Normally, such functions are think-twice internal-only...

Why not readw()/writew()?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
