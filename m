From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 17 Jan 2011 09:41:46 +1300
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <AANLkTikjnz6RBCpOZM2imzX3d1ANUkaOZ2Qg9nqhpfpt@mail.gmail.com>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<20110110104122.GI12078@pengutronix.de>
	<20110110110028.GB12552@n2100.arm.linux.org.uk>
	<201101110854.15653.jeremy.kerr@canonical.com>
	<AANLkTikjnz6RBCpOZM2imzX3d1ANUkaOZ2Qg9nqhpfpt@mail.gmail.com>
Message-ID: <4D33580A.8090007@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2011 08:26 PM, Grant Likely wrote:
> On Mon, Jan 10, 2011 at 5:54 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
>> Hi Russell,
>>
>>> Unless the locking problems can be resolved, the patches aren't ready.
>>>
>>> From what I've seen there's still quite a problem with what kind of
>>> lock to use in the clock - mutex or spinlock.
>>
>> Yes, the clock driver may either use a spinlock or mutex.
>>
>> However, this exactly the same as the current clock code, my patches do not
>> alter what we currently have.
>>
>> I do agree that we should define some specific semantics for the clock API
>> with regards to sleeping, and I'll start a new thread about that. But we
>> should definitely separate that issue from the problem of having multiple
>> definitions for struct clk, which is what these patches address.
> 
> Given that each current struct clk implementation makes it's own
> decisions about how to handle locking, would it not make sense to omit
> locking entirely?  At least as a first step?  Let the clock ops
> implement their own locking.  Make enable count management their
> responsibility too.  That's all that the lock protects anyway.  The
> clk_* apis can fall directly through to the ops hooks with no
> manipulation or locking.  The way v3 of the patch worked.

This doesn't really work in a generic API because the call sites need to
know whether it safe to call clk_enable/disable, etc from a
non-sleepable context. This has essentially the same problems as using a
union with both a mutex and a spinlock.

That said, although we are aiming for a generic clock API, it's usage
typically isn't. Most of the users of the clock API are machine/platform
specific drivers and so they can make assumptions about the
implementation of the clock API calls. We currently do have a generic
set of clock calls which do not define rules about calling from atomic
context. We have a number of drivers, for several platforms, using the
clk_enable/disable calls. Some platforms are using sleeping clocks and
others are using atomic clocks, but because the _usage_ of the API is
largely platform specific it all hangs together.

This is a bit ugly in practice. It's hardly desirable to have an API
which looks generic, but in reality is platform/machine specific. I'm
guessing that a large benefit of having a unified API and well defined
rules about whether clock API calls may sleep or not allows the usage of
the clock API to become more generic.

I agree with Russell that the best short term approach is to create two
clock APIs, one for clocks which are atomic and the other for clocks
which need to sleep. If nothing else this at least allows the rules
about calling context to nailed down.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
