From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Feb 2016 14:39:07 +0000
Subject: linux-next: build failure after merge of the aio tree
In-Reply-To: <20160204143204.GC16315@kvack.org>
References: <20160112163835.GD347@kvack.org>
 <20160127134024.0fababf6@canb.auug.org.au>
 <20160129113056.GP10826@n2100.arm.linux.org.uk>
 <CAMuHMdUy-cqeN8COO4rdpY-mOH+6gth40wB31-edkj8CO5PFCw@mail.gmail.com>
 <20160204131959.6695c7bf@canb.auug.org.au>
 <20160204134142.GA16315@kvack.org>
 <20160204135056.GE10826@n2100.arm.linux.org.uk>
 <20160204140822.GB16315@kvack.org>
 <20160204141253.GF10826@n2100.arm.linux.org.uk>
 <20160204143204.GC16315@kvack.org>
Message-ID: <20160204143907.GG10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 09:32:04AM -0500, Benjamin LaHaise wrote:
> On Thu, Feb 04, 2016 at 02:12:53PM +0000, Russell King - ARM Linux wrote:
> > Hence, __get_user() on x86-32 with a 64-bit quantity results in
> > __get_user_bad() being called, which is an undefined function.
> > Only if you build with x86-64 support enabled (iow, CONFIG_X86_32 not
> > defined) then you get the 64-bit __get_user() support.
> > 
> > Given this, I fail to see how x86-32 can possibly work.
> 
> You're right; mea culpa.  It compiles without warning on x86-32, but it 
> does not link.  I still think this is broken archtecture stupidity since 
> put_user() works for 64 bit data types.

Indeed, and you'll find that several other architectures besides ARM and
x86-32 have exactly the same problem - as I listed in my message from a
few days ago.

Okay, so now I get to set you a challenge, since you're the one wanting
64-bit __get_user(): try implementing it on x86-32 :)

Also in my previous message from a few days ago I provided a set of
functions which test out the implementation.  Here they are... again.

All these should not produce any warnings, and should produce correct
code - especially the narrowing/widening tests:

int test_8(unsigned char *v, unsigned char *p)
{ return __get_user(*v, p); }
int test_8_constp(unsigned char *v, const unsigned char *p)
{ return __get_user(*v, p); }
int test_8_volatilep(unsigned char *v, volatile unsigned char *p)
{ return __get_user(*v, p); }
int test_16(unsigned short *v, unsigned short *p)
{ return __get_user(*v, p); }
int test_16_constp(unsigned short *v, const unsigned short *p)
{ return __get_user(*v, p); }
int test_32(unsigned int *v, unsigned int *p)
{ return __get_user(*v, p); }
int test_32_constp(unsigned int *v, const unsigned int *p)
{ return __get_user(*v, p); }
int test_64(unsigned long long *v, unsigned long long *p)
{ return __get_user(*v, p); }
int test_64_constp(unsigned long long *v, const unsigned long long *p)
{ return __get_user(*v, p); }
int test_ptr(unsigned int **v, unsigned int **p)
{ return __get_user(*v, p); }
int test_const(unsigned int *v, const unsigned int *p)
{ return __get_user(*v, p); }
int test_64_narrow(unsigned long *v, unsigned long long *p)
{ return __get_user(*v, p); }
int test_32_wide(unsigned long long *v, unsigned long *p)
{ return __get_user(*v, p); }

However, this one should warn:

int test_wrong(char **v, const char **p)
{ return __get_user(*v, p); }

Good luck (I think you'll need lots of it to get a working solution)! :)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
