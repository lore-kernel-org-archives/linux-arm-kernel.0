From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 27 Feb 2014 12:33:37 +0900
Subject: [PATCH] ARM: shmobile: Check r8a7791 MD21 at SMP boot
In-Reply-To: <CAMuHMdXKdN+LrhhCFKgO4=2ez0qiyc8EhtBLPzrfxmBMLpGX7Q@mail.gmail.com>
References: <20140226095916.15676.99394.sendpatchset@w520>
 <CAMuHMdXKdN+LrhhCFKgO4=2ez0qiyc8EhtBLPzrfxmBMLpGX7Q@mail.gmail.com>
Message-ID: <CANqRtoQbx4LvaFxd_O6Em79QceSadVq93mJhyrDiD370VaXgWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wed, Feb 26, 2014 at 7:11 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Feb 26, 2014 at 10:59 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On r8a7791 the hardware boot mode bit MD21 indicates if hardware
>> debug mode is enabled or not. In case hardware debug mode is enabled
>> print a warning and refrain from booting secondary CPU cores.
>>
>> Without this patch Koelsch with SW8-4 set to OFF will hang at SMP boot.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> On Koelsch:
>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks.

>>  This is a reworked version of the APMU patch previously posted as
>>  [PATCH] ARM: shmobile: Check MD21 at SMP boot in case of APMU
>
> Your previous version also affected r8a7790/Lager.
> Isn't this check no longer needed there? According to the Lager manual,
> MD21 also enables hardware debug mode, and is also controlled by
> SW8-4. Of course the CPU may behave differently, as the CPU cores
> are different.

Yes, you are correct that the previous version of the patch also
affected Lager. And that both r8a7790 and r8a7791 mention the MD21 bit
together with JTAG debugging.

I recently used the patch on Lager and I discovered that I apparently
had been running with MD21 on my Lager since forever, and surprisingly
it worked regardless. Since there is no documentation on r8a7790 or
r8a7791 I simply decided to handle them separately and only enable
where it is needed.

I've also been told that it is possible to allow SMP operation
together with JTAG, apparently some magic with RST is needed. It seems
that the power domains are treated differently depending on the MD21
setting. Not sure if this applies to both r8a7790 and r8a7791, but if
we end up with similar fixes we can consolidate. Until then I think
dealing with them one by one makes sense.

Cheers,

/ magnus
