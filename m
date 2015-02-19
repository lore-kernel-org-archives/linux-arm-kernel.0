From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 19 Feb 2015 20:53:55 +0100
Subject: [PATCH v2 1/2] dma: mmp_dma: add support for legacy transition
In-Reply-To: <54E5BB06.6000106@zonque.org> (Daniel Mack's message of "Thu, 19
 Feb 2015 11:29:26 +0100")
References: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
 <1424205547-15429-1-git-send-email-robert.jarzmik@free.fr>
 <54E5BB06.6000106@zonque.org>
Message-ID: <87mw498yp8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> Hi Robert,
>
> Thanks for pushing this topic :)
> One minor nit:
>
>> +int mmp_pdma_toggle_reserved_channel(int legacy_channel)
>> +{
>> +	if (legacy_unavailable & (1 << legacy_channel))
>> +		return -EBUSY;
>> +	legacy_reserved ^= 1 << legacy_channel;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(mmp_pdma_toggle_reserved_channel);
>
> My concern is that if pxa_request_dma() is called more than once for
> whatever reason by a legacy implementation, the toggled bit mask might
> get out of sync.
This is not possible.
The first call to pxa_request_dma() sets dma_channels[i].name to a non-NULL
value.
The second call to pxa_request_dma() cannot take the same i as
!dma_channels[i].name is not fullfilled.

> As we know exactly on the caller site what we want to achieve, let's make the
> API explicit with something like:
>
> int mmp_pdma_set_reserved_channel(int legacy_channel, bool reserved)
Even if I have no strong opinion about it, I'll let the patch as it is, unless
you really want me to add the reserved parameter, in which case I'll release a
v3.

Cheers.

-- 
Robert
