From: rdunlap@infradead.org (Randy Dunlap)
Date: Tue, 8 May 2018 23:01:12 -0700
Subject: [PATCH 3/4] coresight: allow to build as modules
In-Reply-To: <20180508153756.09f6fa8066bc23a0d11ec670@arm.com>
References: <20180508140650.c070e6aa0eb1a6690e6d9607@arm.com>
 <f299d0be-f1a6-46ca-3d8a-13d7d89a007d@infradead.org>
 <20180508153756.09f6fa8066bc23a0d11ec670@arm.com>
Message-ID: <3826d737-c180-7b9e-8013-be54f6d7302d@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2018 01:37 PM, Kim Phillips wrote:
> On Tue, 8 May 2018 12:31:08 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Hi,
> 
> Hi,

>>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
>>> index 3ffc9feb2d64..8c49c7b82d84 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
>>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
>>> @@ -54,7 +54,7 @@ struct etm_filters {
>>>  };
>>>  
>>>  
>>> -#ifdef CONFIG_CORESIGHT
>>> +#if IS_ENABLED(CONFIG_CORESIGHT)
>>
>> Have you found (observed) that this change (above) is necessary (and others
>> like it below)?  I thought that they would be equivalent.
>>
>> From include/linux/kconfig.h:
>> /*
>>  * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
>>  * 0 otherwise.
>>  */
>> #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
>>
>>
>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
>>> index f1d0e21d8cab..335bca44b42d 100644
>>> --- a/drivers/hwtracing/coresight/coresight-priv.h
>>> +++ b/drivers/hwtracing/coresight/coresight-priv.h
>>
>>> @@ -143,7 +149,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
>>>  				       struct coresight_device *sink);
>>>  void coresight_release_path(struct list_head *path);
>>>  
>>> -#ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
>>> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
>>
>> ditto.
>>
>>>  extern int etm_readl_cp14(u32 off, unsigned int *val);
>>>  extern int etm_writel_cp14(u32 off, u32 val);
>>>  #else
>>
>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>> index d950dad5056a..5863eb1a7335 100644
>>> --- a/include/linux/coresight.h
>>> +++ b/include/linux/coresight.h
>>> @@ -243,7 +243,7 @@ struct coresight_ops {
>>>  	const struct coresight_ops_source *source_ops;
>>>  };
>>>  
>>> -#ifdef CONFIG_CORESIGHT
>>> +#if IS_ENABLED(CONFIG_CORESIGHT)
>>
>> ditto.
> 
> If I revert all three IS_ENABLED back to plain #ifdefs, and rebuild with
> CONFIG_CORESIGHT*=m, I get:
> 

[build errors deleted]

> 
> Building CORESIGHT=y builds ok, so, building it as a module causes the
> latter stubs to be compiled:
> 
> #ifdef CONFIG_CORESIGHT
> extern struct coresight_device *
> coresight_register(struct coresight_desc *desc);
> extern void coresight_unregister(struct coresight_device *csdev);
> extern int coresight_enable(struct coresight_device *csdev);
> extern void coresight_disable(struct coresight_device *csdev);
> extern int coresight_timeout(void __iomem *addr, u32 offset,
>                              int position, int value);
> #else
> static inline struct coresight_device *
> coresight_register(struct coresight_desc *desc) { return NULL; }
> static inline void coresight_unregister(struct coresight_device *csdev) {}
> static inline int
> coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
> static inline void coresight_disable(struct coresight_device *csdev) {}
> static inline int coresight_timeout(void __iomem *addr, u32 offset,
>                                      int position, int value) { return 1; }
> #endif
> 
> Adding kconfig.h to coresight.h's #include list doesn't help.  So we
> need the IS_ENABLED for its __or(..., IS_MODULE()) case.

<linux/kconfig.h> is automatically #included by the top-level Makefile,
so adding it again would not help any. ;)

> That being said, I don't know of any outside kernel-build dependencies
> coresight.h might have.

OK, using
#if IS_ENABLED(CONFIG_CORESIGHT)
is fine.  This is just the current/modern way of saying:
#if defined(CONFIG_CORESIGHT) || defined(CONFIG_CORESIGHT_MODULE)

There are several hundred instances of that latter form in the kernel tree.

thanks,
-- 
~Randy
