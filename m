From: geoff@infradead.org (Geoff Levand)
Date: Tue, 29 Jul 2014 14:19:01 -0700
Subject: Kexec on arm64
In-Reply-To: <20140729133557.GQ2576@leverpostej>
References: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke> <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej> <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej>
Message-ID: <1406668741.28348.75.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 2014-07-29 at 14:35 +0100, Mark Rutland wrote:
> Since c218bca74eea (arm64: Relax the kernel cache requirements for
> boot), the kernel will flush the cache for anything outside of the Image
> that it writes to before enabling the MMU and caches (e.g. the idmap and
> swapper page tables). Once caches are up we shouldn't care.
> 
> Assuming that the existing kernel code is correct, the only region we
> should need to flush out to the PoC is the region from _text to _edata
> (i.e. just the contents of the Image).

If the new kernel will overwrite the old one, then we do the final copy
of the new kernel in the relocate_new_kernel routine.  relocate_new_kernel
is executed after the dcache is disabled, so that should write it directly
to the PoC.  It seems the protocol expects us to invalidate the dcache
for that range though, so I added code to do this, essentially what Arun
had added.

Arun, please try.

-Geoff
