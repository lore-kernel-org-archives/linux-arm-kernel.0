From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 8 Nov 2017 11:58:42 -0500
Subject: [PATCH V2 2/3] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <e673a03d-1707-fe4a-7f5d-df1466981893@codeaurora.org>
References: <1510158582-5343-1-git-send-email-okaya@codeaurora.org>
 <1510158582-5343-2-git-send-email-okaya@codeaurora.org>
 <e673a03d-1707-fe4a-7f5d-df1466981893@codeaurora.org>
Message-ID: <c55ecc2c-332c-e9e6-c74c-3c67fd2ab89a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/8/2017 11:49 AM, Timur Tabi wrote:
> On 11/08/2017 10:29 AM, Sinan Kaya wrote:
>> +#define HIDMA_MAX_DEV_MATCH 10
>> +
>> +struct hidma_cap {
>> +??? const struct of_device_id of[HIDMA_MAX_DEV_MATCH];
>> +??? const struct acpi_device_id acpi[HIDMA_MAX_DEV_MATCH];
>> +};
> 
> This seems wrong.? You're defining an array of size 10, but it only has three elements.? And the third element is a sentinel, which is typically used to avoid specifying the size of the array.
> 

It is true that I define an array of size 10. It is just some arbitrary number
with forward thinking. I don't really have to use it to the maximum today as long
as I satisfy the calling conventions.

What is important is that the of_device_match() and acpi_device_match() functions
will stop searching only if they find an empty element. The {} element.

That's the calling semantics of of_device_match() and acpi_device_match().

Besides, C compiler also won't let me put two arrays together like this.

struct my_struct {
	struct some_struct array1[]
	struct some_struct array2[]
}

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
