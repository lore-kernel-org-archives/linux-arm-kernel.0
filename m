From: imre.deak@nokia.com (Imre Deak)
Date: Sat, 6 Feb 2010 12:02:21 +0200
Subject: [RFC PATCH v2 2/2] ARM: VFP: preserve the HW context when
	calling signal handlers
In-Reply-To: <20100206092544.GB1923@n2100.arm.linux.org.uk>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
	<b8a1d37c5f981cdd2e83c9fd98198832324cd57e.1265315249.git.imre.deak@nokia.com>
	<20100206092544.GB1923@n2100.arm.linux.org.uk>
Message-ID: <20100206100221.GA1109@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2010 at 10:25:44AM +0100, ext Russell King - ARM Linux wrote:
> On Thu, Feb 04, 2010 at 11:38:30PM +0200, Imre Deak wrote:
> > diff --git a/arch/arm/include/asm/user.h b/arch/arm/include/asm/user.h
> > index df95e05..ea7e44d 100644
> > --- a/arch/arm/include/asm/user.h
> > +++ b/arch/arm/include/asm/user.h
> > @@ -88,6 +88,9 @@ struct user{
> >  struct user_vfp {
> >  	unsigned long long fpregs[32];
> >  	unsigned long fpscr;
> > +	unsigned long fpexc;
> > +	unsigned long fpinst;
> > +	unsigned long fpinst2;
> 
> Absolutely no way is this anywhere near suitable.  This is a _userspace_
> _visible_ API change, breaking anyone using the ptrace API by overwriting
> additional memory which they will not be expecting.

Right, don't know what made me think that this will work out. Perhaps
someone mentioning that the corresponding IOCTL is not in use yet. But that
was about half a year ago :)

I'll resend adding the new regs only to the signal frame, leaving the above
as is.

--Imre
