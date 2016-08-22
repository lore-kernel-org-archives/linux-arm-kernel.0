From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Mon, 22 Aug 2016 22:07:40 +0800
Subject: [PATCH v1 2/3] of: Add support for reading a s32 from a
 multi-value property.
In-Reply-To: <1471639654.4611.2.camel@infradead.org>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
 <1471315139-28285-3-git-send-email-finley.xiao@rock-chips.com>
 <1471616119.61594.465.camel@infradead.org> <4975010.IL95Y3Sj1J@phil>
 <1471639654.4611.2.camel@infradead.org>
Message-ID: <5e7a7b9f-44c2-82c2-eb17-ee54efd15503@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016/8/20 4:47, David Woodhouse ??:
> On Fri, 2016-08-19 at 22:41 +0200, Heiko Stuebner wrote:
>>> So no, don't *add* any more of these functions. Only add the generic
>>> version. And if your driver isn't using the generic property
>>> functions... fix it.
>> As far as I can see, all the device_property_* functions are grounded on their
>> of_property_*, acpi_property_* etc counterparts and functions reading specific
>> elements (the _index variants) are currently not available at all.
>>
>> drivers/base/property.c:
>> #define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval)                         \
>>          (val) ? of_property_read_##type##_array((node), (propname), (val), (nval))      \
>>                : of_property_count_elems_of_size((node), (propname), sizeof(type))
>>
>> So even if you're using the device_property_* functions you'd still need
>> a match in the underlying functions or am I missing something?
> Yes, but the underlying function should never be used directly by
> drivers. And should probably be prefixed with __ or marked deprecated
> (with an override in its one genuine call site).
>

So can I add a device_property_read_s32_array function in property.h?

--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -108,6 +108,13 @@ static inline int device_property_read_u32(struct 
device *dev,
         return device_property_read_u32_array(dev, propname, val, 1);
  }

+static inline int device_property_read_s32_array(struct device *dev, 
const char *propname,
+                                  s32 *val, size_t nval)
+{
+       return device_property_read_u32_array(struct device *dev, const 
char *propname,
+                                  (u32 *)val, size_t nval);
+}

-- 
Finley
