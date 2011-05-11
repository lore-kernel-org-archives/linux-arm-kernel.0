From: amit.virdi@st.com (Amit Virdi)
Date: Wed, 11 May 2011 14:13:21 +0530
Subject: sleeping function called from invalid context
In-Reply-To: <20110510103256.58d61861@bob.linux.org.uk>
References: <4DC8CF50.4040003@st.com>
	<20110510103256.58d61861@bob.linux.org.uk>
Message-ID: <4DCA4C29.20403@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Alan,

On 5/10/2011 3:02 PM, Alan Cox wrote:
>> On analysis, I found that this is due to the change introduced in
>> tty_ioctl.c where the termios mutex is taken to protect against
>> parallel throttle/unthrottle. Probably IrCOMM stack code wasn't
>> tested before merging this patch.
>>
>> Please suggest what should be done with the IrCOMM protocol stack
>> code to resolve this problem?
>
> It looks like the comments are wrong
>
>          /*
>           * Just give it over to the line discipline. There is no need to
>           * involve the flip buffers, since we are not running in an
>          interrupt
>           * handler
>           */
>
>
> appears to be completely untrue
>
> I suspect it just needs to use the tty_flip_buffer functions properly
> instead of trying to do clever shortcuts
>
>
> 	tty_insert_flip_string(self->tty, skb->data, skb->len);
> 	tty_flip_buffer_push(self->tty);
>
> .
>

I incorporated the change suggested by you and tested the stack again. 
It is working perfectly fine - no stack trace is printed now. I'll be 
sending the patch soon.

Thanks n Regards
Amit Virdi
