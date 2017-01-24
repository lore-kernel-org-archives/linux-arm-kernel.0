From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 24 Jan 2017 23:46:10 +0100
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <20170124184526.GA25056@roeck-us.net>
References: <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd> <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface> <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
Message-ID: <20170124224610.GA27340@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-01-24 10:45:26, Guenter Roeck wrote:
> On Tue, Jan 24, 2017 at 06:58:01PM +0100, Pavel Machek wrote:
> > 
> > > >>Right.
> > > >>
> > > >>Before reverting, can you please try if this patch works or not?
> > > >
> > > >Not really. Revert now. Sorry.
> > > >
> > > >Are you sure? This does not look equivalent to me at all.
> > > >
> > > >"name" file handling moved from drivers to the core, which added some
> > > >crazy checks what name can contain. Even if this "works", what is the
> > > >expected effect on the "name" file?
> > > >
> > > The hwmon name attribute must not include '-', as documented in
> > > Documentation/hwmon/sysfs-interface. Is enforcing that 'crazy' ?
> > > Maybe in your world, but not in mine.
> > 
> > Well, lets revert the patch and then we can discuss what to do with
> > the "name" problem.
> > 
> Not sure what the problem to be discussed is. Please provide
> details.

See below.

> > Unfortunately, code enforces different rules than documentation says,
> 
> Please specify your problem with rules vs. documentation. You mean the
> additional checks which also block wildcards and spaces/newline in the
> name ? Are you having a problem with those ? What are those problems ?
> I'll be more than happy to update the documentation if your problem
> is with that mismatch.

Yes, it sounds like documentation should be updated.

> To provide some detail: libsensors gets just as confused with wildcards
> and whitespace/newline as it does with '-' in the reported name, which
> is why those are blocked by the new API.

> > and it is all visible to userspace.
> > 
> We are talking about a value reported by an attribute, not about an attribute.
> Maybe the ABI Police thinks differently, but I do not count fixing the value
> reported by an attribute as an ABI change.

The rule is not what you think it is. It does not matter if it is
attribute or value. It is about breaking userspace.

And this is the attribute userland will use to search for sensor it
works with, right? So changing this attribute will break userspace if
someone uses it. N900 already > 2 temperature sensors on, so someone
may actually be using it.

> Effecively, what this enforcement does is to make userspace actually work.
> Ultimately that means, per your standard, that fixing values reported by the
> kernel is not permitted under any circumstances, even if such changes result
> in userspace actually working as intended as a result of that change.
> I would argue that such an enforcement goes a little bit too far.

You can argue whatever you want, but the rule is "no regressions". You
may not break userspace app A to fix userspace app B.

> In addition, there is actually another problem solved by the patch you want to
> have reverted: The current thermal code has another problem, which is that it
> creates the name attribute _after_ registering the hwmon device. The udev event
> for creating the hwmon device thus occurs before its mandatory name attribute
> (and any other attribute, for that matter) exists, meaning that any userspace
> handler acting on it would be completely unpredictable. Now _this_ is a real
> ABI "change", since it fixes a race condition. I guess you are going to argue
> that this isn't permitted either ?

You guessed wrong. It would only be problem if somone relied on that
race condition.

Anyway, I reported a rather serious regression in -rc5. The original
patch was obviously not understood enough, and it broke charging on my
hardware. I'd argue it had no reason to be in -rc5 in the first place.

I believe solution is obvious. Revert the damn patch. I actually
wonder why we are discussing it.

Maintainer suggested different solution, but you said it was broken.

You are suggesting modification of two driver names on N900. You don't
know what sideeffects it might have. You don't know if there are more
driver names to fix. You did not offer a patch.

It is an ugly regression and it is -rc5 time. Actually not your
problem, but Fabio Estevam or Zhang Rui has to deal with it soon.

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/9ac43c2b/attachment.sig>
