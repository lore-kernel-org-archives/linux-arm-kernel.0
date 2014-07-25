From: achandran@mvista.com (Arun Chandran)
Date: Fri, 25 Jul 2014 17:18:04 +0530
Subject: Kexec on arm64
In-Reply-To: <1406247468.4062.59.camel@smoke>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
Message-ID: <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Fri, Jul 25, 2014 at 5:47 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi,
>
> On Thu, 2014-07-24 at 10:36 +0100, Mark Rutland wrote:
>> On Thu, Jul 24, 2014 at 01:38:07AM +0100, Geoff Levand wrote:
>
>> > All memory management for the main cpu is done by the arch code.  Kexec
>> > and cpu hot plug only work with the secondary cpus, so the problem would
>> > be in the arch memory code, either in setup_restart() for shutdown, or
>> > in the startup code.
>>
>> It's possible that soft_restart and setup_restart are a little dodgy, as
>> they also rely on the compiler being smart and not touching the stack
>> after setup_restart().
>>
>> However, they provide absolutely no guarantee that any data has been
>> flushed out to the PoC [1]. If you require any data to be flushed out to the
>> PoC so as to be visible to noncacheable accesses, you will need to
>> ensure that this is flushed by VA before soft_restart is called. Data
>> may have migrated to another cache (e.g. another CPU, or the L3) where
>> it is not visible.
>
> OK, kexec's reset routine relocate_new_kernel does use a few global
> variables that are set by the main kexec routines.  I added a call to
> __flush_dcache_area(), which uses 'dc civac' for those.
>
> I had thought the call to __flush_dcache_all, which uses 'dc cisw', in
> flush_cache_all() would be enough.
>
> Arun, I also fixed UP builds.  Could you pull my latest and try with L3
> enabled?
>
I got this working. As 'Mark Rutland' pointed in another mail that
it could be problem with flushing the cache; I did a read of
1GB data from start of RAM to a volatile var. I assume that
this will clear and invalidate all that in cache (L1=32K, L2=256 K, L3=8M)

###################
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 786daa6..90418f3 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -63,6 +63,10 @@ static inline void smp_secondary_shutdown(void) {}

 static void setup_restart(void)
 {
+       volatile u64 tmp;
+       volatile u64 *addr;
+
+       addr = (u64 *)(0xffffffc000000000);
        /*
         * Tell the mm system that we are going to reboot -
         * we may need it to insert some 1:1 mappings so that
@@ -75,6 +79,11 @@ static void setup_restart(void)
        /* Clean and invalidate caches */
        flush_cache_all();

+       for ( ;addr < (u64 *)0xffffffc040000000; addr++)
+       {
+               tmp = *addr;
+       }
+
        /* Turn D-cache off */
        cpu_cache_off();

###################

With the above change latest kernel @
https://git.linaro.org/people/geoff.levand/linux-kexec.git
is able to do kexec with L3 enabled in UP scenario.

--Arun













> -Geoff
>
