From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 2 Jul 2018 18:59:11 +0200
Subject: [RFC net-next 05/15] HACK: net: lora: Deal with .poll_mask in
 4.18-rc2
In-Reply-To: <20180702162238.GB2737@nanopsycho.orion>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-6-afaerber@suse.de>
 <20180702162238.GB2737@nanopsycho.orion>
Message-ID: <c6103f26-df33-cf50-d1c1-0a00f6b61c5a@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.07.2018 um 18:22 schrieb Jiri Pirko:
> Sun, Jul 01, 2018 at 01:07:54PM CEST, afaerber at suse.de wrote:
>> linux-next and 4.18-rc2 both identify as LINUX_VERSION(4,18,0), but
>> commit a11e1d432b51f63ba698d044441284a661f01144 (Revert changes to
>> convert to ->poll_mask() and aio IOCB_CMD_POLL) reverted .poll_mask
>> to .poll again.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>> net/lora/dgram.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/net/lora/dgram.c b/net/lora/dgram.c
>> index 4d931fd3778a..ef56fd90e762 100644
>> --- a/net/lora/dgram.c
>> +++ b/net/lora/dgram.c
>> @@ -217,7 +217,11 @@ const struct proto_ops dgram_proto_ops = {
>> 	.socketpair	= sock_no_socketpair,
>> 	.accept		= sock_no_accept,
>> 	.getname	= dgram_getname,
>> +#if 0 /* LINUX_VERSION_CODE >= LINUX_VERSION(4, 18, 0) */
>> +	.poll_mask	= datagram_poll_mask,
>> +#else
> 
> I guess that you sent this patch by mistake...

No mistake, it's clearly marked as "HACK", and the cover letter states
this is not for merging but for the design discussion. You wanted to see
patches for discussing the topic, so I sent you my current draft.

On my development machine with -rc2 I still use .poll_mask. I will be
able to drop the patch once we have -rc3 built, unless .poll_mask gets
reintroduced later in the cycle. If you know of some macro to check
whether we're -rc2 or -rc3 of 4.18 I'm all ears, otherwise grep'ing in
the Makefile and defining some custom macro would be an alternative.

Some other places in this series have similar, not-commented-out
compatibility code to allow me to test individual modules quickly
without having to build and boot a full kernel for every change. Like
some sk function got/lost a parameter at some point. Originally I kept
compatibility with openSUSE Leap 42.3's 4.4 kernel, now 15.0's 4.12.

https://github.com/afaerber/lora-modules has a Makefile and load.sh
script for that purpose, plus a small C example to send a packet.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
