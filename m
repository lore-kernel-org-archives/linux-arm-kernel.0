From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Oct 2012 18:19:34 +0000
Subject: [Xen-devel] [PATCH 5/9] ARM: Xen: fix initial build problems:
In-Reply-To: <1349799035.21847.222.camel@zakaz.uk.xensource.com>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <201210091539.46274.arnd@arndb.de>
 <1349799035.21847.222.camel@zakaz.uk.xensource.com>
Message-ID: <201210091819.34310.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 October 2012, Ian Campbell wrote:
> On Tue, 2012-10-09 at 16:39 +0100, Arnd Bergmann wrote:
> > On Tuesday 09 October 2012, Ian Campbell wrote:
> > > > * The tmem hypercall is not available on ARM
> > > > 
> > > > * ARMv6 does not support cmpxchg on 16-bit words that are used in the
> > > 
> > > missing the end of this sentence?
> > 
> > Right, I meant to say 
> > 
> > * ARMv6 does not support cmpxchg on 16-bit words that are used in the
> >   Xen grant table code, so we must ensure that Xen support is only built
> >   on ARMv7-only kernels not combined ARMv6/v7 kernels.
> > 
> > This should be fixed differently in the future.
> 
> Is this is a build time failure because gcc/gas/etc refuses to generate
> these instructions if it is configured for v6?
> 
> I ask because if it is only a runtime issue then we can reason that if
> we are running Xen specific grant table code, then we must be running on
> Xen and therefore must necessarily be running on a v7 (because Xen only
> support v7+virt extensions) even if the kernel happens to be capable of
> running on v6 too.

The underlying reason of course is that ARMv6 doesn't have those
instructions. The symptom you see is a link error because gcc emits
a reference to the (intentionally missing) __bad_cmpxchg() function
from

static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
                                      unsigned long new, int size)
{
        unsigned long oldval, res;

        switch (size) {
#ifndef CONFIG_CPU_V6   /* min ARCH >= ARMv6K */
        case 1:
		...
                break;
        case 2:
		...
                break;
#endif
        case 4:
		...
                break;
        default:
                __bad_cmpxchg(ptr, size);
                oldval = 0;
        }
        return oldval;
}

The possible solutions I can see for this are:

* change the grant table format to use 32 bits for the flags on ARM
* change the code to always cmpxchg the entire 32 bit word including the flags.
* implement your own cmpxchg wrapper that may be implemented using a spinlock
  rather than cmpxchg if ARMv6 is enabled.

	Arnd
