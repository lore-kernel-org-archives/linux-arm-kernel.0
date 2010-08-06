From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 06 Aug 2010 16:08:54 -0700
Subject: [PATCH] arm: msm: Add MSM IOMMU support.
In-Reply-To: <20100806085941.GA15852@n2100.arm.linux.org.uk>
References: <1281062204-21880-1-git-send-email-stepanm@codeaurora.org>
	<20100806073333.GA14965@n2100.arm.linux.org.uk>
	<93bd044b61aed19a3571bc019af0252a.squirrel@www.codeaurora.org>
	<20100806085941.GA15852@n2100.arm.linux.org.uk>
Message-ID: <4C5C9606.7040304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  On 8/6/2010 1:59 AM, Russell King - ARM Linux wrote:
> On Fri, Aug 06, 2010 at 01:17:46AM -0700, stepanm at codeaurora.org wrote:
>> Thank you for your comments. I will apply the fixes you have mentioned. I
>> am flushing the cache when I update the page table because the page table
>> lives in regular RAM that is mapped as cacheable on the CPU side, and in
>> the default configuration the IOMMU reads the page table from RAM.
> That's fine, but use the right function.
>
>> So, I
>> have put in the flush call to give the IOMMU a coherent view of the page
>> tables. I realize it is more efficient to just flush that specific part of
>> L2, but this is just the basic version of the driver and that optimization
>> will be eventually put in.
> Here, you're talking about L2 again, but your code only touches the L1
> cache.  I think you're confused about caching.
>
>> What did you mean by:
>>> Any reason you can't have some kind of struct device instead?
>> Are you referring to the clock line? As far as I understand it, the kernel
>> tracks the clocks by a string name, but I can look into it further.
> No.
>
> /**
>   * clk_get - lookup and obtain a reference to a clock producer.
>   * @dev: device for clock "consumer"
>   * @id: clock comsumer ID
>   *
>   * Returns a struct clk corresponding to the clock producer, or
>   * valid IS_ERR() condition containing errno.  The implementation
>   * uses @dev and @id to determine the clock consumer, and thereby
>   * the clock producer.  (IOW, @id may be identical strings, but
>   * clk_get may return different clock producers depending on @dev.)
>
> The intention is that 'id' is specific to each 'dev', and identifies
> the connection on 'dev' that you want the clock for.  It's the
> _consumer's_ name, nothing to do with the clock producer.
>
> There's also clk_get_sys() if you don't have a struct device.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Russell,
Thanks for the information. Getting the clock by the device as you 
suggest should be fine. I believe I have addressed your other comments 
as well. I've sent out a v2 patch. Please let me know what you think.

Thanks
Steve
