From: zhongjiang@huawei.com (zhong jiang)
Date: Fri, 16 Dec 2016 20:56:30 +0800
Subject: [RESEND PATCH 2/2] arm64: make WANT_HUGE_PMD_SHARE depends on
 HUGETLB_PAGE
In-Reply-To: <20161216123512.GF13191@arm.com>
References: <1481725151-20549-1-git-send-email-zhongjiang@huawei.com>
 <1481725151-20549-3-git-send-email-zhongjiang@huawei.com>
 <5853AF6D.20305@huawei.com> <20161216123512.GF13191@arm.com>
Message-ID: <5853E47E.3040100@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/16 20:35, Will Deacon wrote:
> On Fri, Dec 16, 2016 at 05:10:05PM +0800, zhong jiang wrote:
>> On 2016/12/14 22:19, zhongjiang wrote:
>>> From: zhong jiang <zhongjiang@huawei.com>
>>>
>>> when HUGETLB_PAGE is disable, WANT_HUGE_PMD_SHARE contains the
>>> fuctions should not be use. therefore, we add the dependency.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  arch/arm64/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 969ef88..694ca73 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -640,6 +640,7 @@ config SYS_SUPPORTS_HUGETLBFS
>>>  
>>>  config ARCH_WANT_HUGE_PMD_SHARE
>>>  	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>>> +	depends on HUGETLB_PAGE
>>>  
>>>  config ARCH_HAS_CACHE_LINE_SIZE
>>>  	def_bool y
>> Hi,
>>       I still think it is a issue. Perhaps above changelog is unclear.  Further explain is as follows.
>>  when hugetlb_pages is disable and arch_want_huge_pmd_share is enable,   we maybe call
>>  huge_pmd_sahre in hugetlbpage.c, but the function actually is not definition as it is not
>>  exported.  is it right ??
> The only users of ARCH_WANT_HUGE_PMD_SHARE on arm64 are:
>
> arch/arm64/mm/hugetlbpage.c:            if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
  yes
> mm/hugetlb.c:#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> mm/hugetlb.c:#else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> mm/hugetlb.c:#endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
>
> and neither of those files are compiled if !HUGETLB_PAGE.
  Indeed, but  The only users maybe use it  if !HUGETLB_PAGE. 
  because  include/linux/hugetlb.h  can not export the reference if !HUGETLB_PAGE.
  IOW,  the function is not definition.  

  is it right ? or I miss the key point.
> Are you actually seeing a problem here?
  I review the code and find the issue.

 Thanks
 zhongjiang
> Will
>
> .
>
