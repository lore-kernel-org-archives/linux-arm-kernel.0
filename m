From: imp@bsdimp.com (Warner Losh)
Date: Tue, 21 Jun 2011 17:22:40 -0600
Subject: [PATCH 4/4] ARM: zImage: allow supplementing appended DTB with
	traditional ATAG data
In-Reply-To: <8ya7h8edbhc.fsf@huya.qualcomm.com>
References: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
	<1308632955-11070-5-git-send-email-nico@fluxnic.net>
	<8yaliwueqr4.fsf@huya.qualcomm.com>
	<8ya7h8edbhc.fsf@huya.qualcomm.com>
Message-ID: <4ED56748-F76F-4A42-AFC2-76CF2099F1CA@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 21, 2011, at 5:13 PM, David Brown wrote:

> On Tue, Jun 21 2011, David Brown wrote:
> 
>> On Mon, Jun 20 2011, Nicolas Pitre wrote:
>> 
>>> +void *memmove(void *__dest, __const void *__src, size_t __n)
>>> +{
>>> +	unsigned char *d = __dest;
>>> +	const unsigned char *s = __src;
>>> +
>>> +	if (__dest == __src)
>>> +		return __dest;
>>> +
>>> +	if (__dest < __src)
>>> +		return memcpy(__dest, __src, __n);
>>> +
>>> +	while (--__n >= 0)
>>> +		d[__n] = s[__n];
>>> +
>>> +	return __dest;
>>> +}
>> 
>> Ahh, found it.  size_t is unsigned, so the while loop never terminates.
>> Something like:
>> 
>> 	for (; __n; __n--)
>> 		d[__n] = s[__n];
> 
> Ugh.  How about if I don't replace a broken version with a different
> broken version.
> 
> 	while (__n) {
> 		__n--;
>                d[__n] = s[__n];
> 	}
> 
> Now, I don't need any extra fields in my DTB, and it correctly inserts
> the ATAG values.


while (__n--)
	d[__n] = s[__n];

does the same thing, and is more readable (and does the same thing as the original while())

Warner
