From: loic.pallardy@st.com (Loic PALLARDY)
Date: Fri, 21 Dec 2012 11:50:01 +0100
Subject: [PATCH 4/9] mailbox: create opened message type
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC9CE7A@DBDE01.ent.ti.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-5-git-send-email-loic.pallardy-ext@stericsson.com>
 <B5906170F1614E41A8A28DE3B8D121433EC9CE7A@DBDE01.ent.ti.com>
Message-ID: <50D43ED9.4030906@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/21/2012 11:28 AM, Bedia, Vaibhav wrote:
> On Tue, Dec 18, 2012 at 18:40:07, Loic Pallardy wrote:

>> -	msg = mbox_read_reg(fifo->data);
>> -	msg |= ((mbox_msg_t) mbox_read_reg(fifo->cmd))<<  16;
>> +	msg->header = mbox_read_reg(fifo->data);
>> +	msg->header |= ((mbox_msg_t) mbox_read_reg(fifo->cmd))<<  16;
>
> Now that struct mailbox_msg encapsulates the data, you can
> get rid of the mbox_msg_t typedef completely. Having the data
> as part of the mailbox_msg along with the functions with mbox_msg_t
> as the return type just creates confusion IMHO.
>
OK I'll clean up mbox_msg_t typedef.
>>
>> -	return msg;
>> +	return 0;
>>   }
>
> Convert all return 0 functions to void?
>
> [...]
>
Yes, agree I'll change the prototype.
>>
>> +
>> +#define MAILBOX_FILL_HEADER_MSG(_msg, _header) \
>> +	MAILBOX_FILL_MSG(_msg, _header, NULL, 0);
>> +
>
> I used these patches as part of the suspend-resume support for AM335x
> which has the same mailbox IP as OMAP4. I used the MAILBOX_FILL_HEADER_MSG
> helper and things work as expected.

Nice.
>
> However, I found the 'header' part to be very confusing. Why not treat the
> OMAP case as a special case of the new MAILBOX_FILL_MSG where the data size
> is set to 1?

Yes it is another possibility. Changes are not big.
Omar, what's your view on this point?

Regards,
Loic
>
> Regards,
> Vaibhav
