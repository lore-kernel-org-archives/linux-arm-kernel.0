From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 7 Oct 2013 17:53:02 -0700
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for BE
 correct operation
In-Reply-To: <52533A70.5040705@ti.com>
References: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
 <5252DA06.8000303@codethink.co.uk>
 <CAA3XUr2wYFL9WAQd9uAJSKK5KhWF3bPzYbh-3x=B3oLVXk79og@mail.gmail.com>
 <52533A70.5040705@ti.com>
Message-ID: <CAA3XUr0PGL=j4h3EaLACiax5EuY+CQYP8ZYq7gB_Rk4b9nTk+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Please see inline.

On 7 October 2013 15:49, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> Victor,
>
> On Monday 07 October 2013 12:37 PM, Victor Kamensky wrote:
>> On 7 October 2013 08:57, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>> On 07/10/13 17:48, Victor Kamensky wrote:
>>>>
>>>> Hi Will, Ben, Russell, Thomas,
>>>>
>>>> Please review second version of patch that fixes TLB asid issue in big
>>>> endian
>>>> V7 image.
>>>>
>>>> Changes from v1:
>>>>     Note previous patch subject line was 'ARM: tlb:
>>>>     __flush_tlb_mm need to use int asid var for BE correct operation'
>>>>
>>>>     Added 'unsigned int' cast into ASID macro itself rather
>>>>     then use intermediate 'int' variable in __flush_tlb_mm function.
>>>>     This is done per v1 patch discussion at
>>>>
>>>>
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/202583.html
>>>>
>>>> Tested with Linaro BE topic branch on Arndale board. Both LE and BE
>>>> images were tested.
>>>
>>>
>>> If you are booting on the Arndale board, is there a patch to mark
>>> the relevant Exynos devices as BE capable?
>>
>> Arndale need massive fixes in their BSP layer to be endian agnostic
>> ARM V7 platform. Unfortunate it is not as simple as with few others
>> that already marked as BE capable.
>>
>> Please see
>> https://git.linaro.org/gitweb?p=people/victor.kamensky/linux-linaro-tracking-be.git;a=shortlog;h=refs/heads/llct-be-topic
>> Mostly it is __raw_xxx conversion to xxx_relaxed, but there are
>> more subtle changes (some of them similar to changs that you've
>> done for other platforms). Also there are known unfixed issues like
>> disabling CONFIG_MMC_DW_IDMAC config because idmac
>> DMA related code is not endian agnostic yet (btw interesting class
>> of BE related problem that was not seen before).
>>
>> In Linaro we use Arndale and Pandaboard as reference platforms
>> therefore we have BE BSP fixes in our tree. But I am not sure
>> what is fate of those in long term. Also we consider these as
>> example of BSP changes that other BSP need to do.
>>
>> If Exynos and OMAP owners will have any interest for BE images,
>> and would like to see these changes in main line, we gladly
>> will work on this. Otherwise changes like this can mess up with
>> BSP ongoing drivers development.
>>
> BE support in mainline is definitely we are interested for OMAP
> and rest of the TI SoCs.

OK, let's get agreement on __raw_xxx issue as per your note below.
We will have discussion about OMAP BE changes in mainline,
within LNG BE group and I think we could try to push OMAP BE
changes out.

>> I think above position is consistent with similar discussion on
>> some of BE related threads - changing BSP to support BE mode
>> is BSP owners call.
>>
> Am just wondering a better method than the patch [1] which touches
> many drivers for readl/writel() replacement. Drivers are using
> that as standard based on device driver guide

Do you have pointer for above?

> and was thinking
> we should not change that rule to support BE. We definitely need
> to get the byte swap achieved but probably through some other
> means.

__raw_read[lw] and __raw_write[lw] change idea for BE images was
already discussed in [1]. Semantics of __raw_xxx function, vs xxx,
vs xxx_relaxed, somewhat explained at [2]. [2] references LKML
thread on similar subject.

As it stands now (at least in my understanding):
__raw_xxx - is native byte order operations, non mem barriers, cannot
      be used to read LE hw in endian agnostic way
xxx - reads/writes LE h/w byteswapa to target byte order if needed, uses
      mem barriers, it is already endian agnostic
xxx_relaxed - read LE h/w,  byteswapa to target byte order if needed,
      no mem barriers, should be used to read LE h/w in endian agnostic
      way, they are the same as __raw_xxx plus proper byteswaps.

That should go for all CPU types. As Will wrote on [1] it will be really
hard to change it. I agree with that.

Having said above I would like to notice that practically all cases where
__raw_xxx are used directly in Pandaboard and Exynos drivers
should be replaced with xxx_relaxed variant. I run into only one exception [3].

In fact when I get update, I apply hack patch that makes all inline functions
in arch/arm/include/asm/io.h instead of __raw_xxx function to use
_raw_xxx function which are added as exact copies of __raw_xxx, and
then I run small script with 'readelf --debug-dump vmlinux' and awk
that catches all direct uses of __raw_xxx functions, except [3] I
never saw case where __raw_xxx should not be replaced with xxx_relaxed.

I agree on your sentiment that when big diff with just
simple rename in many places will go in, it could be very disruptive,
and it will take time to change people's habits, but personally I  don't
see any other way.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186000.html
[2] http://stackoverflow.com/questions/9818657/whats-the-difference-b-w-raw-readl-raw-writel-and-readl-writel-in-linux-ker
[3] https://git.linaro.org/gitweb?p=people/victor.kamensky/linux-linaro-tracking-be.git;a=commitdiff;h=7c78d140b4a3a46e7fa2979889c341f297e3fd6c

> Regards,
> Santosh
> [1] https://git.linaro.org/gitweb?p=people/victor.kamensky/linux-linaro-tracking-be.git;a=commit;h=9074a67ab082c62545683e5ec909368a23c33655
