From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 11 Nov 2013 17:15:29 +0000
Subject: kernel BUG at kernel/kallsyms.c:222!
In-Reply-To: <CACVXFVOnVXcVdRCm=OfPjpvvWCiXi8GRV+9ViOGmSZ3tTf6WDg@mail.gmail.com>
References: <1383789208.5970.1.camel@phoenix>
 <CACVXFVO=QA-R1+twCL9fc_3vASg6Ap-3ezi=tU1MV1pdPYrfWw@mail.gmail.com>
 <CAFRkauAdR3=ByE0_B3OsqOBjmbz2a02EXb+6g-vn=1TJ7AZc8Q@mail.gmail.com>
 <CACVXFVMaLOfDvzdn_1NryQY59cgtLdMMqHL-_ZAa95MPz4p56Q@mail.gmail.com>
 <CAFRkauDe7V3N0AbfvE_=GEXHZ_Fw62VsA8p50wSUYE1-TRqMfw@mail.gmail.com>
 <87zjpf4w0j.fsf@rustcorp.com.au>
 <CACVXFVNHryPXy2NQhPwXkoCeLUXQSgrWmgBkMNtGD_=X_62_5Q@mail.gmail.com>
 <CAFRkauDGiy3yZOwKFWMEJvYUe0OoXMEZHKaxogZHdgzMxexdHA@mail.gmail.com>
 <CACVXFVMAnewCkSNNke3kf1-yO+JCc_HBRp8iaLBPJ+14G79Haw@mail.gmail.com>
 <87y54vzszo.fsf@rustcorp.com.au>
 <CAFRkauBYUq3UAjqLvkuDVEz5BVyDpC0DuVRGTe4K+kcoCX17GA@mail.gmail.com>
 <CACVXFVMvvG1unnR0rsmBMdp9p19Q3JRbURxZF-UWxvrThDPKTw@mail.gmail.com>
 <CAFRkauCW3FDSuh4t0gvmSWH1m0+qaG0XSoBxmk30Wq1FMy7iFw@mail.gmail.com>
 <CACVXFVMzOzD+D-MQCUBvC80d4zS-TJfcucKuUvzerGs6gT1fEg@mail.gmail.com>
 <CACVXFVOnVXcVdRCm=OfPjpvvWCiXi8GRV+9ViOGmSZ3tTf6WDg@mail.gmail.com>
Message-ID: <528110B1.4060402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/13 10:41, Ming Lei wrote:
> Hi,
> 
> On Mon, Nov 11, 2013 at 5:57 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>> Hi,
>>
>> On Mon, Nov 11, 2013 at 4:37 PM, Axel Lin <axel.lin@ingics.com> wrote:
>>> 2013/11/11 Ming Lei <tom.leiming@gmail.com>:
>>>
>>> Hi Ming,
>>>
>>> commit f6537f2f "scripts/kallsyms: filter symbols not in kernel address space",
>>> uses CONFIG_PAGE_OFFSET as kernel_start_addr.
>>> However, for !CONFIG_MMU case we have :
>>>      PAGE_OFFSET != CONFIG_PAGE_OFFSET.
>>
>> Yes, it is the cause, and strictly speaking, commit f6537f2f is wrong,
>> but triggered with bogus CONFIG_PAGE_OFFSET if !CONFIG_MMU.
>>
>> We can fix it either by Rusty's patch or removing the bogus
>> CONFIG_PAGE_OFFSET for !CONFIG_MMU.
> 
> Rusty, maybe we need revert commit f6537f2f "scripts/kallsyms: filter
> symbols not in kernel address space", since CONFIG_PAGE_OFFSET
> may be bogus on !MMU or not defined on ARCHs(most of 64bit arch,
> no regression report because scripts/kallsyms may get zero
> kernel_start_addr)
> 

For me on Cortex-R7 (nommu) f6537f2f breaks boot (Oops very early on...)
and reverting it fixes the problem... However, as you note, we have a
'bogus' CONFIG_PAGE_OFFSET (0xC0000000) for !MMU so another approach would
be to fix that...

I've tested the patch below and it solves the ARM side of things - so
gives you an option other than a complete revert. Happy to put this in to
RMK's patch system if you'd prefer not to have to revert and he's happy
with the patch.

Jonny

-------->8-----------

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d601be3..6756651 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1609,6 +1609,7 @@ endchoice
 
 config PAGE_OFFSET
        hex
+       default PHYS_OFFSET if !MMU
        default 0x40000000 if VMSPLIT_1G
        default 0x80000000 if VMSPLIT_2G
        default 0xC0000000
