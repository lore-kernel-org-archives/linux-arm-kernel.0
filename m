From: linux@horizon.com (George Spelvin)
Date: 13 Aug 2015 15:09:25 -0400
Subject: enabling libgcc for 64-bit divisions,
 was Re: PROBLEM: XFS on ARM corruption 'Structure needs cl
In-Reply-To: <CA+55aFw9-sN0nHn-ohdhSEt9i-mUjXN3fBj+dXLg56jgsOwgDw@mail.gmail.com>
Message-ID: <20150813190925.16478.qmail@ns.horizon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> On x86, the case that msword >= divsor causes a divide exception
>> (divide ba generalization of divide by zero), so it's tempting
>> to do the same sort of "assume no trap and fix up in the handler"
>> trick as <asm/uaccess.h>.

> That would be horrible. One of the reasonably common cases of do_div()
> is for printing out numbers. And they are often in the 4G+ range..

Actually, printing numbers is *not* such an instance; I've had my fingers
in lib/vsprintf.c, and since the divisor is constant, it uses reciprocal
multiplies.

The only instance of do_div in lib/vsprintf.c is in a version of put_dec()
which is used only if BITS_PER_LONG == 64.  If bits_per_long == 32,
it uses a neat hack due to Douglas Jones which avoids using divide
instructions entirely!

(Commit 133fd9f5cd if you are curious.)


The hot paths with 64-bit results are in the block layer and RAID
code, and that's why I wasn't seriously suggesting replacing *all*
instances; it was more of a static code size diet hack.

(It's also not likely worth the maintenance burden of the additional
code subtlety.  "Tempting" is not necessarily a good idea.)
