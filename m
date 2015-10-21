From: dledford@redhat.com (Doug Ledford)
Date: Wed, 21 Oct 2015 16:58:01 -0400
Subject: [PATCH] IB/core: avoid 32-bit warning
In-Reply-To: <1444225608.3188.67.camel@opteya.com>
References: <17269152.DqJfCm1LOx@wuerfel>
 <56151BDF.8010504@dev.mellanox.co.il> <1444225608.3188.67.camel@opteya.com>
Message-ID: <5627FC59.4070502@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2015 09:46 AM, Yann Droneaud wrote:
> Hi,
> 
> Le mercredi 07 octobre 2015 ? 16:19 +0300, Sagi Grimberg a ?crit :
>> On 10/7/2015 3:29 PM, Arnd Bergmann wrote:
>>> The INIT_UDATA() macro requires a pointer or unsigned long argument
>>> for
>>> both input and output buffer, and all callers had a cast from when
>>> the code was merged until a recent restructuring, so now we get
>>>
>>> core/uverbs_cmd.c: In function 'ib_uverbs_create_cq':
>>> core/uverbs_cmd.c:1481:66: warning: cast to pointer from integer of
>>> different size [-Wint-to-pointer-cast]
>>>
>>> This makes the code behave as before by adding back the cast to
>>> unsigned long.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Fixes: 565197dd8fb1 ("IB/core: Extend ib_uverbs_create_cq")
>>>
>>> diff --git a/drivers/infiniband/core/uverbs_cmd.c
>>> b/drivers/infiniband/core/uverbs_cmd.c
>>> index be4cb9f04be3..88b3b78340f2 100644
>>> --- a/drivers/infiniband/core/uverbs_cmd.c
>>> +++ b/drivers/infiniband/core/uverbs_cmd.c
>>> @@ -1478,7 +1478,7 @@ ssize_t ib_uverbs_create_cq(struct
>>> ib_uverbs_file *file,
>>>   	if (copy_from_user(&cmd, buf, sizeof(cmd)))
>>>   		return -EFAULT;
>>>
>>> -	INIT_UDATA(&ucore, buf, cmd.response, sizeof(cmd),
>>> sizeof(resp));
>>> +	INIT_UDATA(&ucore, buf, (unsigned long)cmd.response,
>>> sizeof(cmd), sizeof(resp));
>>
>> Would it make sense to cast inside INIT_UDATA() and not have callers
>> worry about it?
> 
> It's ... complicated. See INIT_UDATA_BUF_OR_NULL().
> 
> Awayway, I have patch to do the opposite, eg. explicitly cast u64 value
> to (void __user *)(unsigned long) in the caller function instead, as it
> allows some safer / new operations on the response buffer.
> 
> Regards.
> 

I haven't seen this oether patch that Yann is talking about, so I've
taken this one.

-- 
Doug Ledford <dledford@redhat.com>
              GPG KeyID: 0E572FDD


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 884 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151021/71b41919/attachment-0001.sig>
