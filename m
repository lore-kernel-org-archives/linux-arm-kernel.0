From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 20 Aug 2013 19:31:32 +0200
Subject: [PATCH RFC 1/2] clk: Provide not locked variant of
 of_clk_get_from_provider()
In-Reply-To: <20130819195016.GU23006@n2100.arm.linux.org.uk>
References: <1376066046-16037-1-git-send-email-s.nawrocki@samsung.com>
 <1376066046-16037-2-git-send-email-s.nawrocki@samsung.com>
 <20130819194132.4443.4807@quantum>
 <20130819195016.GU23006@n2100.arm.linux.org.uk>
Message-ID: <5213A7F4.7050200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 09:50 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 19, 2013 at 12:41:32PM -0700, Mike Turquette wrote:
>> Quoting Sylwester Nawrocki (2013-08-09 09:34:05)
>>> Add helper functions for the of_clk_providers list locking and
>>> an unlocked variant of of_clk_get_from_provider().
>>> These functions are intended to be used in the clkdev to avoid
>>> race condition in the device tree based clock look up in clk_get().
>>>
>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Looks good to me.
>>
>> Russell,
>>
>> Any objections?
> 
> Yes.
> 
>>> diff --git a/include/linux/clk.h b/include/linux/clk.h
>>> index 9a6d045..ea6822e 100644
>>> --- a/include/linux/clk.h
>>> +++ b/include/linux/clk.h
>>> @@ -368,6 +368,9 @@ struct of_phandle_args;
>>>  struct clk *of_clk_get(struct device_node *np, int index);
>>>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
>>>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>>> +struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec);
>>> +void of_clk_lock(void);
>>> +void of_clk_unlock(void);
> 
> Here's the thing.  Yes, I know we have a directory called 'include'
> where header files live, but there is nothing layed down which requires
> all header files to be under a directory called 'include' - especially
> when it's stuff which should _not_ be shared with the rest of the
> kernel.
> 
> In this case, these three functions are merely exported from
> drivers/clk/clk.c to drivers/clk/clkdev.c - which is in the very same
> directory.  It is not intended that these functions be used for any
> other purpose.
> 
> So, why not put them in a header file in drivers/clk/ which both these
> files can include?

Yes, that's certainly a good idea. In fact it bothered me a bit that
those functions are unnecessarily exposed like that. But I somehow missed
a separate header could be simply added. Thanks for the suggestion.

I'm going to post v2 of $subject series and the one adding clk_unregister()
implementation including corrections for those couple issues pointed out in
the reviews. Would appreciate to know you opinion on those and perhaps have
your Ack so Mike could take whole series into his tree.

> I *really* wish that people would get out of their mind that everything
> has to live in a header file in include/ or arch/arm/include/ and local
> includes are bad.  Local includes are a very good thing, they aid in
> reducing the visibility of stuff which is not meant to be visible to
> the entire kernel.
> 
> Just look at things like fs/mount.h to see what I mean.  Or the various
> driver header files which contain definitions only for use by their
> associated drivers in the drivers/ subtree.

--
Thanks,
Sylwester
