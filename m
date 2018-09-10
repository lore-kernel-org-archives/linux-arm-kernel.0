From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 10 Sep 2018 09:04:47 +0100
Subject: [PATCH v2 4/9] ARM: oabi-compat: copy oabi events using
 __copy_to_user()
In-Reply-To: <20180906170417.GT30658@n2100.armlinux.org.uk>
References: <1536251888-8302-1-git-send-email-julien.thierry@arm.com>
 <1536251888-8302-5-git-send-email-julien.thierry@arm.com>
 <20180906170417.GT30658@n2100.armlinux.org.uk>
Message-ID: <e69c823e-282e-d44d-df03-a0a0377df138@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 06/09/18 18:04, Russell King - ARM Linux wrote:
> On Thu, Sep 06, 2018 at 05:38:03PM +0100, Julien Thierry wrote:
>> @@ -294,11 +294,9 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
>>   	ret = sys_epoll_wait(epfd, kbuf, maxevents, timeout);
>>   	set_fs(fs);
>>   	err = 0;
>> -	for (i = 0; i < ret; i++) {
>> -		__put_user_error(kbuf[i].events, &events->events, err);
>> -		__put_user_error(kbuf[i].data,   &events->data,   err);
>> -		events++;
>> -	}
>> +	if (ret > 0)
>> +		err = __copy_to_user(events, kbuf, ret * sizeof(*kbuf));
>> +
> 
> It's not that simple!
> 
> kbuf is of type "struct epoll_event" whereas events is of type
> "struct oabi_epoll_event".  They have different layouts - if they
> were the same, we wouldn't need the OABI shim.
> 

Right, I completely missed the type mismatch... sorry.

I'll fix this.

Thanks,

> struct oabi_epoll_event {
>          __u32 events;
>          __u64 data;
> } __attribute__ ((packed,aligned(4)));
> 
> vs
> 
> struct epoll_event {
>          __poll_t events;
>          __u64 data;
> };
> 
> which results in EABI sizeof(struct epoll_event) being 16 and 12 on
> OABI.  What's more is that 'data' is at offset 4 in OABI, or 8 in
> EABI.
> 
> So, what I think needs to happen is that we need to do something
> like:
> 
> 	struct oabi_epoll_event e;
> 
> 	for (i = 0; i < ret; i++) {
> 		e.events = kbuf[i].events;
> 		e.data = kbuf[i].data;
> 		err = __copy_to_user(events, e, sizeof(e))
> 		if (err)
> 			break;
> 		events++;
> 	}
> 

-- 
Julien Thierry
