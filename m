From: achandran@mvista.com (Arun Chandran)
Date: Wed, 27 Aug 2014 10:26:45 +0530
Subject: Kexec on arm64
In-Reply-To: <1409092348.21254.9.camel@smoke>
References: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej>
 <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej>
 <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
 <1407172869.8971.54.camel@smoke>
 <CAFdej02ZsLuxd84fb-n9Q2yuhzqRba5cmx6G8pHk3QeqzpTLaQ@mail.gmail.com>
 <1407442058.8971.106.camel@smoke>
 <CAFdej03udSLMEneKM4YGiNe-HTQwZrGQ5J6DfB6qaq8X8A27CQ@mail.gmail.com>
 <CAFdej02gA7mpkdarjZ+66C252K+grhCa4uXm8PTV4ioKXZKqjQ@mail.gmail.com>
 <CAFdej01msBA8Ry=Ek3NpYPUBgvw_4G6w+68oRvGC6_AVRvudjQ@mail.gmail.com>
 <CAFdej03fgXQz1Pey4HtCBy5ePxMgJwkBGHWd7f8=jWBx1WvDgA@mail.gmail.com>
 <1409092348.21254.9.camel@smoke>
Message-ID: <CAFdej00aikr8t0X3eFGUCpGPZeEvtm3JK22OoyZtAgzx2K40Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Wed, Aug 27, 2014 at 4:02 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Arun,
>
> On Wed, 2014-08-13 at 16:39 +0530, Arun Chandran wrote:
>> I have one more concern regarding flushing of D-cache area corresponding
>> to the kexec_list entrees.
>>
>> Currently kexec_list_walk() is doing
>>
>> 1) flush_dcache_area of the kexec_list[0] till PAGE_SIZE
>>
>> 2) continue accessing entries in kexec_list[0] to PAGE_SIZE
>>
>> 3) switch to next kexec_list depending upon kexec_list[entry] & flag
>> ==  IND_INDIRECTION
>>
>> 4) goto 1
>>
>> Shouldn't that be doing flush_dcache_area() after completely using the list??
>
> We just want to get any data in the dcache out to the PoC before
> disabling the dcache, so as long as there are only reads, and no writes
> to those addresses, kexec_list_walk() should work OK.
>
Yes. I missed that point. If we don't perform any writes flushing
works just fine.

> I will move the flush of the new kernel image to after it is copied in
> relocate_new_kernel().  I think that your L3 cache may not work with
> what we have now:
>
>   current:  invalidate dcache -> turn off dcache -> write data to PoC
>   proposed: turn off dcache -> write data to PoC -> invalidate dcache
>

Yes this exactly what I have done here
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/278857.html
; that code should live inside relocate_new_kernel().

I am doing the cache invalidation(only invalidation) in
relocate_new_kernel(). As we run that code after cache's are off(L3 only
comes to picture when lower level caches are on) we are writing
to data (new kernel) to PoC.

--Arun
