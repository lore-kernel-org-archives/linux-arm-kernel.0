From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 17 Dec 2015 10:33:21 -0800 (PST)
Subject: [PATCH 0/3] Batched user access support
Message-ID: <alpine.LFD.2.20.1512171016510.27310@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


So I already sent the end result of these three patches to the x86 people, 
but since I *think* it may bve an arm64 issue too, I'm including the arm64 
people too for information.

Background for the the arm64 people: I upgraded my main desktop to 
Skylake, and did my usual build performance tests, including a perf run to 
check that everything looks fine. Yes, the machine is 20% faster than my 
old one, but the profile also shows that now that I have a CPU that 
supports SMAP, the overhead of that on the user string handling functions 
was horrendous.

Normally, that probably isn't really noticeable, but on loads that do a 
ton of pathname handling (like a "make -j" on the fully built kernel, or 
doing "git diff" etc - both of which spend most of their time just doing 
'lstat()' on all the files they care about), the user space string 
accesses really are pretty hot.

On the 'make -j' test on a fully built kernel, strncpy_from_user() was 
about 1.5% of all CPU time. And almost two thirds of that was just the 
SMAP overhead.

So this patch series introduces a model for batching that SMAP overhead on 
x86, and the reason the ARM people are involved is that the same _may_ be 
true of the PAN overhead. I don't know - for all I know, the pstate "set 
pan" instruction may be so cheap on ARM64 that it doesn't really matter.

Thew new interface is very simple: new "unsafe_{get,put}_user()" functions 
that have exactly the same semantics as the old unsafe ones (that weren't 
called "unsafe", but have the two underscores). The only difference is 
that you have to use "user_access_{begin,end}()" around them, which allows 
the architecture to hoist the user access permission wrapper to outside 
the loop, and then batch the raw accesses.

The series contains this addition to uaccess.h:

  #ifndef user_access_begin
  #define user_access_begin() do { } while (0)
  #define user_access_end() do { } while (0)
  #define unsafe_get_user(x, ptr) __get_user(x, ptr)
  #define unsafe_put_user(x, ptr) __put_user(x, ptr)
  #endif

so architectures that don't care or haven't implemented it yet, don't need 
to worry about it. Architectures that _do_ care just need to implement 
their own versions, and make sure that user_access_begin is a macro (it 
may obviously be an inline function and just then an additional 
self-defining macro).

Any comments? 

                   Linus
