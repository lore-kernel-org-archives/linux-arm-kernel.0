From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 1 Jul 2015 17:29:13 -0500
Subject: [PATCH] ARM: fix vdsomunge not to depend on glibc specific error.h
In-Reply-To: <20150701222713.GO7557@n2100.arm.linux.org.uk>
References: <559273FD.2030508@arm.com>
 <20150701222713.GO7557@n2100.arm.linux.org.uk>
Message-ID: <559469B9.3000301@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2015 05:27 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 30, 2015 at 11:48:29AM +0100, Szabolcs Nagy wrote:
>> @@ -82,11 +80,25 @@
>>  #define EF_ARM_ABI_FLOAT_HARD 0x400
>>  #endif
>>
>> +static int failed;
>> +static const char *argv0;
>>  static const char *outfile;
>>
>> +static void fail(const char *fmt, ...)
>> +{
>> +	va_list ap;
>> +
>> +	failed = 1;
>> +	fprintf(stderr, "%s: ", argv0);
>> +	va_start(ap, fmt);
>> +	vfprintf(stderr, fmt, ap);
>> +	va_end(ap);
>> +	exit(EXIT_FAILURE);
> 
> What purpose does "failed" serve?  Reading through this patch, it
> seems to be a write-only variable.

It's checked in an atexit handler:

 static void cleanup(void)
 {
-	if (error_message_count > 0 && outfile != NULL)
+	if (failed && outfile != NULL)
 		unlink(outfile);
 }
