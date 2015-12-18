From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 18 Dec 2015 10:43:39 -0800
Subject: [PATCH 0/3] Batched user access support
In-Reply-To: <56745175.9010006@zytor.com>
References: <alpine.LFD.2.20.1512171016510.27310@i7>
 <20151218111346.GF30483@arm.com> <56745175.9010006@zytor.com>
Message-ID: <CA+55aFyAts-EGzmybdm93WZU_G4rAbpvONNt12s-ozy=SBbzGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 10:33 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 12/18/15 03:13, Will Deacon wrote:
>>
>> I'm pretty unimaginative when it comes to security exploits, but that
>> does sound worse than the current implementation from a security
>> perspective.
>>
>
> It is, but it is a tradeoff.  It is way better than opening it up for
> the entire kernel.

So I wouldn't worry about the security part as long as we *only* do
this in core library routines, and never really expose it as some kind
of direct generic interface for random users.

It's one of the reasons I named those functions "unsafe". They really
aren't any more unsafe than the double underscore functions (which I
really dislike outside of core kernel code too), but it's just a bad
bad idea to use these in random drivers etc.

In fact, my first version of the patch restricted the code to only
non-module builds, but I ended up not posting that because the extra

   #ifndef MODULE
   ...
   #endif

just made it a bit uglier.

But I suspect we should do that in the long run. In fact, I would want
to do that for the __{get,put}_user() functions too, because there
really is no valid reason for drivers to use them.

So I would very strongly advocate that we only ever use these new
functions only for very core functions. Exactly things like
"strncpy_from_user()" and friends. I'd also possibly see it for things
like "cp_new_stat()", which right now copies to a temporary struicture
on the kernel stack, and then uses a "copy_to_user()" to copy the
temporary to user space. It's another very hot function on similar
stat-hot workloads, although in profiles it ends up not showing quite
as hot because the profile is split between the "set up on the kernel
stack" and the actual user copy.

                 Linus
