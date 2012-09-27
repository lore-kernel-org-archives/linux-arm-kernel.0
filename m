From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 27 Sep 2012 22:15:04 +0800
Subject: [BUG] Deferred probing in driver model is racy,
 resulting in lost probes
In-Reply-To: <20120927140300.GF14358@n2100.arm.linux.org.uk>
References: <20120818145856.GP18957@n2100.arm.linux.org.uk>
 <CACVXFVPahbFVEP4p2Z9-TvjQ52tUCMuDeLx0X6GP5t0h5gEV8g@mail.gmail.com>
 <20120916082510.GN12245@n2100.arm.linux.org.uk>
 <CACVXFVOZ=4HFAy38q_8ZUjOPffcv_mMTi7KCdh3HcX=MCLw5SQ@mail.gmail.com>
 <20120926200833.GA14340@kroah.com>
 <20120926202321.GD30938@n2100.arm.linux.org.uk>
 <CACVXFVPnpQ6yHiDaoo_CPG7oSEq+ZzxpmTgQv55-tRRyaavDfA@mail.gmail.com>
 <20120927135809.GE14358@n2100.arm.linux.org.uk>
 <20120927140300.GF14358@n2100.arm.linux.org.uk>
Message-ID: <CACVXFVPD4-Cj0Up6OAhFPSXh0Osk17j6kqf-QZzHf6P=AhQvhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 10:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 27, 2012 at 02:58:09PM +0100, Russell King - ARM Linux wrote:
>> On Thu, Sep 27, 2012 at 07:47:46AM +0800, Ming Lei wrote:
>> > On Thu, Sep 27, 2012 at 4:23 AM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> > > To be honest, I've not bothered to test the above patch, and now when I
>> > > look at it, I notice it's broken - in that on error it will corrupt the
>> > > driver list.  Take a look at the error path.
>> > >
>> > > priv is drv->p.  We add priv->knode_bus to the driver list.  If
>> > > driver_attach() returns an error, then we go to out_unregister, which
>> >
>> > In fact, driver_attach() always returns zero, so it does __not__ affect
>> > your test.
>>
>> It may not affect my test, but the fact is, that patch lays down the
>> foundations for bugs to be introduced.  Now, while I can test it (and
>> have done) I don't think it's suitable for mainline because of _that_.
>>
>> If driver_attach() always returns zero, there's no point in it returning
>> a value - it might as well return void and stop leading people to
>> believe that it might return an error.  So I suggest this alternative
>> patch instead, which gets rid of what is effectively dead code, and
>> probably a few warnings about not checking the return value from a
>> __must_check function (see usb-serial.c).
>>
>> With this patch, no one is lead into a false sense of security that,
>> after your patch, if driver_attach() ever returns an error, proper
>> cleanup will happen - it's blatently obvious to anyone modifying it
>> that if they do want it to return an error, they have to audit all the
>> users of it, which IMHO is a good thing.
>
> Sorry, old version of that patch.  Here's the right one.

IMO, it is better to take the one line change first since it is really
correct and easy to be backported to previous stable releases.


Thanks,
-- 
Ming Lei
