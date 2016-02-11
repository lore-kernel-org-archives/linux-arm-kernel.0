From: harba@codeaurora.org (Abdulhamid, Harb)
Date: Wed, 10 Feb 2016 22:22:00 -0500
Subject: [PATCH V1 6/6] acpi: apei: handle SEA notification type for ARMv8
In-Reply-To: <20160210180332.GU1052@arm.com>
References: <1454699608-22760-1-git-send-email-tbaicar@codeaurora.org>
 <1454699608-22760-7-git-send-email-tbaicar@codeaurora.org>
 <20160210180332.GU1052@arm.com>
Message-ID: <56BBFE58.7020007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/10/2016 1:03 PM, Will Deacon wrote:
> On Fri, Feb 05, 2016 at 12:13:28PM -0700, Tyler Baicar wrote:

>> +#else /* CONFIG_HAVE_ACPI_APEI_SEA */
>> +static inline int ghes_sea_add(struct ghes *ghes)
>> +{
>> +	pr_err(GHES_PFX "ID: %d, trying to add SEA notification which is not supported\n",
>> +	       ghes->generic->header.source_id);
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline void ghes_sea_remove(struct ghes *ghes)
>> +{
>> +	pr_err(GHES_PFX "ID: %d, trying to remove SEA notification which is not supported\n",
>> +	       ghes->generic->header.source_id);
>> +}
> 
> Why are these getting called if !CONFIG_HAVE_ACPI_APEI_SEA?
> 
This was added to catch firmware bugs (i.e. bad ACPI tables).  Since
"SEA" is a valid GHES notify type in ACPI, it's just a number in an ACPI
table.  If someone incorrectly set SEA as their notify type in their
HEST table on an Intel system, this would catch that error here.

We may do this with less code by getting rid of the #else (as you
suggest), but we need to add #ifdefs to eliminate the calls to
ghes_sea_add and ghes_sea_remove to avoid compiler errors.  Does the
below change look better?

>>@@ -1093,6 +1168,11 @@ static int ghes_probe(struct platform_device
>>*ghes_dev)
>> 		list_add_rcu(&ghes->list, &ghes_sci);
>> 		mutex_unlock(&ghes_list_mutex);
>> 		break;
>>

+#ifdef CONFIG_HAVE_ACPI_APEI_SEA

>>+	case ACPI_HEST_NOTIFY_SEA:
>>+		rc = ghes_sea_add(ghes);
>>+		if (rc)
>>+			goto err_edac_unreg;
>>+		break;

+#endif

...

>>@@ -1135,6 +1215,9 @@ static int ghes_remove(struct platform_device
>>*ghes_dev)
>> 			>>unregister_acpi_hed_notifier(&ghes_notifier_sci);
>> 		mutex_unlock(&ghes_list_mutex);
>> 		break;


+#ifdef CONFIG_HAVE_ACPI_APEI_SEA

>>+	case ACPI_HEST_NOTIFY_SEA:
>>+		ghes_sea_remove(ghes);
>>+		break;

+#endif

Harb
-- 
Qualcomm Technologies, Inc.
on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
