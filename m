From: davidb@codeaurora.org (David Brown)
Date: Tue, 21 Jun 2011 16:13:35 -0700
Subject: [PATCH 4/4] ARM: zImage: allow supplementing appended DTB with
	traditional ATAG data
In-Reply-To: <8yaliwueqr4.fsf@huya.qualcomm.com> (David Brown's message of
	"Tue, 21 Jun 2011 15:58:23 -0700")
References: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
	<1308632955-11070-5-git-send-email-nico@fluxnic.net>
	<8yaliwueqr4.fsf@huya.qualcomm.com>
Message-ID: <8ya7h8edbhc.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21 2011, David Brown wrote:

> On Mon, Jun 20 2011, Nicolas Pitre wrote:
>
>> +void *memmove(void *__dest, __const void *__src, size_t __n)
>> +{
>> +	unsigned char *d = __dest;
>> +	const unsigned char *s = __src;
>> +
>> +	if (__dest == __src)
>> +		return __dest;
>> +
>> +	if (__dest < __src)
>> +		return memcpy(__dest, __src, __n);
>> +
>> +	while (--__n >= 0)
>> +		d[__n] = s[__n];
>> +
>> +	return __dest;
>> +}
>
> Ahh, found it.  size_t is unsigned, so the while loop never terminates.
> Something like:
>
> 	for (; __n; __n--)
> 		d[__n] = s[__n];

Ugh.  How about if I don't replace a broken version with a different
broken version.

	while (__n) {
		__n--;
                d[__n] = s[__n];
	}

Now, I don't need any extra fields in my DTB, and it correctly inserts
the ATAG values.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
