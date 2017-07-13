From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 13 Jul 2017 14:03:01 +0200
Subject: Drivers taking different actions depending on sleep state
In-Reply-To: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
 <CAJZ5v0iL7voAz9T+36fXXncOj4UrFSAH8WzwEbec96GuFUteaQ@mail.gmail.com>
 <ccac39d6-4611-8b46-12f7-24227ef3b35e@gmail.com>
 <CAJZ5v0g_egRwxOLqft=JhvzAqBWuyvC8yiO7De5TYUZLUT2Fpw@mail.gmail.com>
 <7001768d-9134-4975-127e-e8444e00f677@gmail.com>
 <CAJZ5v0ihqn5Xcj1yoZcrb7caYiH+x8YivLJit6BqvDGradZJ=Q@mail.gmail.com>
 <b7a49925-d823-b03d-2990-2894ba2c2714@gmail.com>
 <20170622085102.mpk7vxodpgxtrlfd@piout.net>
Message-ID: <20170713120300.GH1363@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2017-06-22 10:51:02, Alexandre Belloni wrote:
> On 21/06/2017 at 16:55:04 -0700, Florian Fainelli wrote:
> > > That is conceivable, but again, the meaning of STANDBY and MEM is
> > > platform-specific.  Actions to be taken for, say, STANDBY, may differ
> > > from one platform to another.
> > 
> > True, though I would only expect drivers for that particular platform to
> > care about that information and these drivers would only make sense on
> > that particular platform so the meaning of STANDBY and MEM would be
> > clear for those drivers. The intent is really to keep the "distributed"
> > model where individual drivers manage their particular piece of HW,
> > while utilizing a global piece of information that is platform specific.
> > 
> > If this seems acceptable to you along with proper documentation to
> > illustrate the platform specific meaning of these states, I will got
> > ahead and cook a patch.
> 
> Well, that won't work for us. We need need two kind of information:
>  - whether main clock is switched from the master clock to the slow
>    clock
>  - whether VDDcore will be cut
> 
> for the first one, we already have an hackish callback:
> at91_suspend_entering_slow_clock() that will call from the platform
> specific drivers.

Sounds like you need another "will_vddcore_be_cut?()" callback, not
"int platform_suspend_target_state(void)".

And actually I'd hope you have some kind of regulator, so that "will
this regulator be available over suspend" question can be asked?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170713/a0aff987/attachment.sig>
