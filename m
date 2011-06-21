From: davidb@codeaurora.org (David Brown)
Date: Tue, 21 Jun 2011 15:58:23 -0700
Subject: [PATCH 4/4] ARM: zImage: allow supplementing appended DTB with
	traditional ATAG data
In-Reply-To: <1308632955-11070-5-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Tue, 21 Jun 2011 01:09:15 -0400")
References: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
	<1308632955-11070-5-git-send-email-nico@fluxnic.net>
Message-ID: <8yaliwueqr4.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20 2011, Nicolas Pitre wrote:

> +void *memmove(void *__dest, __const void *__src, size_t __n)
> +{
> +	unsigned char *d = __dest;
> +	const unsigned char *s = __src;
> +
> +	if (__dest == __src)
> +		return __dest;
> +
> +	if (__dest < __src)
> +		return memcpy(__dest, __src, __n);
> +
> +	while (--__n >= 0)
> +		d[__n] = s[__n];
> +
> +	return __dest;
> +}

Ahh, found it.  size_t is unsigned, so the while loop never terminates.
Something like:

	for (; __n; __n--)
		d[__n] = s[__n];

makes that work for me.

This allows me to not need to pad or have any of the chosen attributes.
I do need to have a memory attribute, however, and I'll see if I can
figure out what is happening there.

Fun debugging when the loop overwrites the code itself, but it keeps
working because it is in the cache.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
