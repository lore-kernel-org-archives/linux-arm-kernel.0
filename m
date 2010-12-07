From: mark@codesourcery.com (Mark Mitchell)
Date: Mon, 06 Dec 2010 19:02:30 -0600
Subject: RFC: Dynamic hwcaps
In-Reply-To: <AANLkTi=woxGqfpd12tr32FymOx77UnVehvEFQt5GnRzG@mail.gmail.com>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>	<20101203165105.GD30898@n2100.arm.linux.org.uk>	<AANLkTik9sqkbCPbcWUL+2otyfO1OZ=hx1tvSkQW65e4i@mail.gmail.com>	<4CFBAC6D.5060507@codesourcery.com>
	<AANLkTi=woxGqfpd12tr32FymOx77UnVehvEFQt5GnRzG@mail.gmail.com>
Message-ID: <4CFD87A6.8030104@codesourcery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/6/2010 5:07 AM, Dave Martin wrote:

>> But,
>> to enable binary distribution, having to have N copies of a library (let
>> alone an application) for N different ARM core variants just doesn't
>> make sense to me.
> 
> Just so, and as discussed before improvements to package managers
> could help here to avoid installing duplicate libraries.  (I believe
> that rpm may have some capability here (?) but deb does not at
> present).

Yes, a smarter package manager could help a device builder automatically
get the right version of a library.  But, something more fundamental has
to happen to avoid the library developer having to *produce* N versions
of a library.  (Yes, in theory, you just type "make" with different
CFLAGS options, but in practice of course it's often more complex than
that, especially if you need to validate the library.)

> Currently, I don't have many examples-- the main one is related to the
> discussions aroung using NEON for memcpy().  This can be a performance
> win on some platforms, but except when the system is heavily loaded,
> or when NEON happens to be turned on anyway, it may not be
> advantageous for the user or overall system performance.

How good of a proxy would the length of the copy be, do you think?  If
you want to copy 1G of data, and NEON makes you 2x-4x faster, then it
seems to me that you probably want to use NEON, almost independent of
overall system load.  But, if you're only going to copy 16 bytes, even
if NEON is faster, it's probably OK not to use it -- the function-call
overhead to get into memcpy at all is probably significant relative to
the time you'd save by using NEON.  In between, it's harder, of course
-- but perhaps if memcpy is the key example, we could get 80% of the
benefit of your idea simply by a test inside memcpy as to the length of
the data to be copied?

-- 
Mark Mitchell
CodeSourcery
mark at codesourcery.com
(650) 331-3385 x713
