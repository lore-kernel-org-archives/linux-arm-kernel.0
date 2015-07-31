From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 09:03:50 +0200
Subject: [PATCH v7 3/5] clk: Supply the critical clock {init, enable,
 disable} framework
In-Reply-To: <20150728130055.GV14943@x1>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
 <1437570255-21049-4-git-send-email-lee.jones@linaro.org>
 <20150727072549.GP2564@lukather> <20150727085338.GW3436@x1>
 <20150728114022.GW2564@lukather> <20150728130055.GV14943@x1>
Message-ID: <20150731070350.GT2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 02:00:55PM +0100, Lee Jones wrote:
> > > I don't think we can use reference counting, because we'd need as
> > > many critical clock owners as there are critical clocks.
> > 
> > Which we can have if we replace the call to clk_prepare_enable you add
> > in your fourth patch in __set_critical_clocks.
> 
> What should it be replaced with?

clk->critical_count++
clk_prepare_enable

?

> 
> > > Cast your mind back to the reasons for this critical clock API.  One
> > > of the most important intentions of this API is the requirement
> > > mitigation for each of the critical clocks to have an owner
> > > (driver).
> > > 
> > > With regards to your second point, that's what 'critical.enabled'
> > > is for.  Take a look at clk_enable_critical().
> > 
> > I don't think this addresses the issue, if you just throw more
> > customers at it, the issue remain with your implementation.
> > 
> > If you have three customers that used the critical API, and if on of
> > these calls clk_disable_critical, you're losing leave_on.
> 
> That's the idea.  See my point above, the one you replied "Indeed"
> to.  So when a driver uses clk_disable_critical() it's saying, "I know
> why this clock is a critical clock, and I know that nothing terrible
> will happen if I disable it, as I have that covered".

We do agree on the semantic of clk_disable_critical :)

> So then if it's not the last user to call clk_disable(), the last
> one out the door will be allowed to finally gate the clock,
> regardless whether it's critical aware or not.

That's right, but what I mean would be a case where you have two users
that are aware that it is a critical clock (A and B), and one which is
not (C).

If I understood correctly your code, if A calls clk_disable_critical,
leave_on is set to false. That means that now, if C calls clk_disable
on that clock, it will actually be shut down, while B still considers
it a critical clock.

> Then, when we come to enable the clock again, the critical aware user
> then re-marks the clock as leave_on, so not critical un-aware user can
> take the final reference and disable the clock.
> 
> > Which means that if there's one of the two users left that calls
> > clk_disable on it, the clock will actually be disabled, which is
> > clearly not what we want to do, as we have still a user that want the
> > clock to be enabled.
> 
> That's not what happens (at least it shouldn't if I've coded it up
> right).  The API _still_ requires all of the users to give-up their
> reference.

Ah, right. So I guess it all boils down to the discussion you're
having with Mike regarding whether critical users should expect to
already have a reference taken or calling clk_prepare / clk_enable
themselves.

> 
> > It would be much more robust to have another count for the critical
> > stuff, initialised to one by the __set_critical_clocks function.
> 
> If I understand you correctly, we already have a count.  We use the
> original reference count.  No need for one of our own.
> 
> Using your RAM Clock (Clock 4) as an example
> --------------------------------------------
> 
> Early start-up:
>   Clock 4 is marked as critical and a reference is taken (ref == 1)
> 
> Driver probe:
>   SPI enables Clock 4 (ref == 2)
>   I2C enables Clock 4 (ref == 3)
> 
> Suspend (without RAM driver's permission):
>   SPI disables Clock 4 (ref == 2)
>   I2C disables Clock 4 (ref == 1)
>   /*
>    * Clock won't be gated because:
>    *   .leave_on is True - can't dec final reference
>    */
> 
> Suspend (with RAM driver's permission):
>   /* Order is unimportant */
>   SPI disables Clock 4 (ref == 2)
>   RAM disables Clock 4 (ref == 1) /* Won't turn off here (ref > 0)
>   I2C disables Clock 4 (ref == 0) /* (.leave_on == False) last ref can be taken */
>   /*
>    * Clock will be gated because:
>    *   .leave_on is False, so (ref == 0)
>    */
> 
> Resume:
>   /* Order is unimportant */
>   SPI enables Clock 4 (ref == 1)
>   RAM enables Clock 4 and re-enables .leave_on (ref == 2)
>   I2C enables Clock 4 (ref == 3)
> 
> Hopefully that clears things up.

It does indeed. I simply forgot to take into account the fact that it
would still need the reference to be set to 0. My bad.

Still, If we take the same kind of scenario:

Early start-up:
  Clock 4 is marked as critical and a reference is taken (ref == 1, leave_on = true)

Driver probe:
  SPI enables Clock 4 (ref == 2)
  I2C enables Clock 4 (ref == 3)
  RAM enables Clock 4 (ref == 4, leave_on = true )
  CPUIdle enables Clock 4 (ref == 5, leave_on = true )

Suspend (with CPUIdle and RAM permissions):
  /* Order is unimportant */
  SPI disables Clock 4 (ref == 4)
  CPUIdle disables Clock 4 (ref == 3, leave_on = false ) 
  RAM disables Clock 4 (ref == 2, leave_on = false )
  I2C disables Clock 4 (ref == 1)

And even though the clock will still be running when CPUIdle calls
clk_disable_critical because of the enable_count, the status of
leave_on is off, as the RAM driver still considers it to be left on
(ie, hasn't called clk_disable_critical yet).

Or at least, that's what I understood of it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/780c6dca/attachment.sig>
