From: salyzyn@android.com (Mark Salyzyn)
Date: Wed, 16 Aug 2017 12:25:41 -0700
Subject: [PATCH 2/2] arm64: compat: Add CONFIG_KUSER_HELPERS
In-Reply-To: <20170815133839.GE12294@arm.com>
References: <20170804183151.78804-1-salyzyn@android.com>
 <20170815133839.GE12294@arm.com>
Message-ID: <34ad3ba0-9397-1799-1688-bc647e1e92b2@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Started working on rebasing the entire set based on your comments, and 
to retest with a larger set of changes I have in my private branch. I 
had four queries regarding the requested changes that may affect the 
outcome; all in this patch.

On 08/15/2017 06:38 AM, Will Deacon wrote:
>> +
>> +	  Say N here only if you are absolutely certain that you do not need
>> +	  these helpers; otherwise, the safe option is to say Y.
> I think we should default this to 'N' for arm64.
This would introduce engineering churn on defconfig updates to the 
subset of the 8000 Android devices that are arm64 based. We have yet to 
find a means to actually turn off the KUSER helpers yet and abandon the 
large number of armv7 and earlier applications. For non Android use, I 
agree whole heartedly, but can not bring myself to do so. It is there by 
default, and we are offering a means to turn it off for those that want 
the security.

So I am pushing back ...
>
>> diff --git a/arch/arm64/kernel/sigreturn32.S b/arch/arm64/kernel/sigreturn32.S
>> new file mode 100644
>> index 000000000000..6ecda4d84cd5
>> --- /dev/null
>> +++ b/arch/arm64/kernel/sigreturn32.S
> Why do we need a new file for these?

Less ifdefs, more arm64-obj-$(CONFIG_KUSER_HELPERS) and (for a future 
patch) arm64-obj-$(CONFIG_VDSO32-y).

It is also confusing that sigreturn32 and kuser32 could be switched off 
separately, and in this specific case, using an ifdef, having all 
kuser32 stuff wiped from the file and yet it remains to hold _unrelated_ 
sigreturn32 content.

>> +
>> +	/*
>> +	 * ARM Code
>> +	 */
>> +	// mov	r7, #__NR_compat_sigreturn
>> +	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3
>> +	// svc	#__NR_compat_sigreturn
>> +	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef
> If there is a good reason to have this in a new file, why reformat the stuff
> at the same time? This looks like more churn.
checkpatch.pl did not like the new file, so I wrapped the comments to 
proceed the .byte's to suppress a large amount of 80-character limit 
warnings. No good deed goes unpunished.
> I have a feeling that there's a nice concise patch set in this lot that's
> trying to get out ;)

In answer to the above three, could split out into a separate patch, the 
splitting of sigreturn32 and kuser32, would that feel better and more 
concise?
> Will

-- Mark
