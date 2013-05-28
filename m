From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 28 May 2013 18:25:44 +0800
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
In-Reply-To: <20130528081910.GA29557@gmail.com>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
 <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
 <20130528081910.GA29557@gmail.com>
Message-ID: <51A48628.9030105@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2013 04:19 PM, Ingo Molnar wrote:
>> > And I come back to one of my previous arguments - is it not better to 
>> > panic() if we hit one of these conditions so that the system can try to 
>> > do a panic-reboot rather than continue blindly into the unknown?
> It will often continue blindly into the unknown even if the compiler is 
> happy ...
> 

For Server, it is necessary to always enable CONFIG_BUG and call panic()

When analyzing core dump or KDB trap, we have to assume that the kernel
has already "continued blindly", but lucky, we can get the core dump or
KDB trap finally (sometimes, we really even can not get core dump or KDB
trap).


For PC, it is useless to disable CONFIG_BUG

The PC memory has already large enough to skip the minimal size
optimization. And its speed is also high enough to skip the speed
improvement by minimal size optimization.


For Embedded system, some of architectures may disable CONFIG_BUG.

Embedded system are widely used in many area, so the requirement of each
architectures for BUG() may be different,

  some may need reboot as quickly as possible for urgent processing;
  some may need dead looping in BUG() for avoid user amazing;
    (if auto-reboot, users feel out of control, don't know what happens)
  some may still need panic() just like Server requirements.
  others may not care about it, just implement it as minimal size.



> The only difference is that i

t's "unpredictable" in a way not visible from
> the C code: the code won't necessarily fall through the BUG() when hitting 
> that condition - although in practice it probably will.
> 
> So I think the same principle applies to it as to any other debugging 
> code: it's fine to be able to turn debugging off. It's a performance 
> versus kernel robustness/determinism trade-off.

'minimal size' for BUG() is belongs to some of Embedded system specific
features, it is not 'generic' enough to be in "include/asm-generic/".

If we still provide the "disable CONFIG_BUG", some of 'crazy users'
(e.g. randconfig) may make 'noise' to most of architectures.

So we need not provide "disable CONFIG_BUG" features for all platforms,
since most of architectures need not support it, and the architecture
which really need minimal size, can implement it by itself as a
architecture specific feature.



Thanks.
-- 
Chen Gang

Asianux Corporation
